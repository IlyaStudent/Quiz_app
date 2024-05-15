import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getAllTestInfo() async {
    Map<String, dynamic> testsData = {};
    try {
      QuerySnapshot querySnapshot = await _firestore.collection("Tests").get();

      for (var doc in querySnapshot.docs) {
        testsData[doc.id] = doc.data();
      }

      return testsData;
    } catch (e) {
      return {};
    }
  }
}
