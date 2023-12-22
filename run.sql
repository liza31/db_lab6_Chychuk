-- демонстрація роботи функції
-- дивимося всі атаки(і кількість знищених в тому числі) та їх дату-час
SELECT * FROM attacks JOIN attack_groups USING (attack_id);
-- дивимося кількість знищених в жовтні(10) 2022 року
SELECT total_destroyed_items(2022, 10);

-- демонстрація роботи процедури
-- додаємо записи про ракети, які вже є, тобто дублікати
INSERT INTO
    missiles (model_name)
VALUES
    ('Shahed-136/131'),
    ('X-101/X-555'),
    ('Kalibr'),
    ('X-59'),
    ('X-22'),
    ('X-59'),
    ('X-47 Kinzhal');
-- дивимося, що дублікати з'явились
SELECT * FROM missiles;
-- викликаємо функцію видалення дублікатів
CALL remove_duplicate_missiles();
-- знову дивимося всі ракети і дрони, бачимо, що дублікати видалено
SELECT * FROM missiles;

-- демонстрація роботи тригера
-- вставка без помилки
INSERT INTO
    attacks (start_datatime, end_datetime)
VALUES
    ('2023-12-22 11:43', '2023-12-22 12:17');
-- вставка з помилкою - некоректна дата кінця атаки
INSERT INTO
    attacks (start_datatime, end_datetime)
VALUES
    ('2023-12-22 11:43', '2023-12-22 10:17');
