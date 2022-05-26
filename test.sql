
--2022-05-18
comment on column CS_BALANCE_DETAIL.CD_INDICATOR is '借贷标志(C:贷记，D:借记)'
/

alter table CS_BALANCE_DETAIL modify CD_INDICATOR VARCHAR2(4)
/

--2022-05-20





comment on column CS_TXN_QUEUE.STATUS is '状态（00：有效，01：无效、已出队，02：正在出队） '
/

--2022-05-25

drop table CS_TXN_QUEUE_BEPS;
create table CS_TXN_QUEUE_BEPS
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

comment on table CS_TXN_QUEUE_BEPS is '交易排队表'
/

comment on column CS_TXN_QUEUE_BEPS.ID is '主键'
/

comment on column CS_TXN_QUEUE_BEPS.PID is '父ID'
/

comment on column CS_TXN_QUEUE_BEPS.CORE_ID is '流水号'
/

comment on column CS_TXN_QUEUE_BEPS.AMOUNT is '金额'
/

comment on column CS_TXN_QUEUE_BEPS.PLACE_FLAG is '位置（队首：01，队尾：02）'
/

comment on column CS_TXN_QUEUE_BEPS.STATUS is '状态（00：有效，01：无效、已出队，02：正在出队）'
/

comment on column CS_TXN_QUEUE_BEPS.REMARK is '备注'
/

comment on column CS_TXN_QUEUE_BEPS.IN_TIME is '入队时间'
/

comment on column CS_TXN_QUEUE_BEPS.OUT_TIME is '出队时间'
/

comment on column CS_TXN_QUEUE_BEPS.MD_TLRNO is '录入操作员'
/

comment on column CS_TXN_QUEUE_BEPS.MD_TIME is '录入时间'
/

comment on column CS_TXN_QUEUE_BEPS.AUD_TLRNO is '审核操作员'
/

comment on column CS_TXN_QUEUE_BEPS.AUD_TIME is '审核时间'
/



CREATE or REPLACE VIEW V_CS_TXN_QUEUE as
SELECT * FROM CS_TXN_QUEUE
UNION ALL
SELECT * FROM CS_TXN_QUEUE_BEPS;

delete from Cp2_Schedule_Task  where SCHEDULE_ID='9';
delete from Cp2_Schedule_Task  where SCHEDULE_ID='10';


INSERT INTO CP2_SCHEDULE_TASK (SCHEDULE_ID, SCHEDULE_NAME, SCHEDULE_BEAN, SCHEDULE_TYPE, SCHEDULE_EXPR, STATUS) 
VALUES ('9',  '行内排队-大额', 'taskCsQueueHvps', 'cron', '0 0/2 * * * ?', 0);

INSERT INTO CP2_SCHEDULE_TASK (SCHEDULE_ID, SCHEDULE_NAME, SCHEDULE_BEAN, SCHEDULE_TYPE, SCHEDULE_EXPR, STATUS) 
VALUES ('10', '行内排队-小额', 'taskCsQueueBeps', 'cron', '0 1/2 * * * ?', 0);