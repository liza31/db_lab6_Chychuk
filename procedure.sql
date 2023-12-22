-- процедура що видаляє однакові ракети / дрони(дублікати)
DROP PROCEDURE IF EXISTS remove_duplicate_missiles;

CREATE PROCEDURE remove_duplicate_missiles()
LANGUAGE SQL
AS $$
    DELETE
    FROM
        missiles m1
        USING missiles m2
        WHERE m1.model_name = m2.model_name
        AND m1.missile_id > m2.missile_id;
$$;
