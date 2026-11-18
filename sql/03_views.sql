USE workout_tracker_portfolio;

-- Each set is counted once per primary muscle group, even when two
-- primary body parts belong to that same group. Volume = weight * reps.
CREATE OR REPLACE VIEW vw_weekly_volume AS
SELECT u.UserID, u.Username, mg.MuscleGroupID, mg.GroupName AS MuscleGroup,
       YEARWEEK(w.WorkoutDate, 1) AS YearWeek,
       COUNT(DISTINCT w.WorkoutID) AS Sessions,
       COUNT(*) AS TotalSets,
       SUM(ws.Weight * ws.Reps) AS TotalVolume_kg
FROM USERS u
JOIN WORKOUTS w ON w.UserID = u.UserID
JOIN WORKOUT_SETS ws ON ws.WorkoutID = w.WorkoutID
JOIN (
    SELECT DISTINCT em.ExerciseID, bp.MuscleGroupID
    FROM EXERCISE_MUSCLES em
    JOIN BODY_PARTS bp ON bp.BodyPartID = em.BodyPartID
    WHERE em.ActivationType = 'Primary'
) targets ON targets.ExerciseID = ws.ExerciseID
JOIN MUSCLE_GROUPS mg ON mg.MuscleGroupID = targets.MuscleGroupID
GROUP BY u.UserID, u.Username, mg.MuscleGroupID, mg.GroupName,
         YEARWEEK(w.WorkoutDate, 1);

CREATE OR REPLACE VIEW vw_bench_progression AS
SELECT u.UserID, u.Username, w.WorkoutDate,
       MAX(ws.Weight) AS MaxWeightLifted,
       SUM(ws.Reps) AS TotalReps
FROM USERS u
JOIN WORKOUTS w ON w.UserID = u.UserID
JOIN WORKOUT_SETS ws ON ws.WorkoutID = w.WorkoutID
JOIN EXERCISES e ON e.ExerciseID = ws.ExerciseID
WHERE e.ExerciseName = 'Barbell Bench Press'
GROUP BY u.UserID, u.Username, w.WorkoutDate;
