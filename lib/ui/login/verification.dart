import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:ylc/ui/bottom_nav_bar_router/main_router.dart';
import 'package:ylc/widgets/navigaton_helper.dart';


import './login_screen.dart';

class Verification extends StatefulWidget {
final String phoneNumber;

Verification(this.phoneNumber);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String _countDown;
  OTPCountDown _otpCountDown;
  final int _otpTimeInMS = 1000 * 2 * 60;
  var isVerified = false;

  @override
  void initState() {
    _startCountDown();
    super.initState();
  }

  @override
  void dispose() {
    isVerified = true;
    super.dispose();
  }

  void _startCountDown() {
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        if (mounted) {
          setState(() {});
        }
      },
      onFinish: () {
        print("Count down finished!");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Image.asset(
              'images/LOGO.png',
            ),
            onPressed: () {},
            iconSize: 70,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 30),
                  child: Text(
                    'OTP Verification',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )),
              Text('An OTP has been send to your number.',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: widget.phoneNumber == null ? 'null' : widget.phoneNumber,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: ' Change',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {
                              Navigator.of(context).pop(),
                            },
                    )
                  ])),
                ),
              ),
              OTPTextField(
                length: 6,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                onCompleted: verify,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    _countDown != null ? _countDown : '0:0',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 8.0),
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'If you didn\'t receive the code ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      TextSpan(
                          text: 'Resend',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  // resend code and restart timer
                                })
                    ]),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 240),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                      primary: Colors.black,
                    ),
                    onPressed: goToNextPage,
                    child: Text("Next >")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToNextPage() {}

  void verify(String value) {
    if (value == '1234') {
      navigateToPage(
        context,
        MainRouter(0),
      );
      isVerified = true;
    }
  }
}
