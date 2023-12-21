import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/models.dart';

class Database {
  final _db = FirebaseFirestore.instance;
  final uid = UserModel().id;
  final userDoc =
      FirebaseFirestore.instance.collection('users').doc(UserModel().id);
  final detailsCol = FirebaseFirestore.instance
      .collection('users')
      .doc(UserModel().id)
      .collection('details');

  // CollectionReference<Map<String, dynamic>> get detailsCol => _detailsCol;

  Future<String> addUser(User user) async {
    String response = '400';
    final data = <String, dynamic>{
      'name': user.displayName,
      'phonenumber': user.phoneNumber,
      'email': user.email,
      'id': user.uid,
    };
    final userdoc = _db.collection('users').doc(user.uid);
    String rid = userDoc.collection('resumes').doc().id;
    data['currentresumeid'] = rid;
    userdoc.set(data);
    if (userdoc.id == user.uid) {
      response = '200';
    }
    return response;
  }

  updateContact(Contact contact) {
    final data = contact.toMap();
    userDoc.collection('details').doc('contact').set(data);
  }
}
