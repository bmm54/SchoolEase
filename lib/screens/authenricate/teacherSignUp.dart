import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se2/ui/theme.dart';

import 'package:flutter/material.dart';

class TeacherSignupForm extends StatefulWidget {
  final Function toggleView;

  TeacherSignupForm({required this.toggleView});

  @override
  _TeacherSignupFormState createState() => _TeacherSignupFormState();
}

class _TeacherSignupFormState extends State<TeacherSignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  List<String> _selectedClasses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Sign Up'),
      ),
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
                  decoration: inputDeco.copyWith(labelText: 'Email',),
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
                  decoration: inputDeco.copyWith(labelText: 'Password',),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: inputDeco.copyWith(labelText: 'Name',),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('document')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print('snapshot data: ${snapshot.data.toString()}');
                      return Container();
                    }
                    return CheckboxListTile(
                      title: Text('Classes'),
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
                                  value: _selectedClasses.contains(doc.id),
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
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        await FirebaseFirestore.instance
                            .collection('teachers')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
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
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    widget.toggleView();
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
