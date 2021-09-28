import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:troovi_app/Screens/registration_page.dart';
import 'package:troovi_app/Screens/weight_display_screen.dart';
import 'package:troovi_app/constants.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: const Color(0xFFA020F1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Hero(
                    child: Image.asset(
                      'images/27358-8-sparkle-transparent-background.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    tag: 'image',
                  ),
                  const Expanded(
                    child: Text(
                      'Troovi',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Righteous',
                        fontSize: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  child: Text('Login', style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple[900],
                    fontSize: 18,
                  )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                  },
                  minWidth: double.infinity,
                  height: 45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  child: Text('Register', style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple[900],
                    fontSize: 18,
                  )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistrationScreen()));
                  },
                  minWidth: double.infinity,
                  height: 45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  child: Text('Anonymous Sign-in for Troovi', style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple[900],
                    fontSize: 18,
                  )),
                  onPressed: () async {
                    FirebaseAuth auth=FirebaseAuth.instance;
                    await auth.signInAnonymously().then((UserCredential user) async{
                      final User? user = auth.currentUser;
                      final String userId = user!.uid;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen(currentUser:userId )));
                    }).catchError((error)
                        {
                          alertBox(context, error);
                        }
                    );
                  },
                  minWidth: double.infinity,
                  height: 45,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
