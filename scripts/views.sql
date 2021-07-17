-- user's notifications
-- company's notifications
-- user's cvs
-- user's courses

-- INSERT INTO QueraEcoPlus.USER (EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID)
--        VALUES  ('E1d', 'FIRST', 'LAST', 'NATIONAL');

-- SELECT * FROM QueraEcoPlus.USER WHERE EMAIL_ADD = CONCAT('E', 1, 'd');

CREATE FUNCTION new_user(EMAIL_ADD_IN varchar(15), FIRST_NAME_IN varchar(10), 
                            LAST_NAME_IN varchar(10), NATIONAL_ID_IN varchar(10))
RETURNS INT

BEGIN
    DECLARE user_id INT;

    SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES 
            WHERE TABLE_NAME = 'USER' INTO user_id;

    INSERT INTO QueraEcoPlus.USER (USER_ID, EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID)
        VALUES  (user_id, EMAIL_ADD_IN, FIRST_NAME_IN, LAST_NAME_IN, NATIONAL_ID_IN);

    -- CREATE VIEW CONCAT('user_', user_id, '_view') AS SELECT USER_ID, EMAIL_ADD, FIRST_NAME, LAST_NAME, NATIONAL_ID
    --    FROM USER;
END;

new_user('E', 'FN', 'LN', '240');

-- user's contests