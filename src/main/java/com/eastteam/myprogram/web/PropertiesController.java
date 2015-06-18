package com.eastteam.myprogram.web;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;

/**
 * Controller里面如果需要读取配置信息，继承此Class
 */
public class PropertiesController {
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	public int getListPageSize() {
		return Integer.parseInt(configProperties.getProperty("list.pagesize"));
	}
	
	public String getMediaDomain() {
		return configProperties.getProperty("media.domain");		 
	}
	
	public int getMediaPageSize() {
		return Integer.parseInt(configProperties.getProperty("media.pic.pagesize"));
	}
	
	public String getPicLargeFolder() {
//		media.pic.large.path=/plupload/files/large
		return configProperties.getProperty("media.pic.large.path");
	}
	
	public String getPicSmallFolder() {
//		media.pic.large.path=/plupload/files/large
		return configProperties.getProperty("media.pic.small.path");
	}
	
	public String getAudioPath() {
		return configProperties.getProperty("media.audio.path");
	}
	
	public String getAttachmentPath() {
		return configProperties.getProperty("attachment.path");
	}
	
	public String getUploadPath() {
		return configProperties.getProperty("upload.path");
	}
	
	public String getAudioBaseURL() {
		return getMediaDomain() + getAudioPath();
	}
	
	public String getSmallPicBaseURL() {
		return getMediaDomain() + getPicSmallFolder();
	}

	public String getLargePicBaseURL() {
		return getMediaDomain() + getPicLargeFolder();
	}
	
	protected void setMediaAttribute(Model model) {
		model.addAttribute("mediaDomain", getMediaDomain());
		model.addAttribute("smallPicBaseURL", getSmallPicBaseURL());
		model.addAttribute("largePicBaseURL", getLargePicBaseURL());
		model.addAttribute("audioBaseURL", getAudioBaseURL());
	}
	
	protected String getAppPath() {
		return configProperties.getProperty("AppPath");
	}
	
	protected String getEmailSystemName() {
		return configProperties.getProperty("SystemEmail");
	}
	
	protected String getEmailSystemPassword() {
		return configProperties.getProperty("SystemEmailPassword");
	}
	
	protected String getEmailSTPM() {
		return configProperties.getProperty("SystemEmailSTMP");
	}
}
