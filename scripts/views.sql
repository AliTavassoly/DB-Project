DROP PROCEDURE IF EXISTS QueraEcoPlus.new_user;

CREATE PROCEDURE QueraEcoPlus.new_user(EMAIL_ADD_IN varchar(15), FIRST_NAME_IN varchar(10), 
                            LAST_NAME_IN varchar(20), NATIONAL_ID_IN varchar(10))
BEGIN
    DECLARE mx INT;
    DECLARE cnt INT;
    DECLARE credential_str varchar(200);
    DECLARE contest_str varchar(200);
    DECLARE courses_str varchar(200);
    DECLARE notif_str varchar(200);

    SET mx = 0;

    SELECT COUNT(USER.USER_ID) FROM USER INTO cnt;

    IF cnt > 0
        THEN SELECT MAX(USER.USER_ID) FROM USER INTO mx;
    END IF;

    INSERT INTO QueraEcoPlus.USER (EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID)
        VALUES  (EMAIL_ADD_IN, FIRST_NAME_IN, LAST_NAME_IN, NATIONAL_ID_IN);

    SET @credential_str = CONCAT('CREATE VIEW QueraEcoPlus.view_credential_', mx + 1, ' AS SELECT * FROM USER WHERE USER.USER_ID = ', mx + 1);
    
    SET @contest_str = CONCAT('CREATE VIEW QueraEcoPlus.view_contest_', mx + 1, ' AS SELECT * FROM CONTEST 
        WHERE CONTEST_ID IN (SELECT CONTEST_ID FROM CONTEST_PARTICIPANTS WHERE USER_ID = ', mx + 1, ' )');

    SET @courses_str = CONCAT('CREATE VIEW QueraEcoPlus.view_course_', mx + 1, ' AS SELECT * FROM COURSE 
        WHERE COURSE_ID IN (SELECT COURSE_ID FROM CRS_PARTICIPANTS WHERE USER_ID = ', mx + 1, ' )');

    SET @notif_str = CONCAT('CREATE VIEW QueraEcoPlus.view_notif_', mx + 1, ' AS SELECT * FROM NOTIFICATION 
        WHERE NOTIFICATION_ID IN (SELECT NOTIFICATION_ID FROM USER_NOTIFICATION WHERE USER_ID = ', mx + 1, ' )');

    PREPARE exectutable FROM @credential_str;
    EXECUTE exectutable;

    PREPARE exectutable FROM @contest_str;
    EXECUTE exectutable;

    PREPARE exectutable FROM @courses_str;
    EXECUTE exectutable;

    PREPARE exectutable FROM @notif_str;
    EXECUTE exectutable;
END;

CALL QueraEcoPlus.new_user('email_1', 'fn_1', 'ln_1', '1111111');