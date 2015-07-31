package com.eastteam.myprogram.utils;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.web.survey.SurveyController;

public class ExcelHandler {
	
	static public boolean doExprt(boolean isAnonymous,List<Question> questions,Map<String, List<Answer>> answers,OutputStream out, Map<String, Group> receivers) throws SQLException {
	
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet();
		sheet.setDefaultColumnWidth(15);
		
		//set title font and title style
		HSSFCellStyle headStyle = workbook.createCellStyle();
		HSSFFont headFont = workbook.createFont();  
		headStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);  
		headStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
		headStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
		headStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
		headStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);  
		headStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);  
		headStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);  	
		headStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		headStyle.setWrapText(true);
		headFont.setColor(HSSFColor.VIOLET.index);  
		headFont.setFontHeightInPoints((short) 12);  
		headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
        headStyle.setFont(headFont);
        
        //set body font and body style
        HSSFCellStyle bodyStyle = workbook.createCellStyle();
        HSSFFont bodyFont = workbook.createFont();
        /*bodyStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
        bodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        bodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
        bodyFont.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);  */
        bodyStyle.setFont(bodyFont);
		
        HSSFRow headRow = sheet.createRow(0);
        HSSFCell cell;
        
        cell = headRow.createCell(0);
        cell.setCellStyle(headStyle);
    	HSSFRichTextString text = new HSSFRichTextString("User ID");
    	cell.setCellValue(text);
    	cell = headRow.createCell(1);
    	cell.setCellStyle(headStyle);
    	text = new HSSFRichTextString("Group");
    	cell.setCellValue(text);
    	
        //create table head
        for (int i = 0; i < questions.size(); i++) {
        	cell = headRow.createCell(i+2);
        	cell.setCellStyle(headStyle);
        	String questionoption = questions.get(i).getQuestionOptions();
        	if (questionoption != null && questionoption !="") {
        		String[] optionsArr = questionoption.split("\\^");
        		questionoption = "";
        		for(int j = 0 ; j<optionsArr.length ; j++) {
        			questionoption += "\n" + (j+1) + "." + optionsArr[j];
        		}
        	}
        	text = new HSSFRichTextString(questions.get(i).getQuestion()+questionoption);
        	cell.setCellValue(text);
        }
        
        int rowIndex = 1;
        HSSFRow bodyRow;
    	Iterator<List<Answer>> iterator = answers.values().iterator();
    	
    	while (iterator.hasNext()) {
    		
    		bodyRow = sheet.createRow(rowIndex);
        	rowIndex ++;
    		
    		HSSFCell bodyCell;
    		int curCol = 0;
    		List<Answer> answerList = iterator.next();
    		
    		bodyCell = bodyRow.createCell(curCol);
    		bodyCell.setCellStyle(bodyStyle);
    		bodyCell.setCellValue(isAnonymous?"Anonymous":answerList.get(0).getUserId());
    		curCol ++;
    		bodyCell = bodyRow.createCell(curCol);
    		bodyCell.setCellStyle(bodyStyle);
    		if (receivers != null) {
    			bodyCell.setCellValue(receivers.get(answerList.get(0).getUserId()).getGroupName());
    			receivers.remove(answerList.get(0).getUserId());
    		} else {
    			bodyCell.setCellValue("None");
    		}
    		
    		
    		curCol ++;
    		
    		for (Question question : questions) {
    			for (Answer answer : answerList) {
    				if (answer.getQuestionId().equals(question.getId())) {
    					
    					bodyCell = bodyRow.createCell(curCol);
                		bodyCell.setCellStyle(bodyStyle);
                		bodyCell.setCellValue(answer.getAnswer() == null? "" : answer.getAnswer());
                		
                		break;
    				}
    			}
    			curCol ++;
    		}
    	}
		if (receivers != null && receivers.size() != 0) {
			Iterator it = receivers.keySet().iterator();
	    	while(it.hasNext()) {
	    		bodyRow = sheet.createRow(rowIndex);
	        	rowIndex ++;
	        	HSSFCell bodyCell;
	    		int curCol = 0;
	    		bodyCell = bodyRow.createCell(curCol);
	    		bodyCell.setCellStyle(bodyStyle);
	    		String key = it.next().toString();
	    		bodyCell.setCellValue(isAnonymous?"Anonymous":key);
	    		curCol ++;
	    		bodyCell = bodyRow.createCell(curCol);
	    		bodyCell.setCellStyle(bodyStyle);
	    		bodyCell.setCellValue(isAnonymous?"***":receivers.get(key).getGroupName());
	    	}
		}
    	
        try {
        	
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} finally {
			
		}
        
		return true;
	}

}
