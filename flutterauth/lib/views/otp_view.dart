import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';

import 'package:provider/provider.dart';

TextEditingController _controller = TextEditingController();
OtpTextDisplay display = OtpTextDisplay(code: _controller.text);

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  void _addNumber(int i) {
    setState(() {
      _controller.text = _controller.text + i.toString();
      display = display..set(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.01),
        child: Center(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.04),
              child: Container(
                width: size.width * 0.5,
                height: size.height * 0.1,
                child: Text(
                  "Enter your Otp that was sent to your mobile phone",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ),
            ),
            OtpDisplay(),
            Container(
              margin: EdgeInsets.all(10),
              width: size.width * 0.9,
              child: Consumer2<UserAuthProvider,FavoriteProvider>(
                builder: (context, auth,favorite, child)
                {
                  return  TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  onPressed: () {
                    if (_controller.text.length == 6) {
                      auth.verifySmS(_controller.text,context);
                      auth.notifyListeners();
                    }
                  },
                  child: Container(
                    color: Colors.green,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
                }
              ),
            ),
            Container(
                height: size.height * 0.65,
                width: size.width * 0.7,
                child: GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: size.width * 0.05,
                    mainAxisSpacing: size.height * 0.04,
                    crossAxisCount: 3,
                    children: <Widget>[
                      for (int i = 1; i < 10; i++)
                        ElevatedButton(
                          onPressed: (() => _addNumber(i)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const CircleBorder(),
                          ),
                          child: Text(
                            i.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: (() {
                          setState(() {
                            if (_controller.text.isNotEmpty) {
                              _controller.text = _controller.text
                                  .substring(0, _controller.text.length - 1);
                              display = display..set(_controller.text);
                            }
                          });
                        }),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ((() => _addNumber(0))),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: Text(
                          0.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                          onPressed: (() {}),
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.grey),
                          )),
                    ])),
          ]),
        ),
      ),
    );
  }
}

class OtpDisplay extends StatefulWidget {
  OtpDisplay({Key? key}) : super(key: key);

  @override
  State<OtpDisplay> createState() => _OtpDisplayState();
}

class _OtpDisplayState extends State<OtpDisplay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int i = 0; i < 6; i++)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Center(
                        child: i < display.getLength()
                            ? Text(display.getChar()[i])
                            : Text(" ")),
                    height: size.height * 0.085,
                    width: size.height * 0.085,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpTextDisplay {
  late String code;
  OtpTextDisplay({required this.code});
  List<String> getChar() {
    return code.split("");
  }

  set(String data) {
    code = data;
  }

  void deleteNum() {
    code = code.substring(0, code.length - 1);
  }

  void add(String num) {
    code = code + num;
  }

  int getLength() {
    return code.length;
  }

  void delete6() {
    if (code.length > 6) {
      code = code.substring(0, code.length - (code.length - 1));
    }
  }
}
