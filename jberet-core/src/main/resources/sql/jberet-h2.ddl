CREATE TABLE IF NOT EXISTS JOB_INSTANCE
(
  JOBINSTANCEID   IDENTITY PRIMARY KEY NOT NULL,
  JOBNAME         VARCHAR(512),
  APPLICATIONNAME VARCHAR(512)
);
CREATE TABLE IF NOT EXISTS JOB_EXECUTION
(
  JOBEXECUTIONID  IDENTITY PRIMARY KEY NOT NULL,
  JOBINSTANCEID   BIGINT             NOT NULL,
  CREATETIME      TIMESTAMP,
  STARTTIME       TIMESTAMP,
  ENDTIME         TIMESTAMP,
  LASTUPDATEDTIME TIMESTAMP,
  BATCHSTATUS     VARCHAR(30),
  EXITSTATUS      VARCHAR(512),
  JOBPARAMETERS   VARCHAR(3000),
  FOREIGN KEY (JOBINSTANCEID) REFERENCES JOB_INSTANCE (JOBINSTANCEID)
);
CREATE TABLE IF NOT EXISTS STEP_EXECUTION
(
  STEPEXECUTIONID    IDENTITY PRIMARY KEY NOT NULL,
  JOBEXECUTIONID     BIGINT             NOT NULL,
  STEPNAME           VARCHAR(255),
  STARTTIME          TIMESTAMP,
  ENDTIME            TIMESTAMP,
  BATCHSTATUS        VARCHAR(30),
  EXITSTATUS         VARCHAR(512),
  PERSISTENTUSERDATA BINARY(2147483647),
  READCOUNT          INTEGER,
  WRITECOUNT         INTEGER,
  COMMITCOUNT        INTEGER,
  ROLLBACKCOUNT      INTEGER,
  READSKIPCOUNT      INTEGER,
  PROCESSSKIPCOUNT   INTEGER,
  FILTERCOUNT        INTEGER,
  WRITESKIPCOUNT     INTEGER,
  READERCHECKPOINTINFO  BINARY(3000),
  WRITERCHECKPOINTINFO  BINARY(3000),
  FOREIGN KEY (JOBEXECUTIONID) REFERENCES JOB_EXECUTION (JOBEXECUTIONID)
);
CREATE TABLE IF NOT EXISTS PARTITION_EXECUTION
(
  PARTITIONEXECUTIONID  INTEGER NOT NULL,
  STEPEXECUTIONID       BIGINT  NOT NULL,
  BATCHSTATUS           VARCHAR(30),
  EXITSTATUS            VARCHAR(512),
  PERSISTENTUSERDATA    BINARY(2147483647),
  READERCHECKPOINTINFO  BINARY(3000),
  WRITERCHECKPOINTINFO  BINARY(3000),
  PRIMARY KEY (PARTITIONEXECUTIONID, STEPEXECUTIONID),
  FOREIGN KEY (STEPEXECUTIONID) REFERENCES STEP_EXECUTION (STEPEXECUTIONID)
);

