import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthService {
  String? _verificationId;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;

// khoi tao doi tuong
  static AuthService getInstance() {
    if (_auth == Null) {
      _auth = FirebaseAuth.instance;
    }
    return AuthService();
  }


// ham verifyPhoneNumber
  Future verifyPhoneNumber(String phoneNumber) async {
    print("It 's initialized");
    await _auth.verifyPhoneNumber(
      timeout: Duration(seconds: 120),
      phoneNumber: "+84"+phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
             print(value.user);
          }
          else
          {
            print("error");
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print("error " + e.message);
      },
      codeSent: (String verficationID, int resendToken) {
    
        _verificationId = verficationID;
        
           
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        _verificationId = verificationID;
      },
    );
  }

  bool getLoginState() {
    return _isLoggedIn;
  }

  Future verifyPin(String pin,BuildContext context) async {
    try {
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationId, smsCode: pin))
          .then((value) async {
        if (value.user != null) {

          print("verification is the  $_verificationId");
          _isLoggedIn = true;
          print(_isLoggedIn);
        
  
      Navigator.pushNamed(context, '/home_page_view');
   
        }
      });
      
    } catch (e) {}
  }

  Future logout() async {
    await _auth.signOut();
    _isLoggedIn = false;
  }

  void changeLoginState()
  {
    _isLoggedIn = ! _isLoggedIn;
  }

  User getUser()
  {
    return _auth.currentUser;
  }
}
