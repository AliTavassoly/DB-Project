-- user's notifications
-- company's notifications
-- user's cvs
-- user's courses

DROP PROCEDURE IF EXISTS QueraEcoPlus.new_user;

CREATE PROCEDURE QueraEcoPlus.new_user(EMAIL_ADD_IN varchar(15), FIRST_NAME_IN varchar(10), 
                            LAST_NAME_IN varchar(20), NATIONAL_ID_IN varchar(10))
BEGIN
    DECLARE user_id INT;
    DECLARE mx INT;
    DECLARE view_name varchar(100);
    DECLARE sttmnt varchar(100);

    SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES 
            WHERE TABLE_SCHEMA = 'QueraEcoPlus'
            AND TABLE_NAME = 'USER' INTO user_id;

    SELECT MAX(USER.USER_ID) FROM USER INTO mx;

    INSERT INTO QueraEcoPlus.USER (EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID)
        VALUES  (EMAIL_ADD_IN, FIRST_NAME_IN, LAST_NAME_IN, NATIONAL_ID_IN);

    SET @sttmnt = CONCAT('CREATE VIEW QueraEcoPlus.view_', mx + 1,' AS SELECT USER.USER_ID, EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID FROM USER WHERE USER.USER_ID = ', mx + 1);

    PREPARE exectutable FROM @sttmnt;
    EXECUTE exectutable;

END;

CALL QueraEcoPlus.new_user('email_jadid', 'fn_jadid', 'ln_jadid', '133133133');
-- 
-- user's contests