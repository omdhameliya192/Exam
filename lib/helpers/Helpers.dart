import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUser({
    required String email,
    required String password,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection("users").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
        querySnapshot.docs;

    bool isUserAlreadyExists = false;

    for (QueryDocumentSnapshot<Map<String, dynamic>> element in allDocs) {
      if (email == element.data()['email']) {
        isUserAlreadyExists = true;
        break;
      } else {
        isUserAlreadyExists = false;
      }
    }

    if (isUserAlreadyExists == false) {

      await firebaseFirestore.collection("users").add({
        'email': email,
        'password': password,
        'time': FieldValue.serverTimestamp(),
      });
    }


  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fatchAllUser() {
    return firebaseFirestore.collection("users").orderBy('time',descending: false).snapshots();
  }

  Future<void> updateUser({
    required String email,
    required String password,
    required String id,
  }) async {
    await firebaseFirestore.collection("users").doc(id).update({
      'email': email,
      'password': password,
    });
  }

  Future<void> deleteUser({required String id}) async {
    await firebaseFirestore.collection("users").doc(id).delete();
  }
}