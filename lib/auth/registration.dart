import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  String phno;
  RegisterPage({this.phno});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userEmail;
  bool success;
  String phone;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = widget.phno;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Phone no.' + phone),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardAppearance: Brightness.dark,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your full name',
                ),
                onChanged: (String value) {
                  this.name = value;
                },
              ),
              TextFormField(
                onSaved: (value) => _userEmail = value,
                decoration: InputDecoration(
                    labelText: 'E-Mail', prefixIcon: Icon(Icons.email)),
                controller: _emailController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter a valid email-id';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', prefixIcon: Icon(Icons.visibility)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter a valid password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      register();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(success == null
                    ? ''
                    : (success
                        ? 'Successfully registered ' + _userEmail
                        : 'Registration failed')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {
    final FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((user) async {
      //print(user.phoneNumber);
      //assert(user.email != null);
      //assert(user.displayName == name);
      //assert(await user.getIdToken() != null);

      print('success');
    }).catchError((e) {});

    if (user != null) {
      setState(() {
        success = true;
        _userEmail = user.email;
      });
      UserUpdateInfo userUpdateInfo;
      userUpdateInfo.displayName = name;
      user.updateProfile(userUpdateInfo);
      AuthCredential credential;

      UserInfo userInfo;
      print(userInfo.phoneNumber);
      userInfo.phoneNumber;
      user.linkWithCredential(credential);
      user.updatePhoneNumberCredential(credential);
      print(user.phoneNumber);
    } else {
      success = false;
    }
  }
}
