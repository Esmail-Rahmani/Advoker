
import 'package:flutter/material.dart';
import 'package:ylc/ui/Settings/settings.dart';
import 'package:ylc/widgets/navigaton_helper.dart';

class Policy extends StatefulWidget {
  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('Privacy Policy', style: TextStyle(color: Colors.black)),leading: IconButton(icon:Icon(Icons.arrow_back) , onPressed:()=> navigateToSetting(context))),
      body: buildPrivacy(),
    );
  }
  // ignore: missing_return
  Widget buildPrivacy()
  {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Before you continue using our website we advise you to read our privacy policy [link to privacy policy] regarding our user data collection. It will help you better understand our practices.'),
             SizedBox(height: 20,),
            Text('To be transparent with your users about what personal information you collect and what you do with it, you are required to publish a Privacy Policy agreement on your website or give in-app access to it.'),
            SizedBox(height: 20,),
            Text('Websites usually post a link to the complete Privacy Policy agreement from the footer of the website, whereas apps generally add the Privacy Policy to an "About" or "Legal" menu.'),
            SizedBox(height: 20,),
            Text('Another popular location for ecommerce store apps and websites is the checkout page, or account registration page if you dont have an ecommerce component but allow users to create accounts.'),
          ],
        ),
      ),
    );
  }
  void navigateToSetting(context) {
    navigateToPage(context,SettingsScreen());
  }
}
