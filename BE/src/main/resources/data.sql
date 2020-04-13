INSERT INTO board (title) values ('TODO 서비스');
INSERT INTO user (email, password, board) VALUES ('nigayo', '1234', 1);
INSERT INTO section (title, create_date_time, board) VALUES ('해야할 일', CURRENT_TIMESTAMP(), 1);
INSERT INTO section (title, create_date_time, board) VALUES ('하고 있는 일', CURRENT_TIMESTAMP(), 1);
INSERT INTO section (title, create_date_time, board) VALUES ('완료된 일', CURRENT_TIMESTAMP(), 1);
INSERT INTO card (title, content, create_date_time, user, section) VALUES ('래해야', 'dfdf', CURRENT_TIMESTAMP(), 1, 1);
INSERT INTO card (title, content, create_date_time, user, section) VALUES ('됨하는', 'dfdf', CURRENT_TIMESTAMP(), 1, 1);
-- INSERT INTO card (title, content, create_date_time, user, section) VALUES ('중다', 'dfdf', CURRENT_TIMESTAMP(), 1, 3);
