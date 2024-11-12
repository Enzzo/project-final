-- Changeset 1: Создание таблицы PROJECT
create table PROJECT
(
    ID bigint auto_increment primary key,
    CODE        varchar(32)   not null,
    TITLE       varchar(1024) not null,
    DESCRIPTION varchar(4096) not null,
    TYPE_CODE   varchar(32)   not null,
    STARTPOINT  timestamp,
    ENDPOINT    timestamp,
    PARENT_ID   bigint,
    constraint UK_PROJECT_CODE unique(CODE),
    constraint FK_PROJECT_PARENT foreign key (PARENT_ID) references PROJECT(ID) on delete cascade
);

-- Changeset 2: Создание таблицы MAIL_CASE
create table MAIL_CASE
(
    ID bigint auto_increment primary key,
    EMAIL     varchar(255) not null,
    NAME      varchar(255) not null,
    DATE_TIME timestamp not null,
    RESULT    varchar(255) not null,
    TEMPLATE  varchar(255) not null
);

-- Changeset 3: Создание таблицы SPRINT
create table SPRINT
(
    ID bigint auto_increment primary key,
    STATUS_CODE varchar(32)   not null,
    STARTPOINT  timestamp,
    ENDPOINT    timestamp,
    TITLE       varchar(1024) not null,
    PROJECT_ID  bigint        not null,
    constraint FK_SPRINT_PROJECT foreign key (PROJECT_ID) references PROJECT(ID) on delete cascade
);

-- Changeset 4: Создание таблицы REFERENCE
create table REFERENCE
(
    ID bigint auto_increment primary key,
    CODE       varchar(32)   not null,
    REF_TYPE   smallint      not null,
    ENDPOINT   timestamp,
    STARTPOINT timestamp,
    TITLE      varchar(1024) not null,
    AUX        varchar,
    constraint UK_REFERENCE_REF_TYPE_CODE unique(REF_TYPE, CODE)
);

-- Changeset 5: Создание таблицы USERS
create table USERS
(
    ID bigint auto_increment primary key,
    DISPLAY_NAME varchar(32) not null,
    EMAIL        varchar(128) not null,
    FIRST_NAME   varchar(32) not null,
    LAST_NAME    varchar(32),
    PASSWORD     varchar(128) not null,
    ENDPOINT     timestamp,
    STARTPOINT   timestamp,
    constraint UK_USERS_DISPLAY_NAME unique(DISPLAY_NAME),
    constraint UK_USERS_EMAIL unique(EMAIL)
);

-- Changeset 6: Создание таблицы PROFILE
create table PROFILE
(
    ID                 bigint primary key,
    LAST_LOGIN         timestamp,
    LAST_FAILED_LOGIN  timestamp,
    MAIL_NOTIFICATIONS bigint,
    constraint FK_PROFILE_USERS foreign key (ID) references USERS(ID) on delete cascade
);

-- Changeset 7: Создание таблицы CONTACT
create table CONTACT
(
    ID    bigint not null,
    CODE  varchar(32) not null,
    VALUE varchar(256) not null,
    primary key (ID, CODE),
    constraint FK_CONTACT_PROFILE foreign key (ID) references PROFILE(ID) on delete cascade
);

-- Changeset 8: Создание таблицы TASK
create table TASK
(
    ID bigint auto_increment primary key,
    TITLE         varchar(1024) not null,
    DESCRIPTION   varchar(4096) not null,
    TYPE_CODE     varchar(32)   not null,
    STATUS_CODE   varchar(32)   not null,
    PRIORITY_CODE varchar(32)   not null,
    ESTIMATE      integer,
    UPDATED       timestamp,
    PROJECT_ID    bigint        not null,
    SPRINT_ID     bigint,
    PARENT_ID     bigint,
    STARTPOINT    timestamp,
    ENDPOINT      timestamp,
    constraint FK_TASK_SPRINT foreign key (SPRINT_ID) references SPRINT(ID) on delete set null,
    constraint FK_TASK_PROJECT foreign key (PROJECT_ID) references PROJECT(ID) on delete cascade,
    constraint FK_TASK_PARENT_TASK foreign key (PARENT_ID) references TASK(ID) on delete cascade
);

-- Changeset 9: Создание таблицы ACTIVITY
create table ACTIVITY
(
    ID bigint auto_increment primary key,
    AUTHOR_ID     bigint not null,
    TASK_ID       bigint not null,
    UPDATED       timestamp,
    COMMENT       varchar(4096),
    TITLE         varchar(1024),
    DESCRIPTION   varchar(4096),
    ESTIMATE      integer,
    TYPE_CODE     varchar(32),
    STATUS_CODE   varchar(32),
    PRIORITY_CODE varchar(32),
    constraint FK_ACTIVITY_USERS foreign key (AUTHOR_ID) references USERS(ID),
    constraint FK_ACTIVITY_TASK foreign key (TASK_ID) references TASK(ID) on delete cascade
);

-- Changeset 10: Создание таблицы TASK_TAG
create table TASK_TAG
(
    TASK_ID bigint not null,
    TAG     varchar(32) not null,
    constraint UK_TASK_TAG unique(TASK_ID, TAG),
    constraint FK_TASK_TAG foreign key (TASK_ID) references TASK(ID) on delete cascade
);

-- Changeset 11: Создание таблицы USER_BELONG
create table USER_BELONG
(
    ID bigserial primary key,
    OBJECT_ID      bigint not null,
    OBJECT_TYPE    smallint not null,
    USER_ID        bigint not null,
    USER_TYPE_CODE varchar(32) not null,
    STARTPOINT     timestamp,
    ENDPOINT       timestamp,
    constraint FK_USER_BELONG foreign key (USER_ID) references USERS(ID)
);

-- Changeset 12: Создание индекса UK_USER_BELONG
create unique index UK_USER_BELONG on USER_BELONG (OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE);

-- Changeset 13: Создание индекса IX_USER_BELONG_USER_ID
create index IX_USER_BELONG_USER_ID on USER_BELONG (USER_ID);

-- Changeset 14: Создание таблицы ATTACHMENT
create table ATTACHMENT
(
    ID bigint auto_increment primary key,
    NAME        varchar(128) not null,
    FILE_LINK   varchar(2048) not null,
    OBJECT_ID   bigint not null,
    OBJECT_TYPE smallint not null,
    USER_ID     bigint not null,
    DATE_TIME   timestamp,
    constraint FK_ATTACHMENT foreign key (USER_ID) references USERS(ID)
);

-- Changeset 15: Создание таблицы USER_ROLE
create table USER_ROLE
(
    USER_ID bigint not null,
    ROLE    smallint not null,
    constraint UK_USER_ROLE unique(USER_ID, ROLE),
    constraint FK_USER_ROLE foreign key (USER_ID) references USERS(ID) on delete cascade
);
