package egovframework.example.servey.service;

import java.util.List;

public interface ServeyService {
	
	UserVO login(UserVO vo);
	
	List<?> selectServeyList();
	
	ServeyVO selectServey(ServeyVO vo);
	
	List<?> selectQuestionList(QuestionVO vo);

	List<?> selectChoiceList();
	
	int insertAnswer(AnswerVO vo);
}
