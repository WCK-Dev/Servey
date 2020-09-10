package egovframework.example.servey.service;

import java.util.List;

public interface ServeyService {
	
	UserVO login(UserVO vo);
	
	List<?> selectServeyList();
	
	int checkServey(ServeyVO vo);

	ServeyVO selectServey(ServeyVO vo);
	
	List<?> selectQuestionList(QuestionVO vo);

	List<?> selectChoiceList();
	
	int insertAnswer(AnswerVO vo);

	int updateAnswer(AnswerVO vo);
	
	int insertLog(LogVO vo);
	
	int checkLog(LogVO vo);
	
	List<?> selectAnswerList(AnswerVO vo);
}
