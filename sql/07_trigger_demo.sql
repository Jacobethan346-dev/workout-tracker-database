-- A reversible demonstration: the inserted set and PR update are rolled back.
USE workout_tracker_portfolio;
START TRANSACTION;
SELECT 'BEFORE' AS Stage, Weight, DateAchieved FROM PERSONAL_RECORDS
WHERE UserID=1 AND ExerciseID=1 AND RecordType='1RM';
INSERT INTO WORKOUT_SETS
    (WorkoutID,ExerciseID,SetNumber,Weight,Reps,RPE,RestSeconds)
VALUES (10,1,99,130,1,10,300);
SELECT 'AFTER' AS Stage, Weight, DateAchieved FROM PERSONAL_RECORDS
WHERE UserID=1 AND ExerciseID=1 AND RecordType='1RM';
-- Expected: 120 kg dated 2026-02-15 becomes 130 kg dated 2026-03-08.
ROLLBACK;
