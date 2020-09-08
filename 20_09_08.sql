-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: servey
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `q_no` varchar(50) NOT NULL DEFAULT '',
  `u_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `a_answer` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `s_seq` int DEFAULT NULL,
  KEY `FK_u_id` (`u_id`),
  KEY `FK_tbl_answer_s_seq` (`s_seq`),
  CONSTRAINT `FK_tbl_answer_s_seq` FOREIGN KEY (`s_seq`) REFERENCES `servey` (`s_seq`),
  CONSTRAINT `FK_u_id` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='답변정보 저장테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES ('6','wck','6',1),('4','wck','4',1),('2','wck','1',1),('5','wck','4',1),('3','wck','2',1),('7','wck','2',1),('9','wck','3',1),('10','wck','1',1),('12','wck','5',1),('1','wck','3',1),('8','wck','5',1),('11','wck','5',1),('13','wck','2',1),('16-2','wck','2,4',1),('14','wck','1',1),('15','wck','3',1),('16-3','wck','3,5',1),('16-1','wck','3,8',1),('16','wck','',1),('17','wck','퓨전소프트\n\n가나다라',1),('19','wck','의견작성',1),('18','wck','5',1);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `choice`
--

DROP TABLE IF EXISTS `choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `choice` (
  `c_type` int NOT NULL,
  `c_text` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `c_value` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문항 선택지 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choice`
--

LOCK TABLES `choice` WRITE;
/*!40000 ALTER TABLE `choice` DISABLE KEYS */;
INSERT INTO `choice` VALUES (1,'대체로 만족',2),(1,'약간 만족',3),(1,'보통',4),(1,'약간 불만족',5),(1,'대체로 불만족',6),(1,'매우 불만족',7),(1,'매우 만족',1),(2,'단원학습자료',2),(2,'수업설계자료',1),(2,'인성 진로 다문화',3),(2,'연구자료',4),(2,'교육과정자료',5),(2,'주제별 사진영상 자료',6),(2,'교과주제별 학습자료',7),(2,'위두랑',9),(2,'우수수업동영상',10),(2,'디지털교과서',11),(2,'소프트웨어교육',12),(2,'연구대회',13),(2,'연구학교',14),(2,'교원연수',16),(2,'외부자료',8),(2,'영어 e-교과서',17),(2,'스마트교육 이해',18),(2,'문제은행',19),(2,'사서추천도서',15),(2,'없음',20),(3,'학생평가',2),(3,'자유학기제',3),(3,'고교교육력 제고',4),(3,'고교학점제',6),(3,'2015 개정 교육과정',1),(3,'사이버폭력예방. 정보윤리교육',7),(3,'도란도란 학교폭력예방',8),(3,'NCS기반 교육과정',5),(4,'공지사항',1),(4,'마이페이지',2),(4,'독서교육. 인문소양교육',3),(4,'선생님들의 나눔공간',4),(4,'시. 도교육정보서비스',6),(3,'없음',9),(4,'최신동향',7),(4,'고객센터(이용문의)',8),(4,'기타(   )',9),(4,'없음',10),(4,'나에게 Dream',5),(5,'콘텐츠 검색',2),(5,'회원가입',3),(5,'인지도 강화(홍보)',4),(5,'기타(   )',5),(5,'콘텐츠 보강',1);
/*!40000 ALTER TABLE `choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `u_id` varchar(100) NOT NULL,
  `inputdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `s_seq` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`),
  KEY `FK_log_sseq` (`s_seq`),
  CONSTRAINT `FK_log_sseq` FOREIGN KEY (`s_seq`) REFERENCES `servey` (`s_seq`),
  CONSTRAINT `FK_log_uid` FOREIGN KEY (`u_id`) REFERENCES `answer` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='답변내역 저장 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `s_seq` int NOT NULL,
  `q_no` varchar(50) NOT NULL DEFAULT '',
  `q_text` varchar(3000) NOT NULL DEFAULT '',
  `q_category` varchar(300) NOT NULL DEFAULT '',
  `c_type` int NOT NULL DEFAULT '0',
  KEY `FK_s_seq` (`s_seq`),
  CONSTRAINT `FK_s_seq` FOREIGN KEY (`s_seq`) REFERENCES `servey` (`s_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='질문지 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'1','퓨전소프트 서비스에 대해 전반적으로 얼마나 만족하십니까?','전반적 만족도',1),(1,'2','퓨전소프트에서 원하는 정보(자료)를 손쉽게 찾을 수 있습니까?','검색성',1),(1,'3','검색창이 눈에 잘 띄는 위치에 적절한 크기로 배치되어 있습니까?','검색성',1),(1,'4','게시물의 제목만으로도 게시물 내용을 알 수 있습니까?','사용성',1),(1,'5','장문의 정보나 첨부문서가 포함된 경우 미리보기 또는 요약문을 충분히 제공한다고 생각하십니까?','사용성',1),(1,'6','퓨전소프트에서 제공하는 자료의 글자 크기, 문단이 잘 정렬되어 보거나 읽기 쉽습니까?','사용성',1),(1,'7','퓨전소프트의 서비스 디자인이 일관성 있게 정돈되어 홈페이지 통일성이 느껴지십니까?','사용성',1),(1,'8','퓨전소프트에서 사용되는 용어가 쉽고 명확하게 이해되십니까?','사용성',1),(1,'9','서비스 페이지마다 동일한 아이콘과 버튼을 사용하고 있어 편리하십니까?','사용성',1),(1,'10','서비스를 이용하는데 필요한 최소한의 개인정보만을 요구하고 있다고 생각하십니까?','정보보호',1),(1,'11','포털을 방문하신 목적을 달성하시는데 포털에서 제고하는 서비스(통합검색, 마이메뉴 등)는 도움이 되셨습니까?','유용성',1),(1,'12','서비스 이용을 통해 수업, 학습, 연구 준비에 도움이 되셨습니까?','유용성',1),(1,'13','인쇄, 공유, 스크랩 등 유용한 부가기능을 충분히 제공하고 있다고 생각하십니까?','유용성',1),(1,'14','서비스 문의사항에 대해 신속하고 충분한 답변을 받으셨습니까?','소통',1),(1,'15','퓨전소프트에서 서비스하는 교육과정 관련 자료가 유익하십니까?','',1),(1,'16','퓨전소프트에서 제공하는 서비스 중 가장 도움이 되는 서비스를 영역별로 선택해 주십시오.','',-1),(1,'16-1','수업 ˙ 연구 (2개 선택)','',2),(1,'16-2','교육정책 (2개 선택)','',3),(1,'16-3','기타 (2개 선택)','',4),(1,'17','위의 서비스를 선택한 이유는 무엇입니까? (필수)','',0),(1,'18','퓨전소프트가 가장 시급하게 개성해야 할 부분은 무엇이라고 생각하십니까? (자율)','',5),(1,'19','기타 퓨전소프트에 대한 의견을 자유롭게 자성하여 주십시오 (자율)','',0);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servey`
--

DROP TABLE IF EXISTS `servey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servey` (
  `s_seq` int NOT NULL AUTO_INCREMENT COMMENT '설문조사 번호',
  `s_name` varchar(3000) NOT NULL COMMENT '설문조사명',
  `s_startdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `s_enddate` timestamp NOT NULL,
  `s_company` varchar(1000) NOT NULL,
  PRIMARY KEY (`s_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='설문조사 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servey`
--

LOCK TABLES `servey` WRITE;
/*!40000 ALTER TABLE `servey` DISABLE KEYS */;
INSERT INTO `servey` VALUES (1,'퓨전소프트 만족도 조사','2020-09-07 00:00:00','2020-09-30 23:59:59','퓨전소프트');
/*!40000 ALTER TABLE `servey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `u_id` varchar(100) NOT NULL DEFAULT '',
  `u_pwd` varchar(100) NOT NULL,
  `u_name` varchar(100) NOT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='유저 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('fusion','1234','퓨전'),('user','1234','사원1'),('wck','1234','우치경');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-08 18:32:47
