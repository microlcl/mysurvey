package com.eastteam.myprogram.utils;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Question;

public class ExcelHandler {

static public boolean doExprt(List<Question> questions,List<Answer> answers,OutputStream out) throws SQLException {
		
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
		headFont.setColor(HSSFColor.VIOLET.index);  
		headFont.setFontHeightInPoints((short) 12);  
		headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
        headStyle.setFont(headFont);
        
        //set body font and body style
        HSSFCellStyle bodyStyle = workbook.createCellStyle();
        HSSFFont bodyFont = workbook.createFont();
        bodyStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
        bodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        bodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        bodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
        bodyFont.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);  
        bodyStyle.setFont(bodyFont);
		
        HSSFRow headRow = sheet.createRow(0);
        HSSFCell cell;
        
        //create table head
        for (int i = 0; i < questions.size(); i++) {
        	cell = headRow.createCell(i);
        	cell.setCellStyle(headStyle);
        	HSSFRichTextString text = new HSSFRichTextString(questions.get(i).getQuestion());
        	cell.setCellValue(text);
        }
        
        int rowIndex = 1;
        HSSFRow bodyRow;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        for(int i = 0; i < answers.size(); i++) {
        	
        	bodyRow = sheet.createRow(rowIndex);
        	rowIndex ++;
        	
        	/*for (int curCol = 0; curCol < rsmd.getColumnCount(); curCol++) {
        		
        		HSSFCell bodyCell = bodyRow.createCell(curCol);
        		bodyCell.setCellStyle(bodyStyle);
        		if (rsmd.getColumnName(curCol+1).toLowerCase().contains("date")){
        			//if date
        			Date date = resultSet.getDate(curCol + 1);
        			if (date != null)
        				bodyCell.setCellValue(simpleDateFormat.format(date));
        		} else {
        			String string = (String)resultSet.getObject(curCol + 1);
        			if (string == null)
        				string = "N/A";
        			bodyCell.setCellValue(string.trim());
        		}
        	}*/  	
        }
		
        try {
			workbook.write(out);
			//where is close method?
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} finally {
			
		}
        
		return true;
	}

}
