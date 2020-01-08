/*
import 'package:flutter/material.dart';
import 'package:rol_fix/auth/phonesignin.dart';
import './otppage.dart';
import 'package:rol_fix/auth/otppage.dart';
import './otp.dart';
import '../main.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  String phno = null;
  bool _isDisabled;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Sign up'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(
            decoration:
                InputDecoration(prefix: Text('+91'), labelText: 'Phone'),
            keyboardType: TextInputType.phone,
            onChanged: (String value) {
              setState(() {
                phno = value;
                print(phno);
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: RaisedButton(
              child: Text('Verify'),
              highlightColor: Colors.green,
              color: Colors.black26,
              onPressed: () { 
                //(phno == null ) ? _isDisabled = false : true;
                (phno==null) ? null : Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneSignIn(phno: phno,) )) ;
              },
            ),
          )
        ],
      )),
    );
  }
}
*/

