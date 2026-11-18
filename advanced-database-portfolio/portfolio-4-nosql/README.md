# Portfolio 4 — NoSQL and Advanced Data Models
## Document Model Suitability & Trade-Offs
- **Model:** Student-centric document collection (`student_transcripts`) embedding department info, academic summary (`total_units`, `cgpa`), and an array of `transcript_records`.
- **Suitability:** Eliminates 4-way relational `JOIN` operations during peak result-checking periods, delivering complete student transcripts in a single key-value lookup (`_id: matric_no`).
- **Trade-Off:** Course titles and credit units are duplicated across student documents, requiring application-level fan-out or CDC synchronization if course metadata changes, while cross-student analytics require `$unwind` + `$group` aggregation pipelines.

Files: `expected-document-shape.json` shows one document in full;
`student_transcripts_collection.json` holds 10 exported documents;
`mongodb.js` creates the index and runs the single-document lookup and the
`$unwind`/`$group` aggregation. Load the full set with:
`mongoimport --db apex_university_nosql --collection student_transcripts --file student_transcripts_collection.json --jsonArray`
Output is in `../evidence/nosql_aggregation_output.txt` (8 course rows).
