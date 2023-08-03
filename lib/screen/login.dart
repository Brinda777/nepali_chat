import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepali_chat/screen/chat_page.dart';
import 'package:nepali_chat/screen/register.dart';

class LoginScreen extends StatefulWidget {
  static String route = "LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: TextFormField(
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
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // _login();
                          if (_formKey.currentState!.validate()) {
                            final result =
                                await _auth.signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            if (result != null) {
                              Navigator.pushReplacementNamed(
                                  context, ChatPage.route);
                            }
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Register'),
                      onPressed: () async {
                        // register page ma jau
                        Navigator.pushReplacementNamed(
                            context, RegisterUser.route);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
