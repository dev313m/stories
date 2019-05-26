import 'job_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
class ProdJobRepository {
  //   List<DocumentChange>  fetchJobs()  {
  //   // TODO: implement fetchJobs
  //   List<DocumentChange> jobs = new List<DocumentChange>(); 
  //   Firestore.instance.collection('Job').snapshots().map((data) => jobs= data.documentChanges);
  //   return jobs; 
  // }


  Future<QuerySnapshot> futureList() {
    return  Firestore.instance.collection('jobs').orderBy('date').getDocuments();
  }
  deleteJob(DocumentSnapshot doc){}
  
}