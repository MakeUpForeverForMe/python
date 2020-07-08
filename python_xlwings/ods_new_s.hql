-- DROP DATABASE IF EXISTS ods_new_s;
-- CREATE DATABASE IF NOT EXISTS ods_new_s COMMENT 'ods标准层';


-- /**
--  * 授信申请表
--  *
--  * 数据库主键 apply_id
--  * 业务主键 apply_id
--  *
--  * 可能有多次授信
--  *
--  * 按照 biz_date,product_id 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.credit_apply`;
CREATE TABLE IF NOT EXISTS `ods_new_s.credit_apply`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `apply_id`                      string        COMMENT '授信申请编号',
  `credit_apply_time`             timestamp     COMMENT '授信申请时间（yyyy—MM—dd HH:mm:ss）',
  `resp_code`                     string        COMMENT '授信申请结果',
  `resp_msg`                      string        COMMENT '授信结果描述',
  `apply_amount`                  decimal(15,4) COMMENT '授信申请金额',
  `credit_amount`                 decimal(15,4) COMMENT '授信通过额度',
  `credit_interest_rate`          decimal(15,8) COMMENT '授信利率',
  `risk_assessment_time`          timestamp     COMMENT '风控评估时间（yyyy—MM—dd HH:mm:ss）',
  `risk_type`                     string        COMMENT '风控类型（用信风控、二次风控）',
  `risk_result_validity`          timestamp     COMMENT '风控结果有效期（yyyy—MM—dd HH:mm:ss）',
  `risk_level`                    string        COMMENT '风控等级',
  `risk_score`                    string        COMMENT '风控评分',
  `ori_request`                   string        COMMENT '原始请求',
  `ori_response`                  string        COMMENT '原始应答',
  `credit_expire_date`            timestamp     COMMENT '授信截止时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '授信申请表'
PARTITIONED BY (`biz_date` string COMMENT '授信申请日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 预审申请表
--  *
--  * 数据库主键 pre_apply_no
--  * 业务主键 pre_apply_no
--  *
--  * 按照 biz_date 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.pre_apply`;
CREATE TABLE IF NOT EXISTS `ods_new_s.pre_apply`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `pre_apply_no`                  string        COMMENT '预审申请编号',
  `pre_apply_time`                timestamp     COMMENT '预审申请时间（yyyy—MM—dd HH:mm:ss）',
  `apply_status`                  string        COMMENT '预审申请结果',
  `resp_code`                     string        COMMENT '授信结果码',
  `resp_msg`                      string        COMMENT '结果描述',
  `risk_level`                    string        COMMENT '风控等级',
  `risk_score`                    string        COMMENT '风控评分',
  `ori_request`                   string        COMMENT '原始请求',
  `ori_response`                  string        COMMENT '原始应答',
  `credit_expire_date`            timestamp     COMMENT '授信截止时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '预审申请表'
PARTITIONED BY (`biz_date` string COMMENT '预审申请日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 用信申请表
--  *
--  * 数据库主键 apply_id
--  * 业务主键 apply_id
--  *
--  * 按照 biz_date 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.loan_apply`;
CREATE TABLE IF NOT EXISTS `ods_new_s.loan_apply`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `birthday`                      string        COMMENT '出生日期',
  `pre_apply_no`                  string        COMMENT '预审申请编号',
  `apply_id`                      string        COMMENT '申请id',
  `due_bill_no`                   string        COMMENT '借据编号',
  `loan_apply_time`               timestamp     COMMENT '用信申请时间',
  `loan_amount_apply`             decimal(15,4) COMMENT '用信申请金额（4d元）',
  `loan_terms`                    decimal(3,0)  COMMENT '贷款期数（3、6、9等）',
  `loan_usage`                    string        COMMENT '贷款用途（英文原值）（1：日常消费，2：汽车加油，3：修车保养，4：购买汽车，5：医疗支出，6：教育深造，7：房屋装修，8：旅游出行，9：其他消费）',
  `loan_usage_cn`                 string        COMMENT '贷款用途（汉语解释）',
  `repay_type`                    string        COMMENT '还款方式（英文原值）（1：等额本金，2：等额本息、等额等息等）',
  `repay_type_cn`                 string        COMMENT '还款方式（汉语解释）',
  `interest_rate`                 decimal(15,8) COMMENT '利息利率（8d/%）',
  `penalty_rate`                  decimal(15,8) COMMENT '罚息利率（8d/%）',
  `apply_status`                  decimal(2,0)  COMMENT '申请状态（1: 放款成功，2: 放款失败，3: 处理中）',
  `apply_resut_msg`               string        COMMENT '申请结果信息',
  `issue_time`                    timestamp     COMMENT '放款时间，放款成功后必填',
  `loan_amount`                   decimal(15,4) COMMENT '放款金额（4d元）',
  `risk_level`                    string        COMMENT '风控等级',
  `risk_score`                    string        COMMENT '风控评分',
  `ori_request`                   string        COMMENT '原始请求',
  `ori_response`                  string        COMMENT '原始应答',
  `create_time`                   string        COMMENT '创建时间'
) COMMENT '用信申请表'
PARTITIONED BY (`biz_date` string COMMENT '用信申请日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 用信申请表
--  */
-- DROP TABLE IF EXISTS `ods_new_s.loan_apply_tmp`;
CREATE TABLE IF NOT EXISTS `ods_new_s.loan_apply_tmp` like `ods_new_s.loan_apply`;


