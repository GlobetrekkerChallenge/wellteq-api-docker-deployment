create table if not exists GoalChoice
(
    id int unsigned auto_increment
    primary key,
    title varchar(255) not null,
    value varchar(255) not null,
    created_at timestamp not null
    );

create table if not exists HRA_Choice
(
    id int unsigned auto_increment
    primary key,
    title varchar(255) null,
    value varchar(255) not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    displayOrder int null,
    `group` int null
    );

create table if not exists HRA_FocusArea
(
    id int unsigned auto_increment
    primary key,
    name varchar(255) not null,
    description varchar(255) not null,
    goalImageName varchar(255) not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null
    );

create table if not exists MS_Choice
(
    id int unsigned auto_increment
    primary key,
    title varchar(255) null,
    value varchar(255) not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null
    );

create table if not exists MS_SurveyCode
(
    id int unsigned auto_increment
    primary key,
    name varchar(255) not null,
    description varchar(255) null,
    surveyCode char(36) not null,
    type varchar(255) null,
    createdBy varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null
    );

create table if not exists MS_Question
(
    id int unsigned auto_increment
    primary key,
    surveyId int unsigned null,
    question varchar(500) not null,
    type varchar(255) not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null,
    constraint ms_question_surveyid_foreign
    foreign key (surveyId) references MS_SurveyCode (id)
    );

create table if not exists MS_QCRelation
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceId int unsigned null,
    active tinyint(1) default 1 not null,
    constraint ms_qcrelation_choiceid_foreign
    foreign key (choiceId) references MS_Choice (id),
    constraint ms_qcrelation_questionid_foreign
    foreign key (questionId) references MS_Question (id)
    );

create table if not exists RN_Nudge
(
    id int unsigned auto_increment
    primary key,
    name varchar(255) not null,
    description varchar(255) null,
    acknowledgement varchar(255) null,
    createdBy varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null,
    duration int null
    );

create table if not exists RN_Question
(
    id int unsigned auto_increment
    primary key,
    question varchar(500) not null,
    tags varchar(200) null,
    createdBy varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null
    );

create table if not exists RN_Nudge_Question
(
    id int unsigned auto_increment
    primary key,
    nudgeId int unsigned null,
    questionId int unsigned null,
    active tinyint(1) default 1 not null,
    constraint rn_nudge_question_nudgeid_foreign
    foreign key (nudgeId) references RN_Nudge (id),
    constraint rn_nudge_question_questionid_foreign
    foreign key (questionId) references RN_Question (id)
    );

create table if not exists RN_Response
(
    id int unsigned auto_increment
    primary key,
    title varchar(255) null,
    tags varchar(200) null,
    createdBy varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    active tinyint(1) default 1 not null,
    value int null
    );

create table if not exists RN_Answer
(
    id int unsigned auto_increment
    primary key,
    nudgeId int unsigned null,
    questionId int unsigned null,
    responseId int unsigned null,
    userId int unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    value int null,
    constraint rn_answer_nudgeid_foreign
    foreign key (nudgeId) references RN_Nudge (id),
    constraint rn_answer_questionid_foreign
    foreign key (questionId) references RN_Question (id),
    constraint rn_answer_responseid_foreign
    foreign key (responseId) references RN_Response (id)
    );

create table if not exists RN_Nudge_Response
(
    id int unsigned auto_increment
    primary key,
    nudgeQuestionId int unsigned null,
    responseId int unsigned null,
    active tinyint(1) default 1 not null,
    constraint rn_nudge_response_nudgequestionid_foreign
    foreign key (nudgeQuestionId) references RN_Nudge_Question (id),
    constraint rn_nudge_response_responseid_foreign
    foreign key (responseId) references RN_Response (id)
    );

create table if not exists Survey
(
    id int unsigned auto_increment
    primary key,
    name varchar(255) not null,
    code varchar(255) not null,
    created_at timestamp not null,
    constraint survey_code_unique
    unique (code),
    constraint survey_name_unique
    unique (name)
    );

