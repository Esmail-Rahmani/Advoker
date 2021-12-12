import 'package:flutter/material.dart';
import 'package:ylc/ui/login/signup_screen.dart';
import 'package:ylc/ui/login/verification.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget buildRadioButton(String text, String value) {
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
  var userType;
  TextEditingController phoneNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Image(
                      image: AssetImage('assets/Images/logo.png'),
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
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 18.0),
                  child: TextField(
                    controller: phoneNumber,
                    decoration: InputDecoration(labelText: "Phone Number"),
                    keyboardType: TextInputType.phone,
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
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildRadioButton('I am an Advocate', 'Advocate'),
                      buildRadioButton('I am a User', 'User'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                            primary: Colors.black,
                          ),
                          onPressed: () => goToNextPage(phoneNumber.text),
                          child: Text("Next >"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToNextPage(String phone) {
    if (phone.isNotEmpty && isChecked && userType != null) {
      if (userType == 'User') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      }
    }
  }
}
