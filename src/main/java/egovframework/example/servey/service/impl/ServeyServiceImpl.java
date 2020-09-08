/*
 * Copyright 2008-2009 the original author or authors.
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

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.servey.service.AnswerVO;
import egovframework.example.servey.service.LogVO;
import egovframework.example.servey.service.QuestionVO;
import egovframework.example.servey.service.ServeyService;
import egovframework.example.servey.service.ServeyVO;
import egovframework.example.servey.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("serveyService")
public class ServeyServiceImpl extends EgovAbstractServiceImpl implements ServeyService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ServeyServiceImpl.class);

	// mybatis 사용
	@Resource(name="serveyMapper")
	private ServeyMapper serveyDAO;

	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	@Override
	public UserVO login(UserVO vo) {
		return serveyDAO.login(vo);
	}

	@Override
	public List<?> selectServeyList() {
		return serveyDAO.selectServeyList();
	}

	@Override
	public ServeyVO selectServey(ServeyVO vo) {
		return serveyDAO.selectServey(vo);
	}

	@Override
	public List<?> selectQuestionList(QuestionVO vo) {
		return serveyDAO.selectQuestionList(vo);
	}

	@Override
	public List<?> selectChoiceList() {
		return serveyDAO.selectChoiceList();
	}

	@Override
	public int insertAnswer(AnswerVO vo) {
		return serveyDAO.insertAnswer(vo);
	}

	@Override
	public int insertLog(LogVO vo) {
		return serveyDAO.insertLog(vo);
	}

	@Override
	public int checkLog(LogVO vo) {
		return serveyDAO.checkLog(vo);
	}

}
