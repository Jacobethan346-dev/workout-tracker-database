-- Fictional demonstration data, adapted from the course sample.
USE workout_tracker_portfolio;

-- USERS
INSERT INTO USERS (Username, Email, DateJoined, HeightCm, BodyWeight, ExperienceLevel) VALUES
('athlete_a',    'athlete_a@example.com',   '2024-01-10', 180.34, 85.00, 'Intermediate'),
('athlete_b',   'athlete_b@example.com',   '2024-02-15', 165.10, 62.50, 'Advanced'),
('athlete_c',     'athlete_c@example.com',    '2024-03-01', 175.26, 95.30, 'Beginner'),
('athlete_d',     'athlete_d@example.com',    '2023-11-20', 182.88, 100.00,'Advanced'),
('athlete_e',       'athlete_e@example.com',    '2024-04-05', 162.56, 57.80, 'Intermediate');

-- MUSCLE_GROUPS
INSERT INTO MUSCLE_GROUPS (GroupName) VALUES
('Chest'),
('Back'),
('Shoulders'),
('Legs'),
('Arms'),
('Core');

-- BODY_PARTS  (MuscleGroupID references above)
INSERT INTO BODY_PARTS (MuscleGroupID, PartName) VALUES
-- Chest (1)
(1, 'Upper Chest'),
(1, 'Mid Chest'),
(1, 'Lower Chest'),
-- Back (2)
(2, 'Upper Back'),
(2, 'Lats'),
(2, 'Lower Back'),
-- Shoulders (3)
(3, 'Front Delts'),
(3, 'Side Delts'),
(3, 'Rear Delts'),
-- Legs (4)
(4, 'Quads'),
(4, 'Hamstrings'),
(4, 'Glutes'),
(4, 'Calves'),
-- Arms (5)
(5, 'Biceps'),
(5, 'Triceps'),
(5, 'Forearms'),
-- Core (6)
(6, 'Abs'),
(6, 'Obliques');

-- EXERCISES
INSERT INTO EXERCISES (ExerciseName, MovementPattern, EquipmentType, DifficultyLevel) VALUES
('Barbell Bench Press',      'Horizontal Push', 'Barbell',    'Intermediate'),
('Incline Dumbbell Press',   'Incline Push',    'Dumbbell',   'Intermediate'),
('Cable Flye',               'Fly',             'Cable',      'Beginner'),
('Pull-Up',                  'Vertical Pull',   'Bodyweight', 'Intermediate'),
('Barbell Row',              'Horizontal Pull', 'Barbell',    'Intermediate'),
('Lat Pulldown',             'Vertical Pull',   'Cable',      'Beginner'),
('Overhead Press',           'Vertical Push',   'Barbell',    'Intermediate'),
('Lateral Raise',            'Abduction',       'Dumbbell',   'Beginner'),
('Face Pull',                'Horizontal Pull', 'Cable',      'Beginner'),
('Barbell Squat',            'Squat',           'Barbell',    'Advanced'),
('Romanian Deadlift',        'Hip Hinge',       'Barbell',    'Intermediate'),
('Leg Press',                'Squat',           'Machine',    'Beginner'),
('Standing Calf Raise',      'Plantarflexion',  'Machine',    'Beginner'),
('Barbell Curl',             'Curl',            'Barbell',    'Beginner'),
('Skull Crusher',            'Elbow Extension', 'Barbell',    'Intermediate'),
('Plank',                    'Isometric',       'Bodyweight', 'Beginner'),
('Cable Crunch',             'Flexion',         'Cable',      'Beginner'),
('Deadlift',                 'Hip Hinge',       'Barbell',    'Advanced');

