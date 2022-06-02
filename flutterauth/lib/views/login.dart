import 'package:flutter/material.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';
import 'package:flutterauth/views/otp_view.dart';
import 'package:provider/provider.dart';

import '../viewmodels/favorite_provider.dart';

String splitString(String str)
{
  String res = "";
  for(int i = 0; i < 3; i++)
  {
    res += str.substring(0+i*3,3+i*3)+" ";
  }
  return res;
}
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  void _addNumber(int i) {
    setState(() {
      _controller.text = _controller.text + i.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              height: size.height * 0.05,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: Center(child: Text("+84" + _controller.text)),
            )
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: size.width * 0.9,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
              onPressed: () async {
                if (_controller.text.length == 9) {
                  Provider.of<UserAuthProvider>(context,listen:false).verifyPhone(splitString(_controller.text));
                  Navigator.pushNamed(context, '/otp_view');
                  
                   
                }
              },
              child: Container(
                color: Colors.green,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.6,
            width: size.width * 0.7,
            child: GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: size.width * 0.03,
              mainAxisSpacing: size.height * 0.03,
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
                      _controller.text = _controller.text
                          .substring(0, _controller.text.length - 1);
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
                  onPressed: (() => _addNumber(0)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  child: Text(
                    0.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(onPressed: (() {}), child: Text("OK",style: TextStyle(color: Colors.grey),)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Mybutton extends StatelessWidget {
  late String num;
  late TextEditingController controller;

  Mybutton({Key? key, required this.num, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        fixedSize: const Size(32, 32),
        shape: const CircleBorder(),
      ),
      child: Text(
        this.num,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
