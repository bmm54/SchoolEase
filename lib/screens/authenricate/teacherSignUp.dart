import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth.dart';
import '../../ui/loading.dart';
import '../../ui/theme.dart';

class TeacherSignupForm extends StatefulWidget {
  @override
  _TeacherSignupFormState createState() => _TeacherSignupFormState();
}

class _TeacherSignupFormState extends State<TeacherSignupForm> {
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  List<String> _selectedClasses = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.95;
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDeco.copyWith(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: inputDeco.copyWith(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: inputDeco.copyWith(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('classes')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          return CheckboxListTile(
                            title: Row(
                              children: [
                                Text(
                                  'Classes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                            value: _selectedClasses.isNotEmpty,
                            onChanged: (value) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final doc = snapshot.data!.docs[index];
                                      return CheckboxListTile(
                                        title: Text(doc['name']),
                                        value:
                                            _selectedClasses.contains(doc.id),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              _selectedClasses.add(doc.id);
                                            } else {
                                              _selectedClasses.remove(doc.id);
                                            }
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .TeacherSignUp(
                                _emailController.text,
                                _passwordController.text,
                              );
                              await FirebaseFirestore.instance
                                  .collection('teachers')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                'email': _emailController.text,
                                'name': _nameController.text,
                                'classes': _selectedClasses,
                              });
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text('Sign up'),
                          style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth, 60),
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          //navigate to sign in page
                          Navigator.of(context).pop();
                        },
                        child: Text('Already have an account? Sign in'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
