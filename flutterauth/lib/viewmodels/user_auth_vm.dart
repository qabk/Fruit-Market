import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterauth/models/my_user.dart';
import 'package:flutterauth/services/auth_services.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:provider/provider.dart';

class UserAuthProvider with ChangeNotifier {
  late AuthService user;
  MyUser myUser = MyUser(
      uid: "",
      email: "",
      name: "",
      profile_img_link: "",
      phoneNumber: "",
      userId: "");
  UserAuthProvider() {
    user = AuthService.getInstance();
  }
  AuthService get() => user;

  void set() {
    print("It has init");
    AuthService.getInstance();
    notifyListeners();
  }

  void verifyPhone(String phone) async {
    user.verifyPhoneNumber(phone);
    notifyListeners();
  }

  void verifySmS(String pin, BuildContext context) async {
    user.verifyPin(pin, context);
    User userdata = await user.getUser();
    print("id" + userdata.uid);
    QuerySnapshot tmp = await FirebaseFirestore.instance
        .collection("Users")
        .where("userId", isEqualTo: userdata.uid)
        .get();
    Map<String, dynamic> tmpUserData =
        tmp.docs.map((doc) => doc.data()).toList()[0];
    print(tmpUserData);
    myUser = MyUser(
        userId: tmpUserData["userId"],
        uid: tmpUserData["uid"],
        email: tmpUserData["email"],
        name: tmpUserData["name"],
        profile_img_link: tmpUserData["profile_img_link"],
        phoneNumber: tmpUserData["phoneNumber"]);
    notifyListeners();
  }
}
