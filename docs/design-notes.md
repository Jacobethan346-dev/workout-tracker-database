# Design notes

## Table responsibilities

| Table | Purpose |
| --- | --- |
| USERS | User profile and experience level |
| MUSCLE_GROUPS | Broad muscle categories |
| BODY_PARTS | Specific targets within a muscle category |
| EXERCISES | Exercise name, movement, equipment, and difficulty |
| EXERCISE_MUSCLES | Exercise/body-part mapping and activation label |
| WORKOUTS | Session date, type, duration, and notes |
| WORKOUT_SETS | Per-set load, repetitions, effort, and rest |
| PERSONAL_RECORDS | One best value per user, exercise, and record type |
| BODY_MEASUREMENTS | Dated body-composition snapshots |

## Relationship decisions

Separating sessions from sets allows a session to contain several exercises. The EXERCISE_MUSCLES junction table avoids storing a list of muscles in one exercise row, while its composite key prevents duplicate mappings. MUSCLE_GROUPS and BODY_PARTS separate the broad category from the specific target. Foreign keys prevent orphan sets, records, and mappings. PERSONAL_RECORDS has a unique (UserID, ExerciseID, RecordType) constraint.

## Measurements and interpretation

Heights and circumference measurements use centimeters; body weights and recorded loads use kilograms in this portfolio sample. For dumbbell exercises, a load is the number recorded per set; the project does not infer combined implement weight. RPE is a per-set effort rating. PERSONAL_RECORDS stores the current best value for each category, not a complete history of record changes. USERS.BodyWeight is a profile snapshot; BODY_MEASUREMENTS provides dated measurements and is not synchronized automatically.

## Portfolio preparation

The source package is workout_tracker_setup.sql, which matches the nine-table schema and example rows in the final presentation. Another saved version used seven additional lookup tables; that alternate version is not combined with this one.

Changes made while preparing this repository:

- Replaced sample usernames with athlete_a through athlete_e and email addresses with example.com addresses; excluded school email addresses and source document metadata.
- Created a separate portfolio database without the original DROP DATABASE command.
- Rebuilt the weekly-volume view to remove its duplicate alias and invalid column references. A distinct exercise/group mapping prevents multiplication by multiple body parts in one muscle group.
- Updated trigger date handling to use the workout date, evaluate the old weight before updating it, and ignore zero-load sets for new 1RM records.
- Added stable sample queries, verification checks, a reversible trigger demonstration, and documentation.

These preparation changes are separate from the original course submission. Douglas Leal was the course instructor; an older SQL header that listed him as a coauthor was not retained.

## Limits and possible extensions

The trigger reacts to inserted sets only. Editing or deleting sets does not recompute personal records, and the seed records need not be derived from the limited sample sessions. Duplicate workout set numbers are not currently constrained. Exercise names are unique, but movement and equipment values remain free text in this schema. Additional checks, lookup tables, authentication, audit history, and concurrent record-update behavior are possible future improvements.

## References

- [MySQL CREATE VIEW](https://dev.mysql.com/doc/refman/8.4/en/create-view.html)
- [MySQL CREATE TRIGGER](https://dev.mysql.com/doc/refman/8.0/en/create-trigger.html)
