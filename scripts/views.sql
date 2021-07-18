-- user's notifications
-- company's notifications
-- user's cvs
-- user's courses

-- INSERT INTO QueraEcoPlus.USER (EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID)
--        VALUES  ('E1d', 'FIRST', 'LAST', 'NATIONAL');

-- SELECT * FROM QueraEcoPlus.USER WHERE EMAIL_ADD = CONCAT('E', 1, 'd');

/* DELIMITER //

CREATE PROCEDURE create_view()
BEGIN
      CREATE VIEW v1 AS SELECT USER_ID, EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID
        FROM USER;
END //

DELIMITER ; */

DELIMITER //

CREATE PROCEDURE new_user(EMAIL_ADD_IN varchar(15), FIRST_NAME_IN varchar(10), 
                            LAST_NAME_IN varchar(10), NATIONAL_ID_IN varchar(10))
BEGIN
    DECLARE user_id INT;
    DECLARE view_name varchar(100);

    SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES 
            WHERE TABLE_SCHEMA = 'QueraEcoPlus'
            AND TABLE_NAME = 'USER' INTO user_id;

    SET view_name = CONCAT('user_', user_id, '_view');

    INSERT INTO QueraEcoPlus.USER (EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID)
        VALUES  (EMAIL_ADD_IN, FIRST_NAME_IN, LAST_NAME_IN, NATIONAL_ID_IN);

    CREATE VIEW @view_name AS SELECT USER.USER_ID, EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID
        FROM USER;
END;

CALL new_user('EEDA', 'FDAN', 'LADN', '2400');

-- user's contests