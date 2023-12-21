import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends ChangeNotifier {
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _id;

  String? get name => _name;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get id => _id;

  UserModel() {
    init();
  }

  init() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _name = user.displayName;
      _email = user.email;
      _phoneNumber = user.phoneNumber;
      _id = user.uid;
      notifyListeners();
    }
  }
}
