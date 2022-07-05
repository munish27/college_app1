import 'dart:ffi';

import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/data/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  void getLogin(String email, String password) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _firebaseAuth = FirebaseAuth.instance;
      _firebaseAuth.signOut();

      try {
        final _user = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        if (_user.user != null) {
          final _result = await _repository.loginAdmin(email, _user.user!.uid);

          if (_result.status == STATUS.ERROR) {
            _errMsg = _result.errMsg;
          }
          _status = _result.status;

          FirebaseFirestore _firestore = FirebaseFirestore.instance;

          final _userInfo =
              await _firestore.collection('users').doc(_user.user!.uid).get();
          if (!_userInfo.exists) {
            await _firestore.collection('users').doc(_user.user!.uid).set({
              "name": _result.data!.data.name,
              "email": email,
              "status": "Unavalible",
              "uid": _user.user!.uid,
            });
          }

          notifyListeners();
        } else {}
      } on FirebaseAuthException catch (e) {
        _status = STATUS.ERROR;
        print(e);
        _errMsg = e.message ?? 'Something went wrong';
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }
}
