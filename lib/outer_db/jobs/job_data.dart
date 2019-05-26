import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String ID; // ID OF THE JOB
  String TITLE; // HEADER AND TITILE OF THE JOB
  String DISC; // DISCRIPTION OF THE JOB (PARAGRAPH)
  String EMAIL;
  String PHONE; // PHONE OF THE EMPLOYEE
  String SEX; // RQUERIED SEX
  String CERTIFICATE; // REQUIRED CERTIFICATION
  String DATE; // CREATED DATE

  Job(
      {this.ID,
      this.TITLE,
      this.DISC,
      this.EMAIL,
      this.CERTIFICATE,
      this.DATE,
      this.PHONE,
      this.SEX});

      Job.fromMap(Map<String, dynamic> map):ID=map['ID'], CERTIFICATE =map['CERTIFICATE'], DATE =map['DATE'], DISC = map['DISC'],EMAIL =map['EMAIL'],PHONE =map['PHONE'], SEX =map['SEX'], TITLE =map['TITLE'];  
}

// abstract class JobRepository {
//   List<DocumentChange>  fetchJobs();
// }

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "$_message";
  }
}
