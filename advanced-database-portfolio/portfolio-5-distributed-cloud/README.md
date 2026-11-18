# Portfolio 5 — Distributed & Cloud Database Architecture

Short summary of the design. Full reasoning, trade-offs and recovery targets are in
[architecture-analysis.md](architecture-analysis.md); the diagram source is
[architecture.mmd](architecture.mmd) and the rendered version is
`../evidence/cloud_architecture.png`.

- Writes go through PgBouncer to a PostgreSQL primary in AZ-A. A standby in AZ-B
  follows by WAL streaming and takes reporting reads; it promotes on AZ failure.
- Enrolment and grading reads that must be current stay on the primary. Dashboard
  reads use the replica and allow for brief replication lag.
- Grade commits are copied to MongoDB Atlas for transcript lookups (Portfolio 4).
- WAL is archived continuously to encrypted object storage for point-in-time recovery.

How I checked it: traced one enrolment and one grade publication through the diagram
to confirm each has a single write path, and checked the replica is never a second
write path for capacity or grades.