-- /**
--  * 客户信息表
--  *
--  * 数据库主键 cust_id
--  */
-- DROP TABLE IF EXISTS `ods_new_s.customer_info`;
CREATE TABLE IF NOT EXISTS `ods_new_s.customer_info`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `outer_cust_id`                 string        COMMENT '外部客户号',
  `idcard_type`                   string        COMMENT '证件类型（身份证等）',
  `idcard_no`                     string        COMMENT '证件号码',
  `name`                          string        COMMENT '客户姓名',
  `mobie`                         string        COMMENT '客户电话',
  `card_phone`                    string        COMMENT '客户银行卡绑定手机号',
  `sex`                           string        COMMENT '客户性别（男、女）',
  `birthday`                      string        COMMENT '出生日期',
  `marriage_status`               string        COMMENT '婚姻状态',
  `education`                     string        COMMENT '学历',
  `idcard_address`                string        COMMENT '身份证地址',
  `idcard_area`                   string        COMMENT '身份证大区（东北地区、华北地区、西北地区、西南地区、华南地区、华东地区、华中地区、港澳台地区）',
  `idcard_province`               string        COMMENT '身份证省级（省/直辖市/特别行政区）',
  `idcard_city`                   string        COMMENT '身份证地级（城市）',
  `idcard_county`                 string        COMMENT '身份证县级（区县）',
  `idcard_township`               string        COMMENT '身份证乡级（乡/镇/街）（预留）',
  `resident_address`              string        COMMENT '常住地地址',
  `resident_area`                 string        COMMENT '常住地大区（东北地区、华北地区、西北地区、西南地区、华南地区、华东地区、华中地区、港澳台地区）',
  `resident_province`             string        COMMENT '常住地省级（省/直辖市/特别行政区）',
  `resident_city`                 string        COMMENT '常住地地级（城市）',
  `resident_county`               string        COMMENT '常住地县级（区县）',
  `resident_township`             string        COMMENT '常住地乡级（乡/镇/街）（预留）',
  `job_type`                      string        COMMENT '工作类型',
  `job_year`                      decimal(2,0)  COMMENT '工作年限',
  `income_month`                  decimal(15,4) COMMENT '月收入',
  `income_year`                   decimal(15,4) COMMENT '年收入',
  `cutomer_type`                  string        COMMENT '客戶类型（个人或企业）',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）',
  `update_time`                   timestamp     COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '客户信息表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 用户信息表
