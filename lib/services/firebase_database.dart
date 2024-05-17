import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getAllTestInfo() async {
    Map<String, dynamic> testsData = {};
    try {
      QuerySnapshot querySnapshot = await _firestore.collection("Tests").get();
      Map<String, dynamic>? userResults = await getUserResults();
      for (var doc in querySnapshot.docs) {
        testsData[doc.id] = {"questions": doc.data(), "isPassed": false};
        if (userResults != null) {
          print(userResults[FirebaseAuth.instance.currentUser?.uid]);
          if (userResults[FirebaseAuth.instance.currentUser?.uid]
              .keys
              .contains(doc.id)) {
            testsData[doc.id]["isPassed"] = true;
          }
        }
      }

      // for (var doc in querySnapshot.docs) {
      //   testsData[doc.id]["isPassed"] = false;
      //   testsData[doc.id]["questions"] = doc.data();
      //   if (userResults != null) {
      //     if (userResults.keys.contains(doc.id)) {
      //       testsData[doc.id]["isPassed"] = true;
      //     }
      //   }
      // }

      return testsData;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>?> getUserResults() async {
    Map<String, dynamic>? resultsData = {};

    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("UserResults")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      resultsData[documentSnapshot.id] = documentSnapshot.data();

      return resultsData;
    } catch (e) {
      return {};
    }
  }

  Future<void> makeUserResultsInDb() async {
    _firestore
        .collection("UserResults")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({});
  }

  Future<void> markTestComplete(String testName) async {
    _firestore
        .collection("UserResults")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({testName: true});
  }
}
