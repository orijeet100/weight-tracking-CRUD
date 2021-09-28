import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:troovi_app/Screens/weight_display_screen.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  bool showSpinner=false;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA020F1),
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: ListView(
            children: [
              Align(
                alignment: const Alignment(0, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Hero(
                    child: Image.asset(
                      'images/27358-8-sparkle-transparent-background.png',
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                    tag: 'image',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextFormField(
                  obscureText: false,
                  decoration: kTextField.copyWith(hintText: 'Enter your email address'),
                  style: kTextStyle.copyWith(fontSize: 17,color: Colors.white),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    email=value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  obscureText: false,
                  decoration: kTextField.copyWith(hintText: 'Enter your password(More than 6 characters)'),
                  style: kTextStyle.copyWith(fontSize: 17,color: Colors.white),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value){
                    password=value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Material(
                  elevation: 5,
                  color: const Color(0xFF2576FF),
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    child: const Text('Register', style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
                    )),
                    onPressed: () async{
                      setState(() {
                        showSpinner=true;
                      });

                      try{
                        await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DisplayScreen(currentUser: _auth.currentUser!.email)));
                        setState(() {
                          showSpinner=false;
                        });
                      }

                      catch(error){
                        setState(() {
                          showSpinner=false;
                        });
                        alertBox(context, error);
                      }
                    },
                    minWidth: double.infinity,
                    height: 45,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
