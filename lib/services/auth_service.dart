import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/subjects.dart';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/enums/user_mode.dart';
import 'package:ylc/ui/login/signup_screen.dart';
import 'package:ylc/ui/onboarding/login_page.dart';
import 'package:ylc/utils/api_result.dart';
import 'package:ylc/widgets/navigaton_helper.dart';

import '../user_config.dart';

enum AuthStatus { unknown, notLoggedIn, loggedIn }

class Auth {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  static final _user = BehaviorSubject<UserModel>();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'afghanesmaeel@gmail.com',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User> user1;
  Stream<Map<String, dynamic>> profile;
  final PublishSubject loading = PublishSubject();

  Future<User> googleSignIn() async {
    var result;
    try {
      result = await _googleSignIn.signIn();
    } on Exception catch (e) {
      // TODO
      print("$e this is what");
    }
    return result;
  }

  static Function(UserModel) get updateUser => _user.sink.add;

  Auth() {

    // AppConfig.pref.setString("userId", "604cdd3ac5cfd3149a4a4561");
    // AppConfig.pref.setString("userId", "602801947ddc180c524039d5");
    if (AppConfig.userId != null) {
      UserApi.getUser(uid: AppConfig.userId).then((model) {
        if (model != null) {
          _user.add(model);
        }
      });
    }
  }

  // Future<String> signInWithFacebook(context) async {
  //   try {
  //     final AccessToken result = await FacebookAuth.instance
  //         .login(); // by default we request the email and the public profile
  //     // or FacebookAuth.i.login()
  //     final AccessToken accessToken = await FacebookAuth.instance.isLogged;
  //     print('$result nooooooothing');
  //     if (accessToken != null) {
  //       // you are logged
  //       final userData = await FacebookAuth.instance.getUserData();
  //
  //       // loginWithGoogleOrFacebook('afghanesmaeel@gmail.com');
  //       print("${userData} esmail");
  //     }
  //   } on Exception catch (e) {
  //     print('$e   akhtar');
  //     // TODO
  //   }
  // }



  final fb = FacebookLogin();

  signInWithFb(context) async {
    // showProgressIndicator(context);
    final fbRes = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    print('$fbRes llllllll');

    switch (fbRes.status) {
      case FacebookLoginStatus.success:
      // Logged in
      // Send access token to server for validation and auth
        final profile = await fb.getUserProfile();
        final imageUrl = await fb.getProfileImageUrl(width: 1000);
        final email = await fb.getUserEmail();
        final splitname = profile.name.split(" ");

        final data = {
          "signInMethod": "facebook",
          "email": email,
          "first_name": splitname[0],
          "last_name": splitname[1],
          "facebook_id": profile.userId,
          'contact': '',
           // "fcm_token": await userClass.User().getFcmToken(),
          "photo": imageUrl,
        };
        print(data);
        UserModel user = await loginWithGoogleOrFacebook(data['email']);
        if (user == null) {
          navigateToPage(
            context,
            SignupScreen(data: data),
          );
        }
    }
  }


  // google sign up
  final GoogleSignIn googleSign = GoogleSignIn();

  Future<String> signInWithGoogle(context, bool isLogin) async {
    // showProgressIndicator(context);
    final GoogleSignInAccount googleSignInAccount = await googleSign.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      final splitname = user.displayName.split(" ");
      final data = {
        "signInMethod": "google",
        "email": user.email,
        // "fcm_token": await userClass.User().getFcmToken(),
        "first_name": splitname[0],
        "last_name": splitname[1],
        "contact": user.phoneNumber == null ? "" : user.phoneNumber,
        "google_id": user.uid.toString(),
        // ignore: deprecated_member_use
        "photo": user.photoURL,
      };
      if (isLogin) {
        UserModel user = await loginWithGoogleOrFacebook(data['email']);
        if (user == null) {
          navigateToPage(
            context,
            SignupScreen(data: data),
          );
        }
        // navigateToPage(
        //   context,
        //   LoginPage(data: data),
        // );
      } else {
        navigateToPage(
          context,
          SignupScreen(data: data),
        );
      }
    }
    return null;
  }

  Stream<UserModel> get user => _user.stream;

  Future<String> googleSignOut() async {
    await googleSign.signOut();
  }

  static Future<ApiResult<String>> signOut() async {
    try {
      await AppConfig.pref.setString("userId", null);
      _user.add(null);
      return ApiResult.successWithNoMessage();
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<UserModel> signUpUser(
    String email,
    String password,
    String name,
    String phone,
    UserMode mode,
  ) async {
    var result = await UserApi.createUser(
      name: name.trim(),
      email: email,
      phone: phone,
      password: password,
      isAdvocate: mode == UserMode.Advocate,
    );
    if (result != null) {
      await AppConfig.pref.setString("userId", result.id);
    }
    _user.add(result);
    return result;
  }

  Future<UserModel> loginWithGoogleOrFacebook(String email) async {
    UserModel user = await UserApi.getUserByEmail(email);
    if (user != null) {
      await AppConfig.pref.setString("userId", user.id);
    }
    _user.add(user);
    return user;
  }

  Future<UserModel> loginWithFacebook(String email) async {
    UserModel user = await UserApi.getUserByEmail(email);
    if (user != null) {
      await AppConfig.pref.setString("userId", user.id);
    }
    _user.add(user);
    return user;
  }

  Future<UserModel> loginUserWithEmail(String email, String password) async {
    try {
      var model = await UserApi.loginUser(email: email, password: password);
      if (model != null) {
        await AppConfig.pref.setString("userId", model.id);
      }
      _user.add(model);
      return model;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void dispose() {
    _user.close();
  }
}
