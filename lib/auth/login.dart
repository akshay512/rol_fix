import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rol_fix/interface/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import './signup.dart';
import './phonesignin.dart';
import '../interface/homepage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String _emailValue;
  bool _acceptTerms = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((user) {
      if (user != null) {
        (user.isEmailVerified)
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()))
            : EasyDialog(description: Text('Email is not verified'));
      }
    });
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple),
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Login"),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  onSaved: (value) => _emailValue = value,
                  decoration: InputDecoration(labelText: 'E-Mail',prefixIcon: Icon(Icons.email)),
                  controller: emailController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter a valid email-id';
                    }
                    return null;
                  },
                ),SizedBox(height: 10.0,),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password',prefixIcon: Icon(Icons.visibility,size: 15,),),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                ),
                SwitchListTile(
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    _acceptTerms = value;
                  },
                  title: Text('Accept terms'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  highlightColor: Colors.green,
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Login'),
                  onPressed: () async {
                    FirebaseUser user;
                    try {
                      user = (await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)) as FirebaseUser;
                    } catch (e) {} finally {
                      if (user != null) {
                        user.sendEmailVerification();
                        (user.isEmailVerified)
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()))
                            : EasyDialog(
                                description: Text('Email is not verified'));
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Sign up'),
                      highlightColor: Colors.cyan,
                      textColor: Colors.red,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneSignIn()));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      child: Text('HomePage'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
