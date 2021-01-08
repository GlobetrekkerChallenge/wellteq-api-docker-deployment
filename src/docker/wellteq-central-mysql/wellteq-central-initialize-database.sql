create table if not exists knex_migrations
(
    id int unsigned auto_increment
    primary key,
    name varchar(255) null,
    batch int null,
    migration_time timestamp null
    )
    charset=utf8;

create table if not exists knex_migrations_lock
(
    `index` int unsigned auto_increment
    primary key,
    is_locked int null
)
    charset=utf8;

create table if not exists user
(
    id int unsigned auto_increment
    primary key,
    UUID varchar(255) not null,
    WTQ_ID varchar(255) null,
    FRA_ID varchar(255) not null,
    HRA_ID varchar(255) not null,
    FEEDAPI_ID varchar(255) not null,
    fname varchar(255) null,
    lname varchar(255) null,
    email varchar(255) null,
    companyId varchar(255) null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint user_feedapi_id_unique
    unique (FEEDAPI_ID),
    constraint user_fra_id_unique
    unique (FRA_ID),
    constraint user_hra_id_unique
    unique (HRA_ID),
    constraint user_uuid_unique
    unique (UUID),
    constraint user_wtq_id_unique
    unique (WTQ_ID)
    );