-- EXERCISE_MUSCLES  (ExerciseID, BodyPartID, ActivationType)
-- BodyPartID key: Upper Chest=1, Mid Chest=2, Lower Chest=3
--   Upper Back=4, Lats=5, Lower Back=6
--   Front Delts=7, Side Delts=8, Rear Delts=9
--   Quads=10, Hamstrings=11, Glutes=12, Calves=13
--   Biceps=14, Triceps=15, Forearms=16
--   Abs=17, Obliques=18
INSERT INTO EXERCISE_MUSCLES VALUES
-- Bench Press: primary Mid Chest, secondary Triceps + Front Delts
(1, 2, 'Primary'), (1, 15, 'Secondary'), (1, 7, 'Secondary'),
-- Incline DB Press: primary Upper Chest, secondary Triceps + Front Delts
(2, 1, 'Primary'), (2, 15, 'Secondary'), (2, 7, 'Secondary'),
-- Cable Flye: primary Mid Chest
(3, 2, 'Primary'), (3, 3, 'Secondary'),
-- Pull-Up: primary Lats, secondary Biceps + Upper Back
(4, 5, 'Primary'), (4, 14, 'Secondary'), (4, 4, 'Secondary'),
-- Barbell Row: primary Upper Back, secondary Lats + Biceps
(5, 4, 'Primary'), (5, 5, 'Secondary'), (5, 14, 'Secondary'),
-- Lat Pulldown: primary Lats, secondary Biceps
(6, 5, 'Primary'), (6, 14, 'Secondary'),
-- Overhead Press: primary Front Delts, secondary Triceps + Side Delts
(7, 7, 'Primary'), (7, 15, 'Secondary'), (7, 8, 'Secondary'),
-- Lateral Raise: primary Side Delts
(8, 8, 'Primary'),
-- Face Pull: primary Rear Delts, secondary Side Delts
(9, 9, 'Primary'), (9, 8, 'Secondary'),
-- Squat: primary Quads + Glutes, secondary Hamstrings + Lower Back
(10, 10, 'Primary'), (10, 12, 'Primary'), (10, 11, 'Secondary'), (10, 6, 'Secondary'),
-- Romanian Deadlift: primary Hamstrings + Glutes, secondary Lower Back
(11, 11, 'Primary'), (11, 12, 'Primary'), (11, 6, 'Secondary'),
-- Leg Press: primary Quads, secondary Glutes + Hamstrings
(12, 10, 'Primary'), (12, 12, 'Secondary'), (12, 11, 'Secondary'),
-- Calf Raise: primary Calves
(13, 13, 'Primary'),
-- Barbell Curl: primary Biceps, secondary Forearms
(14, 14, 'Primary'), (14, 16, 'Secondary'),
-- Skull Crusher: primary Triceps
(15, 15, 'Primary'),
-- Plank: primary Abs, secondary Obliques
(16, 17, 'Primary'), (16, 18, 'Secondary'),
-- Cable Crunch: primary Abs
(17, 17, 'Primary'), (17, 18, 'Secondary'),
-- Deadlift: primary Lower Back + Glutes, secondary Hamstrings + Lats
(18, 6, 'Primary'), (18, 12, 'Primary'), (18, 11, 'Secondary'), (18, 5, 'Secondary');

-- WORKOUTS
INSERT INTO WORKOUTS (UserID, WorkoutDate, WorkoutType, DurationMinutes, Notes) VALUES
(1, '2026-03-01', 'Push',      70, 'Felt strong on bench today'),
(1, '2026-03-03', 'Pull',      65, 'Focused on lat activation'),
(1, '2026-03-05', 'Legs',      80, 'PR on squat!'),
(2, '2026-03-01', 'Push',      55, 'Deload week - light weights'),
(2, '2026-03-04', 'Pull',      60, 'Heavy row day'),
(3, '2026-03-02', 'Full Body', 90, 'First gym session, learning movements'),
(4, '2026-03-01', 'Push',      75, 'Competition prep push day'),
(4, '2026-03-03', 'Legs',      90, 'Squat and deadlift combo'),
(5, '2026-03-02', 'Upper',     60, 'Moderate intensity'),
(1, '2026-03-08', 'Push',      68, 'Slight progress on bench');

