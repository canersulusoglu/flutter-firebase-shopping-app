// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Assessment{
  late String assessmentId;
  late DocumentReference<Map<String,dynamic>> userReference;
  late double score;
  late String comment;

  Assessment({
    required this.assessmentId,
    required this.userReference,
    required this.score,
    required this.comment
  });

  Assessment.fromJson(Map<String, dynamic> json){
    assessmentId = json['assessmentId'];
    userReference = json['userReference'] ;
    score = json['score'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() => {
    'assessmentId': assessmentId,
    'userReference': userReference,
    'score': score,
    'comment': comment
  };
}