import 'package:flutter/material.dart';
import 'package:se2/ui/loading.dart';

import '../../services/auth.dart';
import '../../ui/theme.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return  loading? Loading():Scaffold(
      backgroundColor: backg2,
      appBar: AppBar(
        backgroundColor: backg1,
        elevation: 0.0,
        title: const Text("Sign Up",style: TextStyle(color: mainColor,),),
        actions: [
          TextButton.icon(icon: Icon(Icons.person),
            onPressed: () {
              widget.toggleView();
            },
            label: Text('Sign in'),),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(//email;
                decoration: inputDeco.copyWith(hintText: 'Email',),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => (email=val));
                },
              ),
              SizedBox(height: 20,),
              TextFormField(//password
                decoration: inputDeco.copyWith(hintText: 'Password',),
                validator: (val) => val!.length<6? 'Enter password longer then 6 chars' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => (password=val));
                },
              ),
          SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    setState(() =>loading=true);
                    dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                    if (result==null){
                      setState(()
                      {
                        error='Please supply a valid email';
                        loading=false;
                      });
                    }
                  }
                },
                child: Text('Register',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor, // Background color
                ),
              ),
              SizedBox(height: 12,),
              Text(error,
                style: TextStyle(color: Colors.red,fontSize: 14),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
