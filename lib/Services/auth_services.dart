
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService{
  Future<bool> signup({
    required String email,
    required String password,
    required String password2
}) async {
    if(password != password2)
      {
        Fluttertoast.showToast(
          msg: 'Password must match',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 30.0,
        );
        return false;
      }
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return true;
  } on FirebaseAuthException catch(e) {
    String message = 'Error';
      if (e.code == 'weak-password'){
        message = 'The password provided is too weak';
      }else if(e.code == 'email-already-in-use') {
          message = 'An account already exist with that email';
      }
      Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 30.0,
      );
    }
  return false;
}
  Future<bool> signin({
    required String email,
    required String password,
  }) async {

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return true;

    } on FirebaseAuthException catch(e) {
      String message = 'Error';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 30.0,
      );

    }
    return false;

  }
}