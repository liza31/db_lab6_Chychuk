-- функція що знаходить загальну кількість знищеної ворожої техніки за конкретний місяць

DROP FUNCTION IF EXISTS total_destroyed_items(date_year INT,
                                              date_month INT);
												
CREATE OR REPLACE FUNCTION total_destroyed_items(date_year INT,
                                                 date_month INT)
RETURNS TABLE (total_destroyed INT)
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS date_destroyed AS
        SELECT
            date_part('year', attacks.start_datatime)::INT AS year,
            date_part('month', attacks.start_datatime)::INT AS month,
            sum(attack_groups.units_destroyed)::INT AS destroyed_items
        FROM
            attacks
            JOIN attack_groups USING (attack_id)
        GROUP BY
            year, month;

    RETURN QUERY
        SELECT
            destroyed_items
        FROM
            date_destroyed
        WHERE
            (year = date_year) AND (month = date_month);
END;
$$
