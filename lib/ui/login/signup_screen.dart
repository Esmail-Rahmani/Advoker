import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ylc/models/enums/user_mode.dart';
import 'package:ylc/services/auth_service.dart';
import 'package:ylc/ui/login/registrstion_screen.dart';
import 'package:ylc/ui/login/verification.dart';
import 'package:ylc/utils/regex.dart';
import 'package:ylc/values/strings.dart';
import 'package:ylc/widgets/custom_text_fields.dart';

import '../../app.dart';

class SignupScreen extends StatefulWidget {
  Map<String, String> data;

  SignupScreen({this.data});


  static const routeName = '/login--';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  UserMode userType;

  @override
  void initState() {
    initialValue();
    // TODO: implement initState
    super.initState();
  }
  void initialValue(){
    _emailController.text = widget.data != null? widget.data['email'] :'';
    _phoneController.text = widget.data != null && widget.data['contact'].isNotEmpty? widget.data['contact'] :'';
    _nameController.text = widget.data != null? widget.data['first_name']+' ' + widget.data['last_name']:'';
  }

  void _signUpUser(
    String email,
    String password,
    String name,
    String phone,
    BuildContext context,
  ) async {
    try {
      setLoadingStatus(true);
      var result = await Auth().signUpUser(
        email,
        password,
        name,
        phone,
        userType,
      );
      print(result.name);
      if (result != null ) {
        if( userType == UserMode.User){
          setLoadingStatus(true);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RootWidget(),
              ),
              (route) => false,
            );
        }else{
          setLoadingStatus(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationScreen(),
            ),
          );
        }
      } else {
        setLoadingStatus(false);
        print(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setLoadingStatus(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.generalError),
          duration: Duration(seconds: 2),
        ),
      );
      print(e);
    }
  }

  void setLoadingStatus(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  Widget buildRadioButton(String text, UserMode value) {
    return Expanded(
      child: Row(children: [
        Radio(
          value: value,
          groupValue: userType,
          onChanged: (value) {
            setState(() {
              userType = value;
              print(userType);
            });
          },
        ),
        FittedBox(child: Text(text)),
      ]),
    );
  }
  bool isChecked = false;
  TextEditingController phoneNumber = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign Up",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: TextFormField(

                      decoration: InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.person),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill your full name.';
                        }
                        return null;
                      },
                      controller: _nameController,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                    ),
                    controller: _phoneController,
                    validator: (v) => v.isNotEmpty ? null : Strings.phone,
                  ),
                   TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Enter email',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        Regex.emailValidationRegex.hasMatch(v ?? '')
                            ? null
                            : Strings.emailError,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                    controller: _passwordController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return Strings.passwordError;
                      } else if (v.length < 6) {
                        return Strings.passwordError2;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildRadioButton('I am an Advocate', UserMode.Advocate),
                        buildRadioButton('I am a User', UserMode.User),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("I agree with term and condition."),
                    value: isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate() &&
                                  isChecked &&
                                  userType != null) {
                                  _signUpUser(
                                    _emailController.text,
                                    _passwordController.text,
                                    _nameController.text,
                                    _phoneController.text,
                                    context,
                                  );
                              }
                            },
                            child:isLoading
                                ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ))
                                : Text("Next >"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
