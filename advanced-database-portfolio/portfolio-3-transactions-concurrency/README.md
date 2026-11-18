# Portfolio 3 — Transactions and Concurrency Control
## Executed Scenarios
1. **Atomic Registration (`COMMIT`):** Inserts an enrollment for `student_id = 1` in `offering_id = 5` and decrements `capacity` from `400` to `399` within a single ACID transaction.
2. **Audit Recovery (`ROLLBACK`):** Simulates an unauthorized grade update (`84.0 -> 100.0`) on `enrollment_id = 1` and executes `ROLLBACK`, restoring `84.0`.
3. **Two-Session Lock Contention:** Session A holds an exclusive write lock on `offering_id = 1` (`BEGIN IMMEDIATE`); Session B attempts a concurrent decrement, blocks for `188.1 ms`, receives `OperationalError: database is locked`, and succeeds upon retry after Session A commits (`capacity: 400 -> 399 -> 398`), preventing a lost update.
