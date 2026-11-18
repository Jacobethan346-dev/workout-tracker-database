# Validation notes

## Checks completed during portfolio preparation

The schema and sample inserts were loaded into an in-memory SQLite database after translating MySQL's AUTO_INCREMENT and ENUM syntax. MySQL's YEARWEEK(date, 1) was replaced with an ISO week helper for the March 2026 sample dates. This cross-check validates the sample relationships and report arithmetic; it is not a MySQL compatibility test.

- All nine tables loaded with foreign-key enforcement and no orphan references.
- Counts matched: 5 users, 6 muscle groups, 18 body parts, 18 exercises, 44 muscle mappings, 10 workouts, 39 sets, 10 personal records, and 8 body-measurement rows.
- Workout 1 external-load volume: 4,104 kg-repetitions.
- User 1 leg volume in week 202610: 3,410 kg-repetitions, with the squat and Romanian deadlift counted once each per set for the Legs group.
- User 1 bench progression: 100 kg and 21 total repetitions on March 1; 102.5 kg and 21 total repetitions on March 8.
- Adding another primary chest mapping to the same exercise did not inflate the Chest report total.
- All example SELECT queries outside INFORMATION_SCHEMA executed under the translated check.
- Documentation links and original diagram XML were checked. School email addresses and local filesystem paths were excluded from the package.

## Remaining MySQL checks

Full MySQL execution is unverified. The installed MySQL 9.6 server crashed during initialization of a separate temporary instance, and no existing local server was available for testing. No existing course database was modified.

On a working MySQL installation, run files 00 through 04 in order, then `sql/06_verify.sql`. Every table's Actual count should match Expected, and the final query should return three values of 1. Run `sql/05_queries.sql` to review report output. Run `sql/07_trigger_demo.sql` to verify the insert trigger's before/after behavior and rollback.

The trigger has been reviewed but was not executed by the SQLite checks. Additional cases to check in MySQL include a lower single-repetition weight preserving an existing record/date, a new user/exercise record being created, and a multi-repetition set leaving the 1RM unchanged.