create table if not exists Company
(
    id int unsigned auto_increment
    primary key,
    uuid varchar(255) not null,
    wtq_id varchar(255) null,
    surveyId int unsigned null,
    name varchar(250) not null,
    country varchar(250) not null,
    picture_url varchar(250) null,
    totalResponsesAllowed int not null,
    created_at timestamp not null,
    constraint company_uuid_unique
    unique (uuid),
    constraint company_wtq_id_unique
    unique (wtq_id),
    constraint company_surveyid_foreign
    foreign key (surveyId) references Survey (id)
    );

create table if not exists GoalQuestion
(
    id int unsigned auto_increment
    primary key,
    surveyId int unsigned null,
    parentId int unsigned null,
    question varchar(255) not null,
    type varchar(100) not null,
    created_at timestamp not null,
    constraint goalquestion_parentid_foreign
    foreign key (parentId) references GoalQuestion (id),
    constraint goalquestion_surveyid_foreign
    foreign key (surveyId) references Survey (id)
    );

create table if not exists GoalQuestionChoiceRelation
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceId int(255) unsigned null,
    value varchar(255) null,
    created_at timestamp not null,
    constraint goalquestionchoicerelation_choiceid_foreign
    foreign key (choiceId) references GoalChoice (id),
    constraint goalquestionchoicerelation_questionid_foreign
    foreign key (questionId) references GoalQuestion (id)
    );

create table if not exists GroupChallenge
(
    id int unsigned auto_increment
    primary key,
    uuid varchar(255) not null,
    wtq_id varchar(255) not null,
    start datetime null,
    end datetime null,
    companyId int unsigned null,
    created_at timestamp not null,
    constraint groupchallenge_uuid_unique
    unique (uuid),
    constraint groupchallenge_wtq_id_unique
    unique (wtq_id),
    constraint groupchallenge_companyid_foreign
    foreign key (companyId) references Company (id)
    );

create table if not exists ChallengeDetails
(
    id int unsigned auto_increment
    primary key,
    challengeId int unsigned null,
    name varchar(255) not null,
    value varchar(255) null,
    created_at timestamp not null,
    constraint challengedetails_challengeid_foreign
    foreign key (challengeId) references GroupChallenge (id)
    );

create table if not exists HRA_Challenge
(
    id int unsigned auto_increment
    primary key,
    uuid varchar(255) not null,
    name varchar(255) not null,
    start datetime null,
    end datetime null,
    companyId int unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint hra_challenge_uuid_unique
    unique (uuid),
    constraint hra_challenge_companyid_foreign
    foreign key (companyId) references Company (id)
    );

create table if not exists HRA_ChallengeDetails
(
    id int unsigned auto_increment
    primary key,
    challengeId int unsigned null,
    name varchar(255) null,
    value varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint hra_challengedetails_challengeid_foreign
    foreign key (challengeId) references HRA_Challenge (id)
    );

create table if not exists HRA_GroupChallenge
(
    id int unsigned auto_increment
    primary key,
    uuid varchar(255) not null,
    start datetime null,
    end datetime null,
    challengeId int unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint hra_groupchallenge_uuid_unique
    unique (uuid),
    constraint hra_groupchallenge_challengeid_foreign
    foreign key (challengeId) references HRA_Challenge (id)
    );

create table if not exists HRA_Pillar
(
    id int unsigned auto_increment
    primary key,
    name varchar(100) not null comment 'Pillar full name',
    shortName varchar(15) not null,
    surveyId int unsigned not null comment 'Foreign key to Survey table',
    displayOrder int null comment 'The order to show the pillar questions to user',
    `desc` varchar(500) not null comment 'Short description of the pillar. Will be displayed in the survey intro page.',
    summaryHeader varchar(1000) not null comment 'The header text for the popup that shows when starting on qns from the respective pillar',
    summaryBody varchar(1000) not null comment 'The body text for the popup that shows when starting on qns from the respective pillar',
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint hra_pillar_surveyid_foreign
    foreign key (surveyId) references Survey (id)
    );

