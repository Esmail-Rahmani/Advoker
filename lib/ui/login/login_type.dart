import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/services/OTP.dart';
import 'package:ylc/services/auth_service.dart';
import 'package:ylc/ui/login/signup_screen.dart';
import 'package:ylc/ui/onboarding/login_page.dart';
import 'package:ylc/widgets/navigaton_helper.dart';

class LoginType extends StatefulWidget {
  const LoginType({Key key}) : super(key: key);

  @override
  _LoginTypeState createState() => _LoginTypeState();
}

class _LoginTypeState extends State<LoginType> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogin = true;

  void loginToggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
  // final GoogleSignIn googleSign = GoogleSignIn();

  //  Future<String> signInWithGoogle(context) async {
  //   // showProgressIndicator(context);
  //   isLogin = true;
  //   final GoogleSignInAccount googleSignInAccount = await googleSign.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final UserCredential authResult =
  //   await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;
  //   if (user != null) {
  //     final splitname = user.displayName.split(" ");
  //     final data = {
  //       "signInMethod": "google",
  //       "email": user.email,
  //        // "fcm_token": await userClass.User().getFcmToken(),
  //       "first_name": splitname[0],
  //       "last_name": splitname[1],
  //       "contact": user.phoneNumber == null ? "" : user.phoneNumber,
  //       "google_id": user.uid.toString(),
  //       // ignore: deprecated_member_use
  //        "photo": user.photoURL,
  //     };
  //     print(data);
  //     final res = await callApi.post(url: 'social-network-sign-up', data: data);
  //     print(res.body);
  //
  //     final jsonRes = jsonDecode(res.body);
  //
  //     final response = jsonRes['response'];
  //
  //     switch (response) {
  //       case "INVALID_METHOD":
  //         {
  //           showInSnackBar(context,
  //               message: jsonRes['message'],
  //               showMessageAndPop: true,
  //               key: signInPageKey);
  //           signOutGoogle();
  //         }
  //         break;
  //       case "AUTHENTICATED":
  //         {
  //           final isUserNew = jsonRes['is_user_new'];
  //           final data = jsonRes['data'];
  //           sharedPref.save(localUserDataKey, jsonEncode(data));
  //           refreshUserData(context);
  //           if (isUserNew == "1") {
  //             push(context, Routes.profilePicturePage);
  //           } else {
  //             push(context, Routes.landingPage);
  //           }
  //         }
  //         break;
  //     }
  //   }
  //   return null;
  // }
  void login(){
    if(isLogin){
      // go to log in page
      navigateToPage(
        context,
        LoginPage(),
      );

    }else{
      // go to sign up page
      navigateToPage(
        context,
        SignupScreen(),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                   isLogin? 'Log in to Advocate': 'Sign up For Advocate',
                  style: TextStyle(fontSize: 27),
                )),

            Container(
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap:login,
                leading: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.email_sharp),
                ),
                title: Text(isLogin?'Sign In With Email':'Sign Up With Email'),
              ),
            ),

            GoogleSignInButton(
              onPressed: () async {
                Auth au = Auth();
                await au.signInWithGoogle(context , isLogin);
              },
              text: isLogin?'Sign In with google':'Sign Up with google',
            ),
            FacebookSignInButton(
              onPressed: () async {
                Auth au = Auth();
                await au.signInWithFb(context );
              },
              splashColor: Colors.blue,
            ),
            // FacebookSignInButton(
            //   onPressed: () async {
            //     print('no');
            //     await UserApi.getUserByName('esmail');
            //     print('yes');
            //   },
            //   splashColor: Colors.red,
            // ),
            Row(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: isLogin? 'Don\'t have an account? ':'already have an account',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
                TextButton(onPressed: loginToggle, child: Text(isLogin?'Sign Up':'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}


