import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance.collection('/users').add({
      'email' : user.user.email,
      'uid' : user.user.uid
    }).then((value) {
      Navigator.of(context).pop();//to control stack and prevent stack overflow
      Navigator.of(context).pushReplacementNamed('/homepage');// replace not go back. 
    }).catchError((e) {
      print(e);
    });
  }
  
}
