DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS section;
DROP TABLE IF EXISTS card;
DROP TABLE IF EXISTS log;

CREATE TABLE IF NOT EXISTS board (
    id INTEGER auto_increment primary key
);

CREATE TABLE IF NOT EXISTS user (
    id INTEGER auto_increment primary key ,
    name varchar(64) unique not null ,
    password varchar(64) not null,
    board INTEGER references board(id) ,
    board_key INTEGER
);

CREATE TABLE IF NOT EXISTS section (
    id INTEGER auto_increment primary key ,
    title varchar(100) not null ,
    create_date_time timestamp not null default current_timestamp ,
    update_date_time timestamp not null default current_timestamp on update current_timestamp ,
    deleted boolean ,
    board INTEGER references board(id)
);

CREATE TABLE IF NOT EXISTS card (
  id INTEGER auto_increment primary key ,
  title varchar(100) ,
  content varchar(500) not null ,
  create_date_time timestamp not null default current_timestamp ,
  update_date_time timestamp not null default current_timestamp ,
  author varchar(64) ,
  deleted boolean ,
  user INTEGER references user(id) ,
  section INTEGER references section(id) ,
  section_key INTEGER
);

CREATE TABLE IF NOT EXISTS log (
  id INTEGER auto_increment primary key ,
  user varchar(64) ,
  action enum('ADDED', 'REMOVED', 'UPDATED', 'MOVED') ,
  target enum('SECTION', 'CARD') ,
  title varchar(100) ,
  content varchar(500) ,     /* source와 destination이 모두 null이면 target이 section이어야 한다. */
  source varchar(100) ,    /* section */
  destination varchar(100) ,        /* section */
  create_date_time timestamp not null default current_timestamp ,
  board INTEGER references board(id)
);
