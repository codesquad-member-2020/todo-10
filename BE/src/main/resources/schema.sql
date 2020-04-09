DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS section;
DROP TABLE IF EXISTS card;
DROP TABLE IF EXISTS log;

CREATE TABLE IF NOT EXISTS user (
    id bigint auto_increment primary key ,
    email varchar(64) unique not null ,
    password varchar(64) not null
);

CREATE TABLE IF NOT EXISTS section (
    id bigint auto_increment primary key ,
    user bigint references user(id) ,
    title varchar(100) not null ,
    create_date_time timestamp not null default current_timestamp ,
    update_date_time timestamp not null default current_timestamp on update current_timestamp ,
    user_key bigint
);

CREATE TABLE IF NOT EXISTS card (
  id bigint auto_increment primary key ,
  section bigint references section(id) ,
  title varchar(100) ,
  content varchar(500) not null ,
  create_date_time timestamp not null default current_timestamp ,
  update_date_time timestamp not null default current_timestamp on update current_timestamp ,
  section_key bigint
);

CREATE TABLE IF NOT EXISTS log (
  id bigint auto_increment primary key ,
  user bigint references user(id) ,
  action enum('added', 'updated', 'moved', 'removed') not null ,
  type enum('section', 'card') not null ,
  source varchar(500) not null ,
  destination varchar(500) ,
  create_date_time timestamp not null default current_timestamp ,
  user_key bigint
);
