import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authservisi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //giris
  Future<String> giris(String email, String password) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        var user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  // cıkıs

  cikis() async {
    return await _auth.signOut();
  }

  //kayıt
  Future<String> kayit(String email, String password) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        var user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firebaseFirestore.collection("user").doc(user.user!.uid).set({
          "email": email,
          "password": password,
        });
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  Future<String> Post(String notadi, String not) async {
    final now = DateTime.now();
    String res = "Some error occurred";
    try {
      if (notadi.isEmpty && not.isEmpty) {
        res = "Please enter all the fields";
      } else {
        await _firebaseFirestore
            .collection("post")
            .doc(now.microsecondsSinceEpoch.toString())
            .set({
          "postId": now.microsecondsSinceEpoch.toString(),
          "id": _auth.currentUser!.uid,
          "notadi": notadi,
          "not": not,
          "saat": formatDate(
              DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]),
          "silme": true,
        });
        res = "succes";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> movepost(String postId, int durum) async {
    String res = "Some error occurred";
    if (durum == 1) {
      try {
        await _firebaseFirestore.collection('post').doc(postId).update({
          "silme": false,
        });
        res = 'success';
      } catch (err) {
        res = err.toString();
      }
    } else {
      try {
        await _firebaseFirestore.collection('post').doc(postId).update({
          "silme": true,
        });
        res = 'success';
      } catch (err) {
        res = err.toString();
      }
    }

    return res;
  }

  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firebaseFirestore.collection('post').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
