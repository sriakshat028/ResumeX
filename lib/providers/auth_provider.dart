import 'package:firebase_auth/firebase_auth.dart'
    show
        FirebaseAuth,
        FirebaseAuthException,
        PhoneAuthCredential,
        PhoneAuthProvider,
        User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, debugPrint;
import 'package:resumex/database/database.dart';
import 'package:resumex/functions/function.dart';
import '../firebase_options.dart';

enum AuthState {
  loggedIn,
  signedOut,
  register,
  verifyPhone,
}

class Authentication extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  String? _verificationId;

  final db = Database();

  AuthState _currentAuthState = AuthState.signedOut;
  AuthState get currentAuthState => _currentAuthState;

  Authentication() {
    init();
  }

  init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (_auth.currentUser == null) {
        _currentAuthState = AuthState.signedOut;
      } else if (user!.phoneNumber == null) {
        debugPrint("Phone number not found");
        _currentAuthState = AuthState.verifyPhone;
      } else {
        _currentAuthState = AuthState.loggedIn;
      }
    });
    notifyListeners();
  }

  Future<String?> forgetPassword(String email, String phoneNumber) async {
    String? response;
    try {
      await _auth.fetchSignInMethodsForEmail(email).then((value) {
        if (value.contains('password')) {
          verifyPhoneNumber(phoneNumber);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        response = 'Incorrect email address';
      }
    } catch (e) {
      response = 'Something went wrong.';
    }
    return response;
  }

  Future<String?> createNewPassword(String smscode, String newPassword) async {
    String? response;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smscode,
    );
    try {
      await _auth.signInWithCredential(credential).then((value) async {
        await value.user?.updatePassword(newPassword);
      }).then((_) {
        _currentAuthState = AuthState.loggedIn;
        notifyListeners();
      });
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    String? response;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        _auth.currentUser?.updatePhoneNumber(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        response = e.code;
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return response;
  }

  Future<String?> linkNumber(String smscode) async {
    String? response;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smscode,
    );
    try {
      await _auth.currentUser
          ?.linkWithCredential(credential)
          .then((value) async {
        if (value.user != null) {
          dprint('Calling add user');
          await db.addUser(value.user!).then((value) {
            if (value == "200") {
              _currentAuthState = AuthState.loggedIn;
            } else {
              debugPrint('Something went wrong this should not happen');
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      response = e.code;
    } catch (e) {
      response = e.toString();
    }
    notifyListeners();
    return response;
  }

  Future<String?> createAccount(
    String emailAddress,
    String password,
    String name,
  ) async {
    String? response;
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          _currentAuthState = AuthState.verifyPhone;
          _auth.currentUser?.updateDisplayName(name);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        response = 'The account already exists for that email.';
      }
    } catch (e) {
      debugPrint(e.toString());
      response = e.toString();
    }
    notifyListeners();
    return response;
  }

  Future<String?> signIn(String emailAddress, String password) async {
    String? response;
    try {
      await _auth
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        if (value.user != null) {
          if (value.user?.phoneNumber == null) {
            _currentAuthState = AuthState.verifyPhone;
          } else {
            _currentAuthState = AuthState.loggedIn;
          }
          notifyListeners();
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        response = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        response = 'Wrong password provided for that user.';
      }
    }
    return response;
  }

  Future signOut() async {
    await _auth.signOut().then((_) {
      _currentAuthState = AuthState.signedOut;
    });
    notifyListeners();
  }
}