create table if not exists HRA_Question
(
    id int unsigned auto_increment
    primary key,
    surveyId int unsigned null,
    parentId int unsigned null,
    question varchar(500) not null,
    groupNumber varchar(255) not null,
    type varchar(255) not null,
    level int null,
    created_at timestamp not null,
    displayOrder int null comment 'The order to show the pillar questions to user',
    var_name varchar(15) not null comment 'The order to show the pillar questions to user',
    rptTxt1 varchar(600) null,
    rptTxt2 varchar(600) not null comment 'Text to show in intro popup at the bottom when user started to answer questions abt the pillar',
    name varchar(30) not null comment 'Name of dimension or pillar',
    shortName varchar(15) not null comment 'Shorten version of name of dimension or pillar. Used in report page vertical bar',
    valueMax int unsigned default 100 null comment 'Max value for answer. For report to calculate the display value as a percentage of this max.',
    pillarId int unsigned null comment 'The pillar that this question is for',
    enabledOnParentChoice int null,
    valueMin int null,
    allowSkip tinyint null,
    reportFlag int default 1 null,
    isGoal int default 0 null,
    goalImageName varchar(600) null,
    displayName varchar(300) not null comment 'Text to show on goal selection page',
    constraint hra_question_parentid_foreign
    foreign key (parentId) references HRA_Question (id),
    constraint hra_question_pillarid_foreign
    foreign key (pillarId) references HRA_Pillar (id),
    constraint hra_question_surveyid_foreign
    foreign key (surveyId) references Survey (id)
    );

create table if not exists HRA_DFPRelation
(
    id int unsigned auto_increment
    primary key,
    dimensionId int unsigned null,
    focusAreaId int unsigned null,
    pillarId int unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint hra_dfprelation_dimensionid_foreign
    foreign key (dimensionId) references HRA_Question (id),
    constraint hra_dfprelation_focusareaid_foreign
    foreign key (focusAreaId) references HRA_FocusArea (id),
    constraint hra_dfprelation_pillarid_foreign
    foreign key (pillarId) references HRA_Pillar (id)
    );

create table if not exists HRA_QCRelation
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceId int unsigned null,
    constraint hra_qcrelation_choiceid_foreign
    foreign key (choiceId) references HRA_Choice (id),
    constraint hra_qcrelation_questionid_foreign
    foreign key (questionId) references HRA_Question (id)
    );

create table if not exists HRA_SumCache
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    `from` int not null,
    `to` int not null,
    sum int not null,
    created_at timestamp not null,
    constraint hra_sumcache_questionid_foreign
    foreign key (questionId) references HRA_Question (id)
    );

create table if not exists SumCache
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    `from` int not null,
    `to` int not null,
    sum int not null,
    created_at timestamp not null,
    constraint sumcache_questionid_foreign
    foreign key (questionId) references HRA_Question (id)
    );

create table if not exists SurveyQuestion
(
    id int unsigned auto_increment
    primary key,
    surveyId int unsigned null,
    question varchar(255) not null,
    groupNumber varchar(255) not null,
    type varchar(255) not null,
    created_at timestamp not null,
    constraint surveyquestion_surveyid_foreign
    foreign key (surveyId) references Survey (id)
    );

create table if not exists SurveyChoices
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceValue varchar(255) not null,
    created_at timestamp not null,
    constraint surveychoices_questionid_foreign
    foreign key (questionId) references SurveyQuestion (id)
    );

create table if not exists User
(
    id int unsigned auto_increment
    primary key,
    uuid varchar(255) not null,
    wtq_id varchar(255) null,
    companyId int unsigned null,
    country varchar(255) not null,
    snooze timestamp null,
    created_at timestamp not null default CURRENT_TIMESTAMP,
    constraint user_uuid_unique
    unique (uuid),
    constraint user_wtq_id_unique
    unique (wtq_id),
    constraint user_companyid_foreign
    foreign key (companyId) references Company (id)
    );