--  *
--  * 数据库主键 user_hash_no
--  */
-- DROP TABLE IF EXISTS `ods_new_s.user_info`;
CREATE TABLE IF NOT EXISTS `ods_new_s.user_info`(
  `user_hash_no`                  string        COMMENT '用户编号',
  `idcard_type`                   string        COMMENT '证件类型（身份证等）',
  `idcard_no`                     string        COMMENT '证件号码',
  `name`                          string        COMMENT '客户姓名',
  `mobie`                         string        COMMENT '客户电话',
  `card_phone`                    string        COMMENT '客户银行卡绑定手机号',
  `sex`                           string        COMMENT '客户性别（男、女）',
  `birthday`                      string        COMMENT '出生日期',
  `marriage_status`               string        COMMENT '婚姻状态',
  `education`                     string        COMMENT '学历',
  `idcard_address`                string        COMMENT '身份证地址',
  `idcard_area`                   string        COMMENT '身份证大区（东北地区、华北地区、西北地区、西南地区、华南地区、华东地区、华中地区、港澳台地区）',
  `idcard_province`               string        COMMENT '身份证省级（省/直辖市/特别行政区）',
  `idcard_city`                   string        COMMENT '身份证地级（城市）',
  `idcard_county`                 string        COMMENT '身份证县级（区县）',
  `idcard_township`               string        COMMENT '身份证乡级（乡/镇/街）（预留）',
  `resident_address`              string        COMMENT '常住地地址',
  `resident_area`                 string        COMMENT '常住地大区（东北地区、华北地区、西北地区、西南地区、华南地区、华东地区、华中地区、港澳台地区）',
  `resident_province`             string        COMMENT '常住地省级（省/直辖市/特别行政区）',
  `resident_city`                 string        COMMENT '常住地地级（城市）',
  `resident_county`               string        COMMENT '常住地县级（区县）',
  `resident_township`             string        COMMENT '常住地乡级（乡/镇/街）（预留）',
  `job_type`                      string        COMMENT '工作类型',
  `job_year`                      decimal(2,0)  COMMENT '工作年限',
  `income_month`                  decimal(15,4) COMMENT '月收入',
  `income_year`                   decimal(15,4) COMMENT '年收入',
  `cutomer_type`                  string        COMMENT '客戶类型（个人或企业）',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）',
  `update_time`                   timestamp     COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '用户信息表'
STORED AS PARQUET;



-- /**
--  * 额度表（做拉联表）
--  *
--  * 数据库主键 credit_limit_id
--  * 业务主键 channel_id project_id product_id cust_id
--  */
-- DROP TABLE IF EXISTS `ods_new_s.credit_limit`;
CREATE TABLE IF NOT EXISTS `ods_new_s.credit_limit`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `credit_limit_id`               string        COMMENT '授信额度表ID',
  `credit_limit`                  decimal(15,4) COMMENT '授信额度',
  `credit_rate`                   decimal(15,8) COMMENT '授信利率',
  `effective_limit`               decimal(15,4) COMMENT '可用额度',
  `start_date`                    timestamp     COMMENT '起始时间（yyyy—MM—dd HH:mm:ss）',
  `end_date`                      timestamp     COMMENT '截止时间（yyyy—MM—dd HH:mm:ss）',
  `effective_time`                timestamp     COMMENT '生效时间（yyyy—MM—dd HH:mm:ss）',
  `expire_time`                   timestamp     COMMENT '失效时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '额度表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 风控用户特征信息
--  *
--  * 数据库主键 apply_no
--  * 业务主键 apply_no
--  *
--  * 按照 biz_date 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.risk_control_feature`;
CREATE TABLE IF NOT EXISTS `ods_new_s.risk_control_feature`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `credit_id`                     string        COMMENT '授信id',
  `apply_no`                      string        COMMENT '申请号',
  `risk_score`                    string        COMMENT '曼指数评分',
  `order_start_stability_level`   string        COMMENT '打车地点稳定性等级',
  `consume_stability_level`       string        COMMENT '打车消费稳定性等级',
  `imei_freq_change_3m`           string        COMMENT '近3个月设备是否频繁更换',
  `phone_imei_level_3m`           string        COMMENT '3个月内同一手机imei一级关联的手机号数量等级',
  `imei_phone_level_3m`           string        COMMENT '3个月内同一手机号一级关联的imei数量等级',
  `device_stability_1year`        string        COMMENT '近1年移动设备是否频繁更换',
  `regist_month_level`            string        COMMENT '注册时长等级',
  `night_ordernum_level_1m`       string        COMMENT '近1个月内深夜打车订单数占比等级',
  `cost_level_1m`                 string        COMMENT '近1个月平台消费等级',
  `cost_level_3m`                 string        COMMENT '近3个月平台消费等级',
  `is_often_used_dev`             string        COMMENT '是否滴滴常用设备',
  `is_often_used_addr`            string        COMMENT '是否为滴滴常用地址',
  `idcard_frontphoto_uploadtime`  string        COMMENT '身份证正面拍摄/上传时间（上传时间）（毫秒时间戳）',
  `idcard_backphoto_uploadtime`   string        COMMENT '身份证反面拍摄/上传时间（上传时间）（毫秒时间戳）',
  `idcard_frontphoto_shoottimes`  string        COMMENT '身份证正面拍摄次数',
  `photo_match_fail_times`        string        COMMENT '大头照比对失败次数',
  `company_address_inputtime`     string        COMMENT '工作单位名称输入时长（毫秒）',
  `contact_mobile_inputtime`      string        COMMENT '联系人电话输入时长（毫秒）',
  `home_address_inputtime`        string        COMMENT '家庭地址输入时长（毫秒）',
  `product_page_staytime`         string        COMMENT '产品介绍页逗留时长（毫秒）',
  `product_page_first_viewtime`   string        COMMENT '首次进入产品介绍页时间（毫秒时间戳）',
  `access_channel`                string        COMMENT '进件渠道',
  `bind_card_time`                string        COMMENT '银行卡签约时间（毫秒时间戳）',
  `repayplan_page_staytime`       string        COMMENT '还款计划表页面停留时长（毫秒）',
  `loan_term_modifytimes`         string        COMMENT '借款期限修改次数',
  `is_same_apply_imei`            string        COMMENT '本次提现使用imei与申请时是否一致',
  `is_sanme_aplly_city`           string        COMMENT '本次提现所在城市区与申请时是否一致',
  `acount_id`                     string        COMMENT '用户账号',
  `longtitude_md5`                string        COMMENT 'gps经度',
  `latitude_md5`                  string        COMMENT 'gps纬度',
  `gps_apply_city_md5`            string        COMMENT '申请GPS城市',
  `device_id`                     string        COMMENT '设备指纹',
  `open_id_md5`                   string        COMMENT 'openid加密',
  `create_time`                   timestamp     COMMENT '创建时间'
) COMMENT '风控用户特征信息'
PARTITIONED BY (`biz_date` string COMMENT '风控调用日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;

















-- /**
--  * 联系人信息表
--  *
--  * 数据库主键 linkman_id
--  * 业务主键 cust_id,due_bill_no,relation_id,card_no
--  */
-- DROP TABLE IF EXISTS `ods_new_s.linkman_info`;
CREATE TABLE IF NOT EXISTS `ods_new_s.linkman_info`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `due_bill_no`                   string        COMMENT '借据编号',
  `linkman_id`                    string        COMMENT '联系人编号',
  `relational_type`               string        COMMENT '关联人类型（英文原值）',
  `relational_type_cn`            string        COMMENT '关联人类型（汉语解释）',
  `relationship`                  string        COMMENT '联系人关系（英文原值）（如：1：父母、2：配偶、3：子女、4：兄弟姐妹）',
  `relationship_cn`               string        COMMENT '联系人关系（汉语解释）',
  `relation_idcard_type`          string        COMMENT '联系人证件类型',
  `relation_idcard_no`            string        COMMENT '联系人证件号码',
  `relation_birthday`             string        COMMENT '联系人出生日期',
  `relation_name`                 string        COMMENT '联系人姓名',
  `relation_sex`                  string        COMMENT '联系人性别',
  `relation_mobile`               string        COMMENT '联系人电话',
  `relation_address`              string        COMMENT '联系人地址',
  `relation_province`             string        COMMENT '联系人省份',
  `relation_city`                 string        COMMENT '联系人城市',
  `relation_county`               string        COMMENT '联系人区县',
  `corp_type`                     string        COMMENT '工作类型',
  `corp_name`                     string        COMMENT '公司名称',
  `corp_teleph_nbr`               string        COMMENT '公司电话',
  `corp_fax`                      string        COMMENT '公司传真',
  `corp_position`                 string        COMMENT '公司职务',
  `deal_date`                     string        COMMENT '业务时间',
  `effective_time`                timestamp     COMMENT '生效时间（yyyy—MM—dd HH:mm:ss）',
  `expire_time`                   timestamp     COMMENT '失效时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '联系人信息表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 联系人信息表
--  */
-- DROP TABLE IF EXISTS `ods_new_s.linkman_info_tmp`;
CREATE TABLE IF NOT EXISTS `ods_new_s.linkman_info_tmp` like `ods_new_s.linkman_info`;



-- /**
--  * 绑卡信息表（做拉链表）
--  *
--  * 数据库主键 card_id
--  * 业务主键 cust_id,due_bill_no
--  */
-- DROP TABLE IF EXISTS `ods_new_s.bind_card_info`;
CREATE TABLE IF NOT EXISTS `ods_new_s.bind_card_info`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `due_bill_no`                   string        COMMENT '借据编号',
  `card_id`                       string        COMMENT '绑卡编号',
  `bank_card_flag`                string        COMMENT '绑卡标志（N：正常，F：非客户本人、共同借款人、配偶）',
  `bank_card_id_no`               string        COMMENT '证件号码',
  `bank_card_name`                string        COMMENT '姓名',
  `bank_card_phone`               string        COMMENT '手机号',
  `bank_card_no`                  string        COMMENT '银行卡号',
  `pay_channel`                   decimal(2,0)  COMMENT '支付渠道（1：宝付，2：通联）',
  `agreement_no`                  string        COMMENT '绑卡协议编号',
  `is_valid`                      string        COMMENT '是否生效',
  `is_default`                    string        COMMENT '是否默认卡',
  `effective_time`                timestamp     COMMENT '生效时间（yyyy—MM—dd HH:mm:ss）',
  `expire_time`                   timestamp     COMMENT '失效时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '绑卡信息表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 绑卡信息表
--  */
-- DROP TABLE IF EXISTS `ods_new_s.bind_card_info_tmp`;
CREATE TABLE IF NOT EXISTS `ods_new_s.bind_card_info_tmp` like `ods_new_s.bind_card_info`;



















-- /**
--  * 借据信息表（做拉链表）
--  *
--  * 数据库主键 loan_id
--  * 业务主键 due_bill_no
--  *
--  * 按照 is_settled 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.loan_info`;
CREATE TABLE IF NOT EXISTS `ods_new_s.loan_info`(
  `user_hash_no`                  string        COMMENT '用户编号',
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `age`                           decimal(3,0)  COMMENT '年龄',
  `loan_id`                       string        COMMENT '借据ID',
  `due_bill_no`                   string        COMMENT '借据编号',
  `contract_no`                   string        COMMENT '合同编号',
  `apply_no`                      string        COMMENT '进件编号',
  `loan_usage`                    string        COMMENT '贷款用途',
  `register_date`                 string        COMMENT '放款日期',
  `request_time`                  timestamp     COMMENT '请求时间',
  `loan_active_date`              string        COMMENT '激活日期—借据生成时间',
  `cycle_day`                     decimal(2,0)  COMMENT '账单日',
  `loan_expire_date`              string        COMMENT '贷款到期日期',
  `loan_type`                     string        COMMENT '分期类型（英文原值）（R：消费转分期，C：现金分期，B：账单分期，P：POS分期，M：大额分期（专项分期），MCAT：随借随还，MCEP：等额本金，MCEI：等额本息）',
  `loan_type_cn`                  string        COMMENT '分期类型（汉语解释）',
  `loan_init_term`                decimal(3,0)  COMMENT '贷款期数（3、6、9等）',
  `loan_term`                     decimal(3,0)  COMMENT '当前期数',
  `loan_term_repaid`              decimal(3,0)  COMMENT '已还期数',
  `loan_term_remain`              decimal(3,0)  COMMENT '剩余期数',
  `loan_status`                   string        COMMENT '借据状态（英文原值）（N：正常，O：逾期，F：已还清）',
  `loan_status_cn`                string        COMMENT '借据状态（汉语解释）',
  `loan_out_reason`               string        COMMENT '借据终止原因（P：提前还款，M：银行业务人员手工终止（manual），D：逾期自动终止（delinquency），R：锁定码终止（Refund），V：持卡人手动终止，C：理赔终止，T：退货终止，U：重组结清终止，F：强制结清终止，B：免息转分期）',
  `paid_out_type`                 string        COMMENT '结清类型（英文原值）（D：代偿结清，H：回购结清，T：退货（车）结清，P：提前结清，C：强制结清，F：正常到期结清）',
  `paid_out_type_cn`              string        COMMENT '结清类型（汉语解释）',
  `paid_out_date`                 string        COMMENT '还款日期',
  `terminal_date`                 string        COMMENT '提前终止日期',
  `loan_init_principal`           decimal(15,4) COMMENT '贷款本金',
  `loan_init_interest_rate`       decimal(15,8) COMMENT '利息利率',
  `loan_init_interest`            decimal(15,4) COMMENT '贷款利息',
  `loan_init_term_fee_rate`       decimal(15,8) COMMENT '手续费费率',
  `loan_init_term_fee`            decimal(15,4) COMMENT '贷款手续费',
  `loan_init_svc_fee_rate`        decimal(15,8) COMMENT '服务费费率',
  `loan_init_svc_fee`             decimal(15,4) COMMENT '贷款服务费',
  `loan_init_penalty_rate`        decimal(15,8) COMMENT '罚息利率',
  `paid_amount`                   decimal(15,4) COMMENT '已还金额',
  `paid_principal`                decimal(15,4) COMMENT '已还本金',
  `paid_interest`                 decimal(15,4) COMMENT '已还利息',
  `paid_penalty`                  decimal(15,4) COMMENT '已还罚息',
  `paid_svc_fee`                  decimal(15,4) COMMENT '已还服务费',
  `paid_term_fee`                 decimal(15,4) COMMENT '已还手续费',
  `paid_mult`                     decimal(15,4) COMMENT '已还滞纳金',
  `remain_amount`                 decimal(15,4) COMMENT '剩余金额：本息费',
  `remain_principal`              decimal(15,4) COMMENT '剩余本金',
  `remain_interest`               decimal(15,4) COMMENT '剩余利息',
  `overdue_principal`             decimal(15,4) COMMENT '逾期本金',
  `overdue_interest`              decimal(15,4) COMMENT '逾期利息',
  `overdue_svc_fee`               decimal(15,4) COMMENT '逾期服务费',
  `overdue_term_fee`              decimal(15,4) COMMENT '逾期手续费',
  `overdue_penalty`               decimal(15,4) COMMENT '逾期罚息',
  `overdue_mult_amt`              decimal(15,4) COMMENT '逾期滞纳金',
  `overdue_date_first`            string        COMMENT '首次逾期日期',
  `overdue_date_start`            string        COMMENT '逾期起始日期',
  `overdue_days`                  decimal(5,0)  COMMENT '逾期天数',
  `overdue_date`                  string        COMMENT '逾期日期',
  `dpd_begin_date`                string        COMMENT 'DPD起始日期',
  `dpd_days`                      decimal(4,0)  COMMENT 'DPD天数',
  `dpd_days_count`                decimal(4,0)  COMMENT '累计DPD天数',
  `dpd_days_max`                  decimal(4,0)  COMMENT '历史最大DPD天数',
  `collect_out_date`              string        COMMENT '出催日期',
  `overdue_term`                  decimal(3,0)  COMMENT '当前逾期期数',
  `overdue_terms_count`           decimal(3,0)  COMMENT '累计逾期期数',
  `overdue_terms_max`             decimal(3,0)  COMMENT '历史单次最长逾期期数',
  `overdue_principal_accumulate`  decimal(15,4) COMMENT '累计逾期本金',
  `overdue_principal_max`         decimal(15,4) COMMENT '历史最大逾期本金',
  `mob`                           string        COMMENT '月账龄',
  `sync_date`                     string        COMMENT '同步日期',
  `s_d_date`                      string        COMMENT 'ods层起始日期',
  `e_d_date`                      string        COMMENT 'ods层结束日期',
  `effective_time`                timestamp     COMMENT '生效日期（yyyy—MM—dd HH:mm:ss）',
  `expire_time`                   timestamp     COMMENT '失效日期（yyyy—MM—dd HH:mm:ss）'
) COMMENT '借据信息表'
PARTITIONED BY (`is_settled` string COMMENT '是否已结清',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 借据信息临时表
--  */
-- DROP TABLE IF EXISTS `ods_new_s.loan_info_tmp`;
CREATE TABLE IF NOT EXISTS `ods_new_s.loan_info_tmp` like `ods_new_s.loan_info`;




-- /**
--  * 还款计划表（做拉链表）
--  *
--  * 数据库主键 schedule_id
--  * 业务主键 cust_id,due_bill_no
--  *
--  * 按照 is_settled 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.repay_schedule`;
CREATE TABLE IF NOT EXISTS `ods_new_s.repay_schedule`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `schedule_id`                   string        COMMENT '还款计划编号',
  `out_side_schedule_no`          string        COMMENT '外部还款计划编号',
  `due_bill_no`                   string        COMMENT '借据编号',
  `loan_active_date`              string        COMMENT '激活日期—借据生成时间',
  `loan_init_principal`           decimal(15,4) COMMENT '贷款本金',
  `loan_init_term`                decimal(3,0)  COMMENT '贷款期数（3、6、9等）',
  `loan_term`                     decimal(3,0)  COMMENT '当前期数',
  `start_interest_date`           string        COMMENT '起息日期',
  `should_repay_date`             string        COMMENT '应还日期',         -- 对应 pmt_due_date 字段
  `should_repay_date_history`     string        COMMENT '修改前的应还日期', -- 对应 pmt_due_date 的上一次日期 字段
  `grace_date`                    string        COMMENT '宽限日期',
  `should_repay_amount`           decimal(15,4) COMMENT '应还金额',
  `should_repay_principal`        decimal(15,4) COMMENT '应还本金',
  `should_repay_interest`         decimal(15,4) COMMENT '应还利息',
  `should_repay_penalty`          decimal(15,4) COMMENT '应还罚息',
  `should_repay_term_fee`         decimal(15,4) COMMENT '应还手续费',
  `should_repay_svc_fee`          decimal(15,4) COMMENT '应还服务费',
  `should_repay_mult_amt`         decimal(15,4) COMMENT '应还滞纳金',
  `reduce_amount`                 decimal(15,4) COMMENT '减免金额',
  `reduce_principal`              decimal(15,4) COMMENT '减免本金',
  `reduce_interest`               decimal(15,4) COMMENT '减免利息',
  `reduce_term_fee`               decimal(15,4) COMMENT '减免手续费',
  `reduce_svc_fee`                decimal(15,4) COMMENT '减免服务费',
  `reduce_penalty`                decimal(15,4) COMMENT '减免罚息',
  `reduce_mult_amt`               decimal(15,4) COMMENT '减免滞纳金',
  `s_d_date`                      string        COMMENT 'ods层起始日期',
  `e_d_date`                      string        COMMENT 'ods层结束日期',
  `effective_time`                timestamp     COMMENT '生效时间（yyyy—MM—dd HH:mm:ss）',
  `expire_time`                   timestamp     COMMENT '失效时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '还款计划表'
PARTITIONED BY (`is_settled` string COMMENT '是否已结清',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 还款计划临时表
--  */
-- DROP TABLE IF EXISTS `ods_new_s.repay_schedule_tmp`;
CREATE TABLE IF NOT EXISTS `ods_new_s.repay_schedule_tmp` like `ods_new_s.repay_schedule`;


-- /**
--  * 实还明细表
--  *
--  * 数据库主键 payment_id
--  * 业务主键 cust_id,due_bill_no,order_id
--  *
--  * 按照 biz_date 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.repay_detail`;
CREATE TABLE IF NOT EXISTS `ods_new_s.repay_detail`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `due_bill_no`                   string        COMMENT '借据号',
  `repay_term`                    decimal(3,0)  COMMENT '实还期数',
  `order_id`                      string        COMMENT '订单号',
  `loan_status`                   string        COMMENT '借据状态（英文原值）（N：正常，O：逾期，F：已还清）',
  `loan_status_cn`                string        COMMENT '借据状态（汉语解释）',
  `overdue_days`                  decimal(4,0)  COMMENT '逾期天数',
  `payment_id`                    string        COMMENT '实还流水号',
  `txn_time`                      timestamp     COMMENT '交易时间',
  `post_time`                     timestamp     COMMENT '入账时间',
  `bnp_type`                      string        COMMENT '还款成分（英文原值）（Pricinpal：本金，Interest：利息，Penalty：罚息，Mulct：罚金，Compound：复利，CardFee：年费，OverLimitFee：超限费，LatePaymentCharge：滞纳金，NSFCharge：资金不足罚金，TXNFee：交易费，TERMFee：手续费，SVCFee：服务费，LifeInsuFee：寿险计划包费）',
  `bnp_type_cn`                   string        COMMENT '还款成分（汉语解释）',
  `repay_amount`                  decimal(15,4) COMMENT '还款金额',
  `batch_date`                    string        COMMENT '批量日期',
  `create_time`                   timestamp     COMMENT '创建时间',
  `update_time`                   timestamp     COMMENT '更新时间'
) COMMENT '实还明细表'
PARTITIONED BY (`biz_date` string COMMENT '实还日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 实还明细临时表
--  */
-- DROP TABLE IF EXISTS `ods_new_s.repay_detail_tmp`;
CREATE TABLE IF NOT EXISTS `ods_new_s.repay_detail_tmp` like `ods_new_s.repay_detail`;


-- /**
--  * 调账明细表
--  *
--  * 数据库主键 adjust_id
--  * 业务主键 cust_id,due_bill_no,order_id
--  *
--  * 按照 biz_date 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.adjust_detail`;
CREATE TABLE IF NOT EXISTS `ods_new_s.adjust_detail`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `due_bill_no`                   string        COMMENT '借据号',
  `loan_active_date`              string        COMMENT '激活日期—借据生成时间',
  `order_id`                      string        COMMENT '订单号',
  `adjust_id`                     string        COMMENT '调账id',
  `adjust_term`                   decimal(3,0)  COMMENT '所在分期期数',
  `op_time`                       timestamp     COMMENT '操作时间',
  `op_id`                         string        COMMENT '操作员ID',
  `db_cr_ind`                     string        COMMENT '借贷标志',
  `bucket_type`                   string        COMMENT '余额成分类型',
  `txn_amt`                       decimal(15,4) COMMENT '交易金额',
  `adjust_state`                  string        COMMENT '调整状态',
  `txn_date`                      timestamp     COMMENT '交易日期',
  `post_ind`                      string        COMMENT '是否入账',
  `post_date`                     string        COMMENT '入账日期',
  `memo`                          string        COMMENT '备注',
  `void_ind`                      string        COMMENT '是否已撤销',
  `void_time`                     timestamp     COMMENT '撤销日期时间',
  `void_reason`                   string        COMMENT '撤销原因',
  `void_op_id`                    string        COMMENT '撤销操作员',
  `create_time`                   timestamp     COMMENT '创建时间'
) COMMENT '调账明细表'
PARTITIONED BY (`biz_date` string COMMENT '创建日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 订单流水表
--  *
--  * 数据库主键 order_id
--  *
--  * 按照 biz_date 分区
--  */
-- DROP TABLE IF EXISTS `ods_new_s.order_info`;
CREATE TABLE IF NOT EXISTS `ods_new_s.order_info`(
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `user_hash_no`                  string        COMMENT '用户编号',
  `due_bill_no`                   string        COMMENT '借据编号',
  `loan_active_date`              string        COMMENT '激活日期—借据生成时间',
  `order_id`                      string        COMMENT '订单ID',
  `apply_no`                      string        COMMENT '进件id',
  `request_channel`               string        COMMENT '请求渠道',
  `request_time`                  timestamp     COMMENT '请求时间',
  `request_no`                    string        COMMENT '请求流水号',
  `business_date`                 string        COMMENT '业务日期',
  `order_time`                    timestamp     COMMENT '订单时间',
  `order_status`                  string        COMMENT '订单状态',
  `txn_date`                      string        COMMENT '交易日期',
  `txn_type`                      string        COMMENT '交易类型',
  `txn_sub_type`                  string        COMMENT '交易子类型',
  `txn_amt`                       decimal(15,4) COMMENT '交易金额',
  `success_amt`                   decimal(15,4) COMMENT '成功金额',
  `fail_amt`                      decimal(15,4) COMMENT '失败金额',
  `is_online`                     string        COMMENT '是否联机',
  `order_term`                    decimal(3,0)  COMMENT '交易期数',
  `pay_way`                       string        COMMENT '支付方式',
  `pay_channel`                   string        COMMENT '支付渠道',
  `pay_seq`                       string        COMMENT '支付流水号',
  `pay_time`                      timestamp     COMMENT '支付时间',
  `out_account_no`                string        COMMENT '转出账号',
  `out_account_name`              string        COMMENT '转出账号户名',
  `in_account_no`                 string        COMMENT '转入账号',
  `in_account_name`               string        COMMENT '转入账号户名',
  `batch_seq`                     string        COMMENT '批次号',
  `confirm_flag`                  string        COMMENT '确认标志',
  `confirm_date`                  timestamp     COMMENT '确认日期',
  `ori_order_id`                  string        COMMENT '原订单号',
  `memo`                          string        COMMENT '备忘',
  `create_time`                   timestamp     COMMENT '创建时间'
) COMMENT '订单流水表'
PARTITIONED BY (`biz_date` string COMMENT '创建日期',`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


























DROP DATABASE IF EXISTS dim_new;
CREATE DATABASE IF NOT EXISTS dim_new;

-- /**
--  * 业务配置表
--  *
--  * 数据库主键 project_id
--  * 业务主键 project_id
--  */
-- DROP TABLE IF EXISTS `dim_new.biz_conf`;
CREATE TABLE IF NOT EXISTS `dim_new.biz_conf`(
  `biz_name`                      string        COMMENT '业务名称',
  `capital_id`                    string        COMMENT '资金方编号',
  `capital_name`                  string        COMMENT '资金方名称',
  `channel_id`                    string        COMMENT '渠道方编号',
  `channel_name`                  string        COMMENT '渠道方名称',
  `project_id`                    string        COMMENT '项目编号',
  `project_name`                  string        COMMENT '项目名称',
  `product_id`                    string        COMMENT '产品编号',
  `product_name`                  string        COMMENT '产品名称',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）'
) COMMENT '业务配置表'
STORED AS PARQUET;


-- /**
--  * 身份证地区
--  *
--  * 数据库主键 idno_addr
--  * 业务主键 idno_addr
--  */
-- DROP TABLE IF EXISTS `dim_new.dim_idno`;
CREATE TABLE IF NOT EXISTS `dim_new.dim_idno`(
  `idno_addr`                    string        COMMENT '身份证前6位编码',
  `idno_area`                    string        COMMENT '身份证大区（编码）',
  `idno_area_cn`                 string        COMMENT '身份证大区（解释）（华北地区、东北地区、华东地区、中南地区、西南地区、西北地区、港澳台地区）',
  `idno_province`                string        COMMENT '身份证省级（编码）',
  `idno_province_cn`             string        COMMENT '身份证省级（解释）（省、直辖市、特别行政区）',
  `idno_city`                    string        COMMENT '身份证地级（编码）',
  `idno_city_cn`                 string        COMMENT '身份证地级（解释）（地级市、自治州、）',
  `idno_county`                  string        COMMENT '身份证县级（编码）',
  `idno_county_cn`               string        COMMENT '身份证县级（解释）（区县）'
) COMMENT '身份证地区'
STORED AS PARQUET;


-- /**
--  * 产品生命周期表
--  *
--  * 数据库主键 product_id
--  * 业务主键 product_id
--  */
-- DROP TABLE IF EXISTS `dim_new.product_life_cycle`;
CREATE TABLE IF NOT EXISTS `dim_new.dim_product_life_cycle`(
  `channel_id`                    string        COMMENT '渠道方编号',
  `product_id`                    string        COMMENT '已结束产品编号',
  `insert_time`                   timestamp     COMMENT '插入时间',
  `project_end_time`              string        COMMENT '已结束项目日期'
) COMMENT '产品生命周期表'
STORED AS PARQUET;


-- /**
--  * 借据维度表
--  *
--  * 存储借据信息表中其他未在主表中存储的数据
--  *
--  * 业务主键 user_id,ecif_id,cust_id
--  */
-- DROP TABLE IF EXISTS `dim_new.dim_loan_info`;
CREATE TABLE IF NOT EXISTS `dim_new.dim_loan_info`(
  `user_hash_no`                  string        COMMENT '用户编号',
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `due_bill_no`                   string        COMMENT '借据编号',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）',
  `update_time`                   timestamp     COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）',
  `data_comment`                  string        COMMENT '注释Key_Value存储的是什么数据',
  `dim_key`                       string        COMMENT '维度Key',
  `dim_value`             map<string,string>    COMMENT '维度Value'
) COMMENT '借据维度表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 加密信息表
--  *
--  * 业务主键 user_id,ecif_id,cust_id
--  */
-- DROP TABLE IF EXISTS `dim_new.dim_cust_info`;
CREATE TABLE IF NOT EXISTS `dim_new.dim_encrypt_info`(
  `user_hash_no`                  string        COMMENT '用户编号',
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）',
  `update_time`                   timestamp     COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）',
  `data_comment`                  string        COMMENT '注释Key_Value存储的是什么数据',
  `dim_key`                       string        COMMENT '维度Key',
  `dim_value`             map<string,string>    COMMENT '维度Value'
) COMMENT '加密信息表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 客户维度表
--  *
--  * 存储客户信息表中其他未在主表中存储的数据
--  *
--  * 业务主键 user_id,ecif_id,cust_id
--  */
-- DROP TABLE IF EXISTS `dim_new.dim_cust_info`;
CREATE TABLE IF NOT EXISTS `dim_new.dim_cust_info`(
  `user_hash_no`                  string        COMMENT '用户编号',
  `cust_id`                       string        COMMENT '客户编号（渠道方编号—用户编号）',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）',
  `update_time`                   timestamp     COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）',
  `data_comment`                  string        COMMENT '注释Key_Value存储的是什么数据',
  `dim_key`                       string        COMMENT '维度Key',
  `dim_value`             map<string,string>    COMMENT '维度Value'
) COMMENT '客户维度表'
PARTITIONED BY (`product_id` string COMMENT '产品编号')
STORED AS PARQUET;


-- /**
--  * 用户维度表
--  *
--  * 存储用户信息表中其他未在主表中存储的数据
--  *
--  * 业务主键 user_id,ecif_id
--  */
-- DROP TABLE IF EXISTS `dim_new.dim_user_info`;
CREATE TABLE IF NOT EXISTS `dim_new.dim_user_info`(
  `user_hash_no`                  string        COMMENT '用户编号',
  `create_time`                   timestamp     COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）',
  `update_time`                   timestamp     COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）',
  `data_comment`                  string        COMMENT '注释Key_Value存储的是什么数据',
  `dim_key`                       string        COMMENT '维度Key',
  `dim_value`             map<string,string>    COMMENT '维度Value'
) COMMENT '用户维度表'
STORED AS PARQUET;






-- 用信信息备份表
-- DROP TABLE IF EXISTS `ods_new_s.loan_apply_bak`;
CREATE TABLE IF NOT EXISTS `ods_new_s.loan_apply_bak` like `ods_new_s.loan_apply`;

-- 借据信息备份表
-- DROP TABLE IF EXISTS `ods_new_s.loan_info_bak`;
CREATE TABLE IF NOT EXISTS `ods_new_s.loan_info_bak` like `ods_new_s.loan_info`;

-- 还款计划备份表
-- DROP TABLE IF EXISTS `ods_new_s.repay_schedule_bak`;
CREATE TABLE IF NOT EXISTS `ods_new_s.repay_schedule_bak` like `ods_new_s.repay_schedule`;

-- 实还明细备份表
-- DROP TABLE IF EXISTS `ods_new_s.repay_detail_bak`;
CREATE TABLE IF NOT EXISTS `ods_new_s.repay_detail_bak` like `ods_new_s.repay_detail`;


set spark.executor.memoryOverhead=4g;
set spark.executor.memory=4g;
set hive.auto.convert.join=false;
set hive.exec.dynamici.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=10000;
set hive.exec.max.dynamic.partitions=30000;

insert overwrite table ods_new_s.loan_apply_bak partition(biz_date,product_id)
select * from ods_new_s.loan_apply;

insert overwrite table ods_new_s.loan_info_bak partition(is_settled,product_id)
select * from ods_new_s.loan_info;

insert overwrite table ods_new_s.repay_schedule_bak partition(is_settled,product_id)
select * from ods_new_s.repay_schedule;

insert overwrite table ods_new_s.repay_detail_bak partition(biz_date,product_id)
select * from ods_new_s.repay_detail;


