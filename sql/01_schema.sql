USE workout_tracker_portfolio;

CREATE TABLE USERS (
    UserID          INT AUTO_INCREMENT PRIMARY KEY,
    Username        VARCHAR(50)  NOT NULL UNIQUE,
    Email           VARCHAR(100) NOT NULL UNIQUE,
    DateJoined      DATE         NOT NULL DEFAULT (CURRENT_DATE),
    HeightCm        DECIMAL(5,2) NOT NULL CHECK (HeightCm > 0),
    BodyWeight      DECIMAL(5,2) NOT NULL CHECK (BodyWeight > 0),
    ExperienceLevel ENUM('Beginner','Intermediate','Advanced') NOT NULL
);

CREATE TABLE MUSCLE_GROUPS (
    MuscleGroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupName     VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE BODY_PARTS (
    BodyPartID    INT AUTO_INCREMENT PRIMARY KEY,
    MuscleGroupID INT         NOT NULL,
    PartName      VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT fk_bodypart_musclegroup
        FOREIGN KEY (MuscleGroupID) REFERENCES MUSCLE_GROUPS(MuscleGroupID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE EXERCISES (
    ExerciseID      INT AUTO_INCREMENT PRIMARY KEY,
    ExerciseName    VARCHAR(100) NOT NULL UNIQUE,
    MovementPattern VARCHAR(50)  NOT NULL,
    EquipmentType   VARCHAR(50)  NOT NULL,
    DifficultyLevel ENUM('Beginner','Intermediate','Advanced') NOT NULL
);

CREATE TABLE EXERCISE_MUSCLES (
    ExerciseID     INT         NOT NULL,
    BodyPartID     INT         NOT NULL,
    ActivationType ENUM('Primary','Secondary') NOT NULL,
    PRIMARY KEY (ExerciseID, BodyPartID),
    CONSTRAINT fk_exmuscle_exercise
        FOREIGN KEY (ExerciseID) REFERENCES EXERCISES(ExerciseID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_exmuscle_bodypart
        FOREIGN KEY (BodyPartID)  REFERENCES BODY_PARTS(BodyPartID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE WORKOUTS (
    WorkoutID       INT AUTO_INCREMENT PRIMARY KEY,
    UserID          INT          NOT NULL,
    WorkoutDate     DATE         NOT NULL,
    WorkoutType     ENUM('Push','Pull','Legs','Full Body','Upper','Lower') NOT NULL,
    DurationMinutes INT          NOT NULL CHECK (DurationMinutes > 0),
    Notes           TEXT,
    CONSTRAINT fk_workout_user
        FOREIGN KEY (UserID) REFERENCES USERS(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE WORKOUT_SETS (
    SetID         INT AUTO_INCREMENT PRIMARY KEY,
    WorkoutID     INT           NOT NULL,
    ExerciseID    INT           NOT NULL,
    SetNumber     INT           NOT NULL CHECK (SetNumber > 0),
    Weight        DECIMAL(6,2)  NOT NULL CHECK (Weight >= 0),
    Reps          INT           NOT NULL CHECK (Reps > 0),
    RPE           DECIMAL(3,1)  CHECK (RPE BETWEEN 1 AND 10),
    RestSeconds   INT           CHECK (RestSeconds >= 0),
    CONSTRAINT fk_set_workout
        FOREIGN KEY (WorkoutID)  REFERENCES WORKOUTS(WorkoutID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_set_exercise
        FOREIGN KEY (ExerciseID) REFERENCES EXERCISES(ExerciseID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE PERSONAL_RECORDS (
    RecordID     INT AUTO_INCREMENT PRIMARY KEY,
    UserID       INT          NOT NULL,
    ExerciseID   INT          NOT NULL,
    RecordType   ENUM('1RM','5RM','10RM') NOT NULL,
    Weight       DECIMAL(6,2) NOT NULL CHECK (Weight > 0),
    DateAchieved DATE         NOT NULL,
    CONSTRAINT uq_pr UNIQUE (UserID, ExerciseID, RecordType),
    CONSTRAINT fk_pr_user
        FOREIGN KEY (UserID)     REFERENCES USERS(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pr_exercise
        FOREIGN KEY (ExerciseID) REFERENCES EXERCISES(ExerciseID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE BODY_MEASUREMENTS (
    MeasurementID   INT AUTO_INCREMENT PRIMARY KEY,
    UserID          INT          NOT NULL,
    MeasurementDate DATE         NOT NULL,
    BodyWeight      DECIMAL(5,2) NOT NULL CHECK (BodyWeight > 0),
    BodyFatPercent  DECIMAL(4,1) CHECK (BodyFatPercent BETWEEN 1 AND 60),
    Chest           DECIMAL(5,2),
    Arms            DECIMAL(5,2),
    Waist           DECIMAL(5,2),
    Thighs          DECIMAL(5,2),
    CONSTRAINT fk_meas_user
        FOREIGN KEY (UserID) REFERENCES USERS(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