create table if not exists GoalAnswer
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceId int(255) unsigned null,
    userId int(255) unsigned null,
    value varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    surveyNumber int null,
    constraint goalanswer_choiceid_foreign
    foreign key (choiceId) references GoalChoice (id),
    constraint goalanswer_questionid_foreign
    foreign key (questionId) references GoalQuestion (id),
    constraint goalanswer_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists GoalHistory
(
    id int unsigned auto_increment
    primary key,
    userId int unsigned null,
    surveyId int unsigned null,
    doneDate date null,
    number int null,
    created_at timestamp not null,
    constraint goalhistory_surveyid_foreign
    foreign key (surveyId) references Survey (id),
    constraint goalhistory_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists HRA_Answer
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceId int unsigned null,
    userId int unsigned null,
    companyId int unsigned null,
    challengeId int unsigned null,
    answer varchar(255) null,
    surveyNumber int null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    value varchar(255) null,
    constraint hra_answer_challengeid_foreign
    foreign key (challengeId) references HRA_Challenge (id),
    constraint hra_answer_choiceid_foreign
    foreign key (choiceId) references HRA_Choice (id),
    constraint hra_answer_companyid_foreign
    foreign key (companyId) references Company (id),
    constraint hra_answer_questionid_foreign
    foreign key (questionId) references HRA_Question (id),
    constraint hra_answer_userid_foreign
    foreign key (userId) references User (id)
);

create table if not exists HRA_SurveyHistory
(
    id int unsigned auto_increment
    primary key,
    userId int unsigned null,
    surveyId int unsigned null,
    doneDate date null,
    number int null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    level int null comment 'The level of survey',
    constraint hra_surveyhistory_surveyid_foreign
    foreign key (surveyId) references Survey (id),
    constraint hra_surveyhistory_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists MS_Session
(
    id int unsigned auto_increment
    primary key,
    userId int unsigned null,
    surveyId int unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint ms_session_surveyid_foreign
    foreign key (surveyId) references MS_SurveyCode (id),
    constraint ms_session_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists MS_Answer
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    surveyId int unsigned null,
    choiceId int unsigned null,
    userId int unsigned null,
    companyId int unsigned null,
    sessionId int unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    constraint ms_answer_choiceid_foreign
    foreign key (choiceId) references MS_Choice (id),
    constraint ms_answer_companyid_foreign
    foreign key (companyId) references Company (id),
    constraint ms_answer_questionid_foreign
    foreign key (questionId) references MS_Question (id),
    constraint ms_answer_sessionid_foreign
    foreign key (sessionId) references MS_Session (id),
    constraint ms_answer_surveyid_foreign
    foreign key (surveyId) references MS_SurveyCode (id),
    constraint ms_answer_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists SurveyAnswers
(
    id int unsigned auto_increment
    primary key,
    questionId int unsigned null,
    choiceId int unsigned null,
    companyId int unsigned null,
    userId int unsigned null,
    created_at timestamp not null,
    constraint surveyanswers_choiceid_foreign
    foreign key (choiceId) references SurveyChoices (id),
    constraint surveyanswers_companyid_foreign
    foreign key (companyId) references Company (id),
    constraint surveyanswers_questionid_foreign
    foreign key (questionId) references SurveyQuestion (id),
    constraint surveyanswers_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists UserAttribute
(
    id int unsigned auto_increment
    primary key,
    userId int unsigned null,
    name varchar(255) not null,
    value varchar(255) null,
    created_at timestamp not null default CURRENT_TIMESTAMP,
    constraint userattribute_userid_foreign
    foreign key (userId) references User (id)
    );

create table if not exists knex_migrations
(
    id int unsigned auto_increment
    primary key,
    name varchar(255) null,
    batch int null,
    migration_time timestamp null
    );

create table if not exists knex_migrations_lock
(
    `index` int unsigned auto_increment
    primary key,
    is_locked int null
);

