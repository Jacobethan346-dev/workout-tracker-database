USE workout_tracker_portfolio;
DELIMITER $$
CREATE TRIGGER trg_auto_pr
AFTER INSERT ON WORKOUT_SETS
FOR EACH ROW
BEGIN
    DECLARE v_uid INT;
    DECLARE v_workout_date DATE;
    SELECT UserID, WorkoutDate INTO v_uid, v_workout_date
    FROM WORKOUTS WHERE WorkoutID = NEW.WorkoutID;

    IF NEW.Reps = 1 AND NEW.Weight > 0 THEN
        INSERT INTO PERSONAL_RECORDS
            (UserID, ExerciseID, RecordType, Weight, DateAchieved)
        VALUES (v_uid, NEW.ExerciseID, '1RM', NEW.Weight, v_workout_date)
        ON DUPLICATE KEY UPDATE
            -- Compare against the old weight before replacing it.
            DateAchieved = IF(NEW.Weight > Weight, v_workout_date, DateAchieved),
            Weight = GREATEST(Weight, NEW.Weight);
    END IF;
END$$
DELIMITER ;
