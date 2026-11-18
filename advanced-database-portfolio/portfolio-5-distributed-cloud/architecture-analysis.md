# Portfolio 5 — Distributed & Cloud Database Architecture Analysis

## 1. Deployment Topology
To support high-concurrency course registration and result checking without single points of failure, the system adopts a **Multi-Availability Zone (Multi-AZ) Hybrid Cloud Topology**:
- **Primary Relational Node (AZ-A):** Managed PostgreSQL instance handling all transactional writes (`INSERT` enrollments, `UPDATE` grades/capacities) with strict ACID durability.
- **Standby / Read Replica Node (AZ-B):** Receives Write-Ahead Log (WAL) streaming replication. Serves read-heavy administrative analytics and automatically promotes to primary within ~30–60 seconds during an AZ outage.
- **Connection Pooling (`PgBouncer`):** Absorbs bursty HTTP traffic from thousands of concurrent students during registration deadlines, preventing database connection exhaustion.
- **Polyglot Read Cache (MongoDB Atlas):** Synchronized via Change Data Capture (CDC) from PostgreSQL `grades` commits to serve low-latency student transcript views.

## 2. CAP Theorem, Consistency & Replication Trade-Offs
- **Strong Consistency on Writes (CP behavior):** Enrollment capacity checks and grade commits route exclusively to the Primary node to prevent double-booking or stale reads immediately after grade publication (read-your-writes consistency).
- **Eventual Consistency on Analytical Replicas (AP behavior):** Reporting dashboards tolerate sub-second asynchronous replication lag, offloading CPU/IO pressure from the primary node.
- **Horizontal Sharding Strategy:** If scaled across a multi-campus university network (>5 million student records), `enrollments` and `grades` can be range-sharded by `academic_year` or hash-sharded by `department_id`, keeping single-student transcript queries local to one shard.
- **Disaster Recovery Targets:** Continuous WAL archiving to encrypted object storage targets an **RPO < 5 minutes** and an **RTO < 15 minutes**.
