// MIT 8103 Portfolio 4: MongoDB Document Model & Aggregation Pipeline
// Database: apex_university_nosql | Collection: student_transcripts

use('apex_university_nosql');
db.student_transcripts.drop();

// 1. Sample document below. Full set (10 documents):
//    mongoimport --db apex_university_nosql --collection student_transcripts --file student_transcripts_collection.json --jsonArray
const sampleDocs = [
  {
    _id: "ACU20260001",
    matric_no: "ACU20260001",
    full_name: "Adaeze Okoro",
    email: "adaeze.okoro@apexuni.edu.ng",
    level: 800,
    department: { code: "MIT", name: "Information Technology" },
    academic_summary: { total_units: 14, cgpa: 5.0 },
    transcript_records: [
      { course_code: "MIT8101", title: "Foundations of Information Technology", credits: 3, assessment: { ca: 34.0, exam: 50.0, total: 84.0 }, letter_grade: "A", grade_point: 5.0 },
      { course_code: "MIT8103", title: "Advanced Database Systems", credits: 3, assessment: { ca: 32.0, exam: 48.0, total: 80.0 }, letter_grade: "A", grade_point: 5.0 },
      { course_code: "MIT8105", title: "Network Architecture and Protocols", credits: 3, assessment: { ca: 29.0, exam: 44.0, total: 73.0 }, letter_grade: "A", grade_point: 5.0 },
      { course_code: "MIT8107", title: "Enterprise Software Engineering", credits: 3, assessment: { ca: 35.0, exam: 52.0, total: 87.0 }, letter_grade: "A", grade_point: 5.0 },
      { course_code: "MIT8111", title: "Cloud Computing & Distributed Systems", credits: 2, assessment: { ca: 30.0, exam: 42.0, total: 72.0 }, letter_grade: "A", grade_point: 5.0 }
    ]
  }
];

db.student_transcripts.insertMany(sampleDocs);
db.student_transcripts.createIndex({ "department.code": 1, "academic_summary.cgpa": -1 });

// 2. Single-Document O(1) Transcript Lookup (Zero JOINs)
printjson(db.student_transcripts.findOne({ _id: "ACU20260001" }));

// 3. Aggregation Pipeline: Unwind embedded courses to compute per-course mean scores
printjson(db.student_transcripts.aggregate([
  { $unwind: "$transcript_records" },
  { $group: {
      _id: "$transcript_records.course_code",
      student_count: { $sum: 1 },
      avg_total_score: { $avg: "$transcript_records.assessment.total" },
      max_score: { $max: "$transcript_records.assessment.total" }
  }},
  { $sort: { _id: 1 } }
]).toArray());
