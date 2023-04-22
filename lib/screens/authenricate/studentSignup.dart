import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se2/services/auth.dart';
import 'package:se2/ui/theme.dart';

class SignupStudent extends StatefulWidget {
  @override
  _SignupStudentState createState() => _SignupStudentState();
}

class _SignupStudentState extends State<SignupStudent> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  List<String> _selectedClasses = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                    List<DropdownMenuItem<String>> items = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      final doc = snapshot.data!.docs[i];
                      items.add(DropdownMenuItem(
                        child: Text(doc['name']),
                        value: doc.id,
                      ));
                    }
                    return DropdownButtonFormField<String>(
                      items: items,
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) {
                            _selectedClasses.add(value);
                          }
                        });
                      },
                      value: null,
                      decoration: InputDecoration(
                        labelText: 'Classes',
                      ),
                      validator: (value) {
                        if (_selectedClasses.isEmpty) {
                          return 'Please select at least one class';
                        }
                        return null;
                      },
                      isExpanded: true,
                      isDense: true,
                      hint: Text('Select classes'),
                      selectedItemBuilder: (BuildContext context) {
                        return _selectedClasses.map((String id) {
                          final doc = snapshot.data!.docs
                              .firstWhere((doc) => doc.id == id);
                          return Text(doc['name']);
                        }).toList();
                      },
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.StudentSignUp(
                            _emailController.text, _passwordController.text);
                        //fix this later
                        await FirebaseFirestore.instance
                            .collection('students')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'email': _emailController.text,
                          'name': _nameController.text,
                          'classe': _selectedClasses,
                        });
                        Navigator.of(context).pop();
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth, 60),
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Sign up'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
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
