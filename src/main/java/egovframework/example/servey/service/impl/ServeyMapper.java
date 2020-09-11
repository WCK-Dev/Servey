/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.servey.service.impl;

import java.util.List;

import egovframework.example.servey.service.AnswerVO;
import egovframework.example.servey.service.LogVO;
import egovframework.example.servey.service.QuestionVO;
import egovframework.example.servey.service.ServeyVO;
import egovframework.example.servey.service.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("serveyMapper")
public interface ServeyMapper {
	
	UserVO login(UserVO vo);
	
	List<?> selectServeyList();

	int checkServey(ServeyVO vo);
	
	ServeyVO selectServey(ServeyVO vo);
	
	List<?> selectQuestionList(QuestionVO vo);

	List<?> selectChoiceList();
	
	int insertAnswer(AnswerVO vo);
	
	int updateAnswer(AnswerVO vo);

	int insertLog(LogVO vo);
	
	int updateLog(LogVO vo);
	
	int checkLog(LogVO vo);
	
	List<?> selectAnswerList(AnswerVO vo);
}