-- WORKOUT_SETS
INSERT INTO WORKOUT_SETS (WorkoutID, ExerciseID, SetNumber, Weight, Reps, RPE, RestSeconds) VALUES
-- Workout 1 (jacob Push): Bench Press
(1, 1, 1, 100.00, 8, 7.0, 180),
(1, 1, 2, 100.00, 7, 7.5, 180),
(1, 1, 3, 100.00, 6, 8.0, 180),
-- Workout 1: Incline DB Press
(1, 2, 1, 32.00, 10, 7.0, 120),
(1, 2, 2, 32.00,  9, 7.5, 120),
(1, 2, 3, 32.00,  8, 8.0, 120),
-- Workout 1: Overhead Press
(1, 7, 1, 60.00, 10, 6.5, 120),
(1, 7, 2, 60.00,  9, 7.0, 120),
-- Workout 2 (jacob Pull): Pull-Up
(2, 4, 1, 0.00,  8, 8.0, 150),
(2, 4, 2, 0.00,  7, 8.5, 150),
(2, 4, 3, 0.00,  6, 9.0, 150),
-- Workout 2: Barbell Row
(2, 5, 1, 80.00, 8, 7.5, 120),
(2, 5, 2, 80.00, 8, 7.5, 120),
(2, 5, 3, 82.50, 7, 8.0, 120),
-- Workout 3 (jacob Legs): Squat
(3, 10, 1, 120.00, 5, 8.0, 240),
(3, 10, 2, 120.00, 5, 8.5, 240),
(3, 10, 3, 125.00, 4, 9.0, 240),
-- Workout 3: Romanian Deadlift
(3, 11, 1, 90.00, 10, 7.0, 150),
(3, 11, 2, 90.00,  9, 7.5, 150),
-- Workout 4 (sarah Push): Bench Press
(4, 1, 1, 70.00, 10, 6.0, 120),
(4, 1, 2, 70.00, 10, 6.0, 120),
-- Workout 5 (sarah Pull): Barbell Row
(5, 5, 1, 90.00, 6, 8.5, 180),
(5, 5, 2, 90.00, 5, 9.0, 180),
(5, 5, 3, 92.50, 4, 9.5, 180),
-- Workout 6 (mike Full Body): Leg Press + Lat Pulldown + Bench
(6, 12, 1, 80.00, 12, 6.0, 90),
(6, 12, 2, 80.00, 12, 6.5, 90),
(6,  6, 1, 40.00, 10, 6.0, 90),
(6,  6, 2, 40.00, 10, 6.5, 90),
(6,  1, 1, 50.00, 10, 6.0, 90),
-- Workout 7 (alex Push): Bench Press heavy
(7, 1, 1, 140.00, 3, 8.5, 300),
(7, 1, 2, 140.00, 3, 9.0, 300),
(7, 1, 3, 145.00, 2, 9.5, 300),
-- Workout 8 (alex Legs): Squat heavy
(8, 10, 1, 180.00, 3, 8.5, 300),
(8, 10, 2, 185.00, 3, 9.0, 300),
(8, 18, 1, 220.00, 3, 9.0, 300),
(8, 18, 2, 225.00, 2, 9.5, 300),
-- Workout 10 (jacob Push wk2): Bench Press slight increase
(10, 1, 1, 102.50, 8, 7.0, 180),
(10, 1, 2, 102.50, 7, 7.5, 180),
(10, 1, 3, 102.50, 6, 8.0, 180);

-- PERSONAL_RECORDS
INSERT INTO PERSONAL_RECORDS (UserID, ExerciseID, RecordType, Weight, DateAchieved) VALUES
(1,  1, '1RM', 120.00, '2026-02-15'),
(1,  1, '5RM', 102.50, '2026-03-08'),
(1, 10, '1RM', 150.00, '2026-03-05'),
(2,  1, '1RM',  90.00, '2025-12-01'),
(2,  5, '1RM', 110.00, '2026-03-04'),
(4,  1, '1RM', 175.00, '2026-01-20'),
(4, 10, '1RM', 230.00, '2026-02-28'),
(4, 18, '1RM', 280.00, '2026-02-28'),
(5,  1, '5RM',  55.00, '2026-03-02'),
(3, 12, '10RM', 90.00, '2026-03-02');

-- BODY_MEASUREMENTS
INSERT INTO BODY_MEASUREMENTS (UserID, MeasurementDate, BodyWeight, BodyFatPercent, Chest, Arms, Waist, Thighs) VALUES
(1, '2026-01-01', 87.50, 18.5, 102.00, 38.00, 82.00, 60.00),
(1, '2026-02-01', 86.20, 17.8, 102.50, 38.50, 81.00, 60.50),
(1, '2026-03-01', 85.00, 17.1, 103.00, 39.00, 80.00, 61.00),
(2, '2026-01-01', 63.00, 22.0,  88.00, 30.00, 68.00, 54.00),
(2, '2026-03-01', 62.50, 21.5,  88.50, 30.50, 67.50, 54.50),
(4, '2026-01-01',102.00, 14.0, 115.00, 44.00, 84.00, 68.00),
(4, '2026-03-01',100.00, 13.5, 115.50, 44.50, 83.00, 69.00),
(5, '2026-03-01', 57.80, 23.0,  84.00, 28.00, 65.00, 52.00);
