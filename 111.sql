
drop table CS_TXN_QUEUE;
-- auto-generated definition
create table CS_TXN_QUEUE
(
    ID         VARCHAR2(40),
    PID        VARCHAR2(40),
    CORE_ID    VARCHAR2(20),
    AMOUNT     NUMBER(18),
    PLACE_FLAG CHAR(2),
    STATUS     CHAR(2),
    REMARK     VARCHAR2(200),
    IN_TIME    CHAR(14),
    OUT_TIME   CHAR(14),
    MD_TLRNO   VARCHAR2(20),
    MD_TIME    CHAR(14),
    AUD_TLRNO  VARCHAR2(20),
    AUD_TIME   CHAR(14)
)
/

comment on table CS_TXN_QUEUE is '交易排队表'
/

comment on column CS_TXN_QUEUE.ID is '主键'
/

comment on column CS_TXN_QUEUE.PID is '父ID'
/

comment on column CS_TXN_QUEUE.CORE_ID is '流水号'
/

comment on column CS_TXN_QUEUE.AMOUNT is '金额'
/

comment on column CS_TXN_QUEUE.PLACE_FLAG is '位置（队首：01，队尾：02）'
/

comment on column CS_TXN_QUEUE.STATUS is '状态（00：有效）'
/

comment on column CS_TXN_QUEUE.REMARK is '备注'
/

comment on column CS_TXN_QUEUE.IN_TIME is '入队时间'
/

comment on column CS_TXN_QUEUE.OUT_TIME is '出队时间'
/

comment on column CS_TXN_QUEUE.MD_TLRNO is '录入操作员'
/

comment on column CS_TXN_QUEUE.MD_TIME is '录入时间'
/

comment on column CS_TXN_QUEUE.AUD_TLRNO is '审核操作员'
/

comment on column CS_TXN_QUEUE.AUD_TIME is '审核时间'
/


drop table CS_TXN_QUEUE_TMP;
-- auto-generated definition
create table CS_TXN_QUEUE_TMP
(
    ID             VARCHAR2(40),
    QID            VARCHAR2(40),
    PID            VARCHAR2(40),
    CORE_ID        VARCHAR2(20),
    AMOUNT         NUMBER(18),
    PLACE_FLAG     CHAR(2),
    STATUS         CHAR(2),
    REMARK         VARCHAR2(200),
    IN_TIME        CHAR(14),
    OUT_TIME       CHAR(14),
    MD_TLRNO       VARCHAR2(20),
    MD_TIME        CHAR(14),
    AUD_TLRNO      VARCHAR2(20),
    AUD_TIME       CHAR(14),
    SYS_TYPE_QUEUE CHAR(2),
    OP_STATUS      CHAR(2)
)
/

comment on table CS_TXN_QUEUE_TMP is '交易排队临时表'
/

comment on column CS_TXN_QUEUE_TMP.ID is '主键'
/

comment on column CS_TXN_QUEUE_TMP.QID is '队列ID'
/

comment on column CS_TXN_QUEUE_TMP.PID is '父ID'
/

comment on column CS_TXN_QUEUE_TMP.CORE_ID is '流水号'
/

comment on column CS_TXN_QUEUE_TMP.AMOUNT is '金额'
/

comment on column CS_TXN_QUEUE_TMP.PLACE_FLAG is '位置（队首：01，队尾：02）'
/

comment on column CS_TXN_QUEUE_TMP.STATUS is '状态（00：有效）'
/

comment on column CS_TXN_QUEUE_TMP.REMARK is '备注'
/

comment on column CS_TXN_QUEUE_TMP.IN_TIME is '入队时间'
/

comment on column CS_TXN_QUEUE_TMP.OUT_TIME is '出队时间'
/

comment on column CS_TXN_QUEUE_TMP.MD_TLRNO is '录入操作员'
/

comment on column CS_TXN_QUEUE_TMP.MD_TIME is '录入时间'
/

comment on column CS_TXN_QUEUE_TMP.AUD_TLRNO is '审核操作员'
/

comment on column CS_TXN_QUEUE_TMP.AUD_TIME is '审核时间'
/

comment on column CS_TXN_QUEUE_TMP.SYS_TYPE_QUEUE is '队列操作类型（01-移至队首、02移至队尾）'
/

comment on column CS_TXN_QUEUE_TMP.OP_STATUS is '审核状态(01-已录入、02-已审核、03-已拒绝)'
/


INSERT INTO CP2_SCHEDULE_TASK (SCHEDULE_ID, SCHEDULE_NAME, SCHEDULE_BEAN, SCHEDULE_TYPE, SCHEDULE_EXPR, STATUS) 
VALUES ('9', '行内排队', 'csQueueTask', 'cron', '0 0/1 * * * ?', 1);


delete from CP2_SCHEDULE_TASK where SCHEDULE_BEAN='taskSaps366';
INSERT INTO CP2_SCHEDULE_TASK (SCHEDULE_ID, SCHEDULE_NAME, SCHEDULE_BEAN, SCHEDULE_TYPE, SCHEDULE_EXPR, STATUS) 
VALUES ('1', '账户余额查询', 'taskSaps366', 'cron', '0 */15 * * * ?', 0);