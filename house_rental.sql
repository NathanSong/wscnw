/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3307
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3307
 Source Schema         : house_rental

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 18/03/2025 12:04:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appeal
-- ----------------------------
DROP TABLE IF EXISTS `appeal`;
CREATE TABLE `appeal`  (
  `appealid` int(0) NOT NULL AUTO_INCREMENT,
  `reportid` int(0) NOT NULL COMMENT '关联的举报ID',
  `houseid` int(0) NOT NULL,
  `appealer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申诉人',
  `appealcontent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申诉内容',
  `appealdate` datetime(0) NULL DEFAULT NULL COMMENT '申诉时间',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending' COMMENT '申诉状态',
  `appealtype` enum('举报不实','已整改') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '举报不实' COMMENT '申诉类型',
  PRIMARY KEY (`appealid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appeal
-- ----------------------------
INSERT INTO `appeal` VALUES (15, 58, 85, 'song2', 'da', '2025-03-15 01:41:08', 'approved', '已整改');
INSERT INTO `appeal` VALUES (16, 60, 85, 'song2', '1', '2025-03-16 00:50:39', 'approved', '已整改');
INSERT INTO `appeal` VALUES (17, 61, 90, 'song2', 'a', '2025-03-16 19:34:11', 'approved', '举报不实');
INSERT INTO `appeal` VALUES (18, 62, 90, 'song2', 'sdd', '2025-03-17 00:50:31', 'approved', '已整改');
INSERT INTO `appeal` VALUES (19, 63, 90, 'song2', 'qw', '2025-03-17 11:03:26', 'approved', '举报不实');
INSERT INTO `appeal` VALUES (20, 64, 90, 'song2', '嗷嗷', '2025-03-17 13:52:57', 'approved', '举报不实');
INSERT INTO `appeal` VALUES (21, 64, 90, 'song2', '问问去1', '2025-03-17 16:44:08', 'approved', '举报不实');
INSERT INTO `appeal` VALUES (22, 65, 96, 'song', '嗷嗷', '2025-03-17 16:45:07', 'approved', '举报不实');

-- ----------------------------
-- Table structure for buyrequest
-- ----------------------------
DROP TABLE IF EXISTS `buyrequest`;
CREATE TABLE `buyrequest`  (
  `requestid` int(0) NOT NULL AUTO_INCREMENT,
  `houseid` int(0) NOT NULL,
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `buyContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `requestDate` datetime(0) NULL DEFAULT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  `landlordname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房东名称',
  PRIMARY KEY (`requestid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buyrequest
-- ----------------------------
INSERT INTO `buyrequest` VALUES (8, 86, 'scn', 'a', '2025-03-16 13:15:05', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (9, 86, 'scn', '撒旦', '2025-03-16 13:37:09', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (10, 91, 'scn', 'a', '2025-03-16 19:34:59', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (11, 92, 'scn', 'qqq', '2025-03-16 22:31:04', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (12, 91, 'scn', '我', '2025-03-16 22:47:00', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (13, 92, 'scn', 'qqq', '2025-03-16 23:55:13', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (14, 92, 'scn', '为我', '2025-03-17 00:28:32', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (15, 92, 'scn', '我嗷嗷', '2025-03-17 00:43:32', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (16, 92, 'scn', '十三点', '2025-03-17 11:01:47', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (17, 91, 'scn', 'aa', '2025-03-17 12:26:28', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (18, 95, 'scn', 'ww', '2025-03-17 13:49:45', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (19, 97, 'scn', '啊啊啊', '2025-03-17 16:42:44', 'approved', 'song2');
INSERT INTO `buyrequest` VALUES (20, 96, 'scn', '飒飒', '2025-03-17 16:47:35', 'approved', 'song');

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `contractid` int(0) NOT NULL AUTO_INCREMENT,
  `houseid` int(0) NOT NULL COMMENT '房屋ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '买家',
  `seller` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '卖家',
  `contractDate` datetime(0) NOT NULL COMMENT '合同日期',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '合同状态',
  `order` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '用户申请内容',
  `adminstatus` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '管理员审核状态',
  PRIMARY KEY (`contractid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO `contract` VALUES (7, 92, 'scn', 'song2', '2025-03-17 11:04:59', 'rejected', 'wqw', 'rejected');
INSERT INTO `contract` VALUES (8, 92, 'scn', 'song2', '2025-03-17 11:09:43', 'approved', 'ss', 'approved');
INSERT INTO `contract` VALUES (9, 92, 'scn', 'song2', '2025-03-17 11:19:40', 'approved', 'aa', 'approved');
INSERT INTO `contract` VALUES (10, 92, 'scn', 'song2', '2025-03-17 11:35:07', 'approved', 'as', 'approved');
INSERT INTO `contract` VALUES (11, 91, 'scn', 'song2', '2025-03-17 12:27:14', 'approved', 'a', 'approved');
INSERT INTO `contract` VALUES (12, 95, 'scn', 'song2', '2025-03-17 13:50:09', 'approved', 'aa', 'approved');
INSERT INTO `contract` VALUES (13, 97, 'scn', 'song2', '2025-03-17 16:46:12', 'approved', '嗷嗷', 'pending');
INSERT INTO `contract` VALUES (14, 97, 'scn', 'song2', '2025-03-17 16:47:03', 'approved', '嗷嗷', 'pending');
INSERT INTO `contract` VALUES (15, 96, 'scn', 'song', '2025-03-17 16:48:26', 'approved', '嗷嗷', 'approved');

-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house`  (
  `houseid` int(0) NOT NULL AUTO_INCREMENT COMMENT '出租单主键id',
  `statue` int(0) NULL DEFAULT 0 COMMENT '房屋状态：0-未出租，1-已出租，2-需整改',
  `area` int(0) NULL DEFAULT NULL COMMENT '房屋面积',
  `floor` int(0) NULL DEFAULT NULL COMMENT '房屋楼层',
  `price` int(0) NULL DEFAULT NULL COMMENT '房屋租金/月',
  `community` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房子小区',
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋地址',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋房型',
  `toward` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋朝向',
  `surrounding` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋周围环境',
  `decoration` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋装修',
  `housename` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋出租人',
  `housephone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋出租人电话',
  `tenantname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租客姓名',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`houseid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house
-- ----------------------------
INSERT INTO `house` VALUES (90, 1, 10, 1, 3, '1', '2', '一室一厅', '4', '5', '普通装修', 'song2', '121', 'scn', '83cf7253-cd91-4e51-a413-c8bc0b35e393.png');
INSERT INTO `house` VALUES (91, 3, 10, 1, 10, '1', '1', '两室一厅', 'a', 'a', '普通装修', 'scn', '121', 'scn', 'c84a884e-ff6f-49cc-b22f-2f40fd9a37eb.jpg');
INSERT INTO `house` VALUES (92, 3, 10, 1, 10, 'w', 'q', '两室一厅', 'a', '1', '普通装修', 'scn', '121', 'scn', '01ed3f5f-5858-49bd-a30b-97e799d41d64.png');
INSERT INTO `house` VALUES (95, 3, 10, 1, 10, 'aa', '1', '两室一厅', '1', '1', '普通装修', 'scn', '123', 'scn', '2a3fb0ba-b9e7-42bb-9390-2578307d4cad.png');
INSERT INTO `house` VALUES (96, 3, 10, 1, 10, 'qqq', '1', '两室一厅', 'a', 'aa', '普通装修', 'scn', '123', 'scn', '91f03991-e1ab-4bc9-8f67-3872d33a254b.png');
INSERT INTO `house` VALUES (97, 0, 10, 111, 1110, '11', '1', '两室一厅', '1', '1', '普通装修', 'song2', '121', NULL, 'acad3261-cbf2-4230-b5cd-60a07e542f96.jpg');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `messageid` int(0) NOT NULL AUTO_INCREMENT,
  `messagename` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `messagetitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`messageid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 'admin', '1231', '?3131', '2025-03-05 14:48:19');
INSERT INTO `message` VALUES (2, 'scn', 'ss', '1', '2025-03-05 14:49:51');
INSERT INTO `message` VALUES (3, 'scn', 'ceshi', '1', '2025-03-06 18:24:20');
INSERT INTO `message` VALUES (4, 'admin', '12', '水水水水水水水水水水水水水水水水水水水', '2025-03-06 22:08:27');
INSERT INTO `message` VALUES (6, 'song', 'eee', '1111', '2025-03-11 16:26:09');
INSERT INTO `message` VALUES (7, 'admin', '?', 'w', '2025-03-11 16:27:54');
INSERT INTO `message` VALUES (10, 'song2', '啊', '1', '2025-03-14 22:37:10');
INSERT INTO `message` VALUES (14, 'song2', 'a', '1', '2025-03-16 00:48:40');

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `reportid` int(0) NOT NULL AUTO_INCREMENT,
  `reporter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reportee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reporttitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reportcontent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reportdate` datetime(0) NULL DEFAULT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending',
  `houseid` int(0) NULL DEFAULT NULL COMMENT '被举报的房屋ID',
  PRIMARY KEY (`reportid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES (58, 'scn', 'song2', 'aa', 'a', '2025-03-15 01:40:26', 'approved', 85);
INSERT INTO `report` VALUES (59, 'scn', 'song2', 'qw', '1', '2025-03-16 00:49:09', 'rejected', 85);
INSERT INTO `report` VALUES (60, 'scn', 'song2', '1', '1', '2025-03-16 00:50:17', 'approved', 85);
INSERT INTO `report` VALUES (61, 'scn', 'song2', 'aa', 'aa', '2025-03-16 19:33:26', 'approved', 90);
INSERT INTO `report` VALUES (62, 'scn', 'song2', 'ass', '11', '2025-03-17 00:49:35', 'approved', 90);
INSERT INTO `report` VALUES (63, 'scn', 'song2', 'sa', '1', '2025-03-17 11:01:57', 'approved', 90);
INSERT INTO `report` VALUES (64, 'scn', 'song2', 'sd', '1', '2025-03-17 13:51:38', 'approved', 90);
INSERT INTO `report` VALUES (65, 'scn', 'song', 'aaaa', '1111', '2025-03-17 16:42:35', 'approved', 96);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` int(0) NOT NULL AUTO_INCREMENT,
  `admin` int(0) NULL DEFAULT NULL COMMENT '是否是管理员',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户姓名\r\n',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户密码',
  `number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户身份证号',
  `userphone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户手机号',
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (19, 1, 'admin', '123456', '1111', '11111');
INSERT INTO `user` VALUES (20, 2, 'scn', '111', '123', '123');
INSERT INTO `user` VALUES (25, 3, 'song', '123', '111', '11144');
INSERT INTO `user` VALUES (26, 3, 'test', '123', '111', '111');
INSERT INTO `user` VALUES (27, 2, 'song1', '123', '111', '111');
INSERT INTO `user` VALUES (28, 2, 'sccn', '111', '11', '11');
INSERT INTO `user` VALUES (29, 3, 'song2', '123', '1111', '121');

SET FOREIGN_KEY_CHECKS = 1;
