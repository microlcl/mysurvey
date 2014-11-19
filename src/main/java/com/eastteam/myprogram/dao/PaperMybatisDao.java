/**
 * 
 */
package com.eastteam.myprogram.dao;

import java.util.List;
import java.util.Map;

import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;


/**
 * @author LSS
 *
 */

@MyBatisRepository
public interface PaperMybatisDao {
	
	public List<Paper> search(Map<String, Object> parameters);
	public Long getCount(Map<String, Object> parameters);
	public List<Question> selectQuestions(String paper_id);
	public void insertPaper(Paper paper);
	public void insertQuestions(Map<String, Object> parameters);
	public Paper selectPaper(String paperId);
	public void deletePaper(Long paperId);
	public void deleteQuestions(Long paperId);
	public void publishPaper(Long paperId);
	public void updatePaper(Paper paper);
	public void discardPaper(Long paperId);

}
