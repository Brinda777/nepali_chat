import 'package:nepali_chat/screen/chat_page.dart';
import 'package:nepali_chat/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterUser extends StatefulWidget {
  static String route = "RegisterUser";
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

final fnameController = TextEditingController();
final lnameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();

String radioClickedValue = "";
bool? checkBoxValue1 = false;
bool? checkBoxValue2 = false;

class _RegisterUserState extends State<RegisterUser> {
  // for login register
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // for database
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;

  @override
  void initState() {
    fnameController.text = "Brinda";
    lnameController.text = "Brinda";

    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      hintText: 'First Hint Hint Name',
                    ),
                    controller: fnameController,
                    obscureText: false,
                    validator: (first_name) {
                      if (first_name == null || first_name.isEmpty) {
                        return "First name is required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    controller: lnameController,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(),
                      hintText: 'Last Name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    autofocus: true,
                    controller: emailController,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(radioClickedValue),
                Text(checkBoxValue1.toString()),
                Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                              value: "male",
                              groupValue: radioClickedValue,
                              onChanged: (clickedItemName) {
                                setState(() {
                                  radioClickedValue = clickedItemName!;
                                });
                              },
                            ),
                            title: Text("Male"),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                              value: "female",
                              groupValue: radioClickedValue,
                              onChanged: (clickedItemName) {
                                setState(() {
                                  radioClickedValue = clickedItemName!;
                                });
                              },
                            ),
                            title: Text("Female"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: checkBoxValue1,
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValue1 = newValue;
                              });
                            }),
                        Text(
                          'I accept the terms and conditions',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Register'),
                    onPressed: () async {
                      print(emailController.text);
                      print(passwordController.text);
                      if (formKey.currentState!.validate()) {
                        // _Registeruser();
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (newUser != null) {
                          Navigator.pushReplacementNamed(
                              context, ChatPage.route);
                        }
                      }
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account?',
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.route);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
