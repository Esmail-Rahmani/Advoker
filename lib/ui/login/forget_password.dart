import 'package:flutter/material.dart';
import 'package:ylc/ui/login/verification.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 18.0),
                  child: TextField(
                    controller: phoneNumber,
                    decoration: InputDecoration(labelText: "Phone Number"),
                    keyboardType: TextInputType.phone,
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
                          onPressed: () {
                            if (phoneNumber.text.isNotEmpty){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Verification(phoneNumber.text),
                                ),
                              );
                            }

                          },
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
}
