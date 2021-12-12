import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ylc/app.dart';
import 'package:ylc/services/auth_service.dart';
import 'package:ylc/ui/login/forget_password.dart';
import 'package:ylc/ui/login/login_type.dart';
import 'package:ylc/ui/login/signup_screen.dart';
import 'package:ylc/utils/regex.dart';
import 'package:ylc/values/colors.dart';
import 'package:ylc/values/images.dart';
import 'package:ylc/values/strings.dart';
import 'package:ylc/widgets/custom_buttons.dart';
import 'package:ylc/widgets/custom_text_fields.dart';
import 'package:ylc/widgets/loading_view.dart';
import 'package:ylc/widgets/navigaton_helper.dart';
import 'package:ylc/widgets/onboarding_background.dart';
import 'package:ylc/widgets/simple_dialog_input.dart';

class LoginPage extends StatefulWidget {
  Map<String, String> data;

  LoginPage({this.data});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
@override
  void initState() {
  if(widget.data!=null ){
    _emailController.text = widget.data['email'];
  }
  // TODO: implement initState
    super.initState();
  }
  void _loginUser({
    String email,
    String password,
    BuildContext context,
  }) async {
    try {

      // if (_formKey.currentState.validate()) {
        changeLoading(true);
        var userModel = await Auth().loginUserWithEmail(email, password);
        if (userModel != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RootWidget(),
            ),
            (route) => false,
          );
        } else {
          changeLoading(false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went wrong"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      // }
    } catch (e) {
      print(e);
      changeLoading(false);
    }
  }

  void changeLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingView(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Image(
                    image: AssetImage('images/LOGO.png'),
                    width: 70,
                    height: 70,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 0),
                child: Text.rich(
                  TextSpan(
                    text: 'Trusted ',
                    style: TextStyle(fontSize: 27, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Legal Solutions ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 27,
                          )),
                      TextSpan(
                          text: 'For The Real World. ',
                          style: TextStyle(
                            fontSize: 27,
                          )),

                      // can add more TextSpans here...
                    ],
                  ),
                ),
              ),
              Text('Get the Expertise of Low.',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              SizedBox(
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: YlcColors.categoryForeGround,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.1),
                        Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 40,
                          ),
                        ),
                        SizedBox(height: 40),
                        CustomTextField(
                          color: YlcColors.textColor1,
                          controller: _emailController,
                          prefixIcon: Icons.email,
                          hintText: Strings.email,
                          validator: (v) =>
                              Regex.emailValidationRegex.hasMatch(v ?? '')
                                  ? null
                                  : Strings.emailError,
                        ),
                        SizedBox(height: 12),
                        CustomTextField(
                          color: YlcColors.textColor1,
                          obscureText: true,
                          controller: _passwordController,
                          prefixIcon: Icons.lock,
                          hintText: Strings.password,
                          validator: (v) =>
                              v.isNotEmpty ? null : Strings.passwordError,
                        ),
                        SizedBox(height: 12),
                        //forget password
                        GestureDetector(
                          onTap: ()  {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            Strings.forgotPassword,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Button1(
                          buttonText: Strings.signIn,
                          onPressed: () {
                            _loginUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        // Spacer(flex: 1,),
                        Column(
                          children: [
                            Text(Strings.dontHaveAccount),
                            FlatButton(
                              child: Text(
                                Strings.signUp.toUpperCase(),
                                style: TextStyle(
                                  color: YlcColors.textColor1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                navigateToPage(
                                  context,
                                  SignupScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
