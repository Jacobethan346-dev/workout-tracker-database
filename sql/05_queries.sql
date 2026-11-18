USE workout_tracker_portfolio;

-- Q1: Show all users
SELECT * FROM USERS;

-- Q2: Show all exercises with difficulty
SELECT ExerciseID, ExerciseName, MovementPattern, EquipmentType, DifficultyLevel
FROM EXERCISES ORDER BY DifficultyLevel, ExerciseName;

-- Q3: Show all muscle groups and their body parts
SELECT mg.GroupName, bp.BodyPartID, bp.PartName
FROM MUSCLE_GROUPS mg
JOIN BODY_PARTS bp ON mg.MuscleGroupID = bp.MuscleGroupID
ORDER BY mg.GroupName, bp.PartName;

-- ── Complex queries (JOINs / subqueries) ─────────────────

-- Q4: Which muscles does each exercise target? (multi-table JOIN)
SELECT
    e.ExerciseName,
    mg.GroupName    AS MuscleGroup,
    bp.PartName     AS BodyPart,
    em.ActivationType
FROM EXERCISES e
JOIN EXERCISE_MUSCLES em ON e.ExerciseID = em.ExerciseID
JOIN BODY_PARTS bp        ON em.BodyPartID = bp.BodyPartID
JOIN MUSCLE_GROUPS mg     ON bp.MuscleGroupID = mg.MuscleGroupID
ORDER BY e.ExerciseName, em.ActivationType;

-- Q5: Total volume (weight × reps) per user per workout
SELECT
    u.Username,
    w.WorkoutDate,
    w.WorkoutType,
    ROUND(SUM(ws.Weight * ws.Reps), 2) AS TotalVolume_kg
FROM USERS u
JOIN WORKOUTS w      ON u.UserID = w.UserID
JOIN WORKOUT_SETS ws ON w.WorkoutID = ws.WorkoutID
GROUP BY u.Username, w.WorkoutDate, w.WorkoutType
ORDER BY u.Username, w.WorkoutDate;

-- Q6: Personal records with exercise names and user names
SELECT
    u.Username,
    e.ExerciseName,
    pr.RecordType,
    pr.Weight      AS Record_kg,
    pr.DateAchieved
FROM PERSONAL_RECORDS pr
JOIN USERS     u ON pr.UserID     = u.UserID
JOIN EXERCISES e ON pr.ExerciseID = e.ExerciseID
ORDER BY u.Username, e.ExerciseName;

-- Q7: Users who have NOT trained Legs (subquery)
SELECT Username, Email, ExperienceLevel
FROM USERS
WHERE UserID NOT IN (
    SELECT DISTINCT w.UserID
    FROM WORKOUTS w
    JOIN WORKOUT_SETS ws ON w.WorkoutID = ws.WorkoutID
    JOIN EXERCISE_MUSCLES em ON ws.ExerciseID = em.ExerciseID
    JOIN BODY_PARTS bp ON em.BodyPartID = bp.BodyPartID
    JOIN MUSCLE_GROUPS mg ON bp.MuscleGroupID = mg.MuscleGroupID
    WHERE mg.GroupName = 'Legs'
);

-- Q8: Body-composition change over time for user 1 (jacob)
SELECT
    u.Username,
    bm.MeasurementDate,
    bm.BodyWeight,
    bm.BodyFatPercent,
    bm.Chest, bm.Arms, bm.Waist
FROM BODY_MEASUREMENTS bm
JOIN USERS u ON bm.UserID = u.UserID
WHERE bm.UserID = 1
ORDER BY bm.MeasurementDate;

-- Q9: Bench press progression for jacob (view query)
SELECT * FROM vw_bench_progression WHERE Username = 'athlete_a' ORDER BY WorkoutDate;

-- Q10: DESCRIBE each table (schema view for grading)
DESCRIBE USERS;
DESCRIBE MUSCLE_GROUPS;
DESCRIBE BODY_PARTS;
DESCRIBE EXERCISES;
DESCRIBE EXERCISE_MUSCLES;
DESCRIBE WORKOUTS;
DESCRIBE WORKOUT_SETS;
DESCRIBE PERSONAL_RECORDS;
DESCRIBE BODY_MEASUREMENTS;

-- Q11: Show all foreign-key constraints
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'workout_tracker_portfolio'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;


-- Q12: Include users with no personal records (LEFT JOIN).
SELECT u.Username, e.ExerciseName, pr.RecordType, pr.Weight AS Record_kg
FROM USERS u
LEFT JOIN PERSONAL_RECORDS pr ON pr.UserID = u.UserID
LEFT JOIN EXERCISES e ON e.ExerciseID = pr.ExerciseID
ORDER BY u.Username, e.ExerciseName, pr.RecordType;

-- Q13: Weekly volume from fixed sample dates, no dependency on today's date.
SELECT * FROM vw_weekly_volume
WHERE Username = 'athlete_a'
ORDER BY YearWeek, MuscleGroup;
