import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:my_calendar/domain/model/account/user.dart';

class FirebaseDB {
  static final DatabaseReference _dbref =
      FirebaseDatabase.instance.ref().child('user');

  static Future<void> insertUser(LoginUser user) async {
    await _dbref.child('user').once().then((DatabaseEvent event) {
      final values = event.snapshot.value as Map<String, dynamic>;
      if (values != null) {
        values.forEach((key, values) {
          if (values['uid'] == user.uid) {
            return;
          }
        });
      }
    });
    // If we reach here, it means there's no duplicate data, so we can add the new data
    await _dbref
        .push()
        .set(user.toJson())
        .then((value) => print('done'))
        .onError((error, stackTrace) => print(error));
  }

  static Future<void> update(LoginUser user) async {
    await _dbref
        .push()
        .update(user.toJson())
        .then((value) => print('done'))
        .onError((error, stackTrace) => print(error));
  }
}
