/**
 * 
 */
package com.eastteam.myprogram.web.myGroup;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.util.TempFile;
import org.hibernate.mapping.Array;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.GroupMember;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.myGroup.MyGroupService;
import com.eastteam.myprogram.service.paper.PaperService;

/**
 * @author LSS
 *
 */
@Controller
@RequestMapping (value = "/myGroup")
public class MyGroupController {
	@Autowired
	private MyGroupService myGroupService;
	
	private static Logger logger = LoggerFactory.getLogger(PaperService.class);
	
	@RequestMapping (value = "list", method = RequestMethod.GET)
	public String list(Model model, ServletRequest request,HttpSession session){
		User user=(User) session.getAttribute("user");
		List<Group> groups = myGroupService.search(user.getId());
		model.addAttribute("groups", groups);
		return "myGroup/list";
	}
	
	@RequestMapping(value = "saveGroup", method = RequestMethod.POST)
	public String saveGroup(@ModelAttribute Group group, RedirectAttributes redirectAttributes,HttpSession session){
		User user = (User)session.getAttribute("user");
		group.setCreater(user);
		myGroupService.saveGroup(group);
		return "redirect:/myGroup/list";
	}
	
	
	@RequestMapping(value = "toUpdateGroup/{id}", method = RequestMethod.GET)
	public String toUpdateGroup(@PathVariable("id") String id, Model model) {
		Group selectedGroup=myGroupService.getSelectedGroup(Long.parseLong(id));
		model.addAttribute("group", selectedGroup);
		return "myGroup/updateGroup";
	}
	
	
	@RequestMapping(value = "updateGroup", method = RequestMethod.POST)
	public String updateGroup(@ModelAttribute Group group, RedirectAttributes redirectAttributes,HttpSession session,ServletRequest request) {
		group.setGitems();
		List<String[]> gitems=group.getGitems();
		List<GroupMember> groupMembers =new ArrayList<GroupMember>();
		for(String [] gitem : gitems){
			GroupMember groupMember=new GroupMember();
			groupMember.setGroupId(group.getId());
			groupMember.setNickName(gitem[0]);
			groupMember.setUserId(gitem[1]);
			groupMembers.add(groupMember);
		}
		if(request.getAttribute("state").equals("0")){
			myGroupService.updateGroup(group);
			myGroupService.insertRelatedMembers(groupMembers);
		}else{
			myGroupService.updateGroup(group);
			myGroupService.updateRelatedMembers(groupMembers);
		}
		
		return "redirect:/myGroup/list";
	}
	
	
	@RequestMapping(value = "importGroup", method = RequestMethod.POST)
	public String importGroup(@ModelAttribute Group group,MultipartFile CSVfile, ServletRequest request) {	
		Boolean importFlag = myGroupService.importGroup(CSVfile,group);	
		if (importFlag == false) {
			request.setAttribute("errorMessage", "CSV文件内容不符合规范,请从新选择");
		}		
		return "myGroup/updateGroup";
	}
	
	@RequestMapping(value = "deleteGroup/group_{id}", method = RequestMethod.GET)
	public String deleteQuestion(@PathVariable("id") String id,  RedirectAttributes redirectAttributes){
		myGroupService.deleteGroup(Long.parseLong(id));
		return "redirect:/myGroup/list/";
	}
	
}
