import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
class Facilites {
  //   List<DocumentChange>  fetchJobs()  {
  //   // TODO: implement fetchJobs
  //   List<DocumentChange> jobs = new List<DocumentChange>(); 
  //   Firestore.instance.collection('Job').snapshots().map((data) => jobs= data.documentChanges);
  //   return jobs; 
  // }


  Future<QuerySnapshot> facilitiesList() {

    return  Firestore.instance.collection('facilities').getDocuments();
  }
  
}