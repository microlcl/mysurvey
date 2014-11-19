package com.eastteam.myprogram.service.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.ehcache.Cache;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.CategoryMybatisDao;
import com.eastteam.myprogram.entity.Category;
import com.eastteam.myprogram.entity.CategoryLiteBean;
import com.google.common.collect.Lists;

@Component
@Transactional
public class CategoryService {
	
	private static Logger logger = LoggerFactory.getLogger(CategoryService.class);
	
	@Autowired
	private CategoryMybatisDao categoryDao;
	
	@Autowired
	private Cache myCache;
	
	public List<Category> search() {
		return categoryDao.search();
	}
	
	public void save(Category category) {
		String id = category.getId();
		if (isExist(id)) {
			this.categoryDao.update(category);
			logger.info("update category with id= {} finished.", id);
		} else {
			this.categoryDao.insert(category);
			logger.info("insert category with id= {} finished.", id);
		}
	} 
	
	public String getNextSubId(String pid) {
		int lenght = pid.length();
		Map params = new HashMap();
		params.put("pid", pid);
		params.put("pos", lenght + 2);
		String maxSubId = this.categoryDao.getMaxSubId(params);
		if (StringUtils.isBlank(maxSubId)) {
			return pid + "-1";
		}
		String seq = StringUtils.substringAfterLast(maxSubId, "-");
		int nexID = Integer.parseInt(seq) + 1;		
		return pid + "-" + nexID;
	}
	
	private boolean isExist(String id) {
		return this.categoryDao.getCount(id) > 0;
	}
	
	public void delete(String id) {
		this.categoryDao.delete(id);
	} 
	
	/**
	 * 提供给Comobotree使用，根据functionId动态产生分类下拉菜单
	 * @param moduleId
	 * @return
	 */
	public List<CategoryLiteBean> getFuntionCategorys(String functionId) {
		
		List<CategoryLiteBean> functionCategorys = categoryDao.getFunctionCategorys(functionId);
		List<CategoryLiteBean> categoryList = Lists.newArrayList();
		for(CategoryLiteBean functionCategory : functionCategorys) {
			CategoryLiteBean category = categoryDao.getAll(functionCategory.getId());
			categoryList.add(category);
		}
		return categoryList;
	}
	
	/**
	 * 提供给combobox（下拉列表）使用，根据functionId动态产生下拉菜单
	 * @param moduleId
	 * @return
	 */
	public List<CategoryLiteBean> getFuntionCategorysForList(String functionId) {
		
		List<CategoryLiteBean> functionCategorys = categoryDao.getFunctionCategorys(functionId);
		List<CategoryLiteBean> categoryList = Lists.newArrayList();
		for(CategoryLiteBean functionCategory : functionCategorys) {
			List<CategoryLiteBean> firstLevelChildren = categoryDao.getFirstLevelChildren(functionCategory.getId());
			categoryList.addAll(firstLevelChildren);
		}
		return categoryList;
	}
}
