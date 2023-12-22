DROP TRIGGER IF EXISTS trigger_update_attacks ON attacks;
DROP FUNCTION IF EXISTS update_attacks();

CREATE OR REPLACE FUNCTION update_attacks()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.end_datetime < NEW.start_datatime THEN
    RAISE EXCEPTION 'end_datetime must be greater or equal to start_datatime';
  ELSE
    RETURN NEW;
  END IF;
END;
$$;


CREATE TRIGGER trigger_update_attacks
AFTER INSERT OR UPDATE
ON attacks
FOR EACH ROW
EXECUTE FUNCTION update_attacks();
