INSERT INTO board (id) values (1);

INSERT INTO user (name, password, board, board_key) VALUES ('nigayo', '1234', 1, 0);

INSERT INTO section (title, create_date_time, deleted, board) VALUES ('해야할 일', CURRENT_TIMESTAMP(), false, 1);
INSERT INTO section (title, create_date_time, deleted, board) VALUES ('하고 있는 일', CURRENT_TIMESTAMP(), false, 1);
INSERT INTO section (title, create_date_time, deleted, board) VALUES ('완료된 일', CURRENT_TIMESTAMP(), false, 1);
INSERT INTO section (title, create_date_time, deleted, board) VALUES ('사라진 일', CURRENT_TIMESTAMP(), true, 1);
