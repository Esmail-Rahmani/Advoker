
import 'package:flutter/material.dart';
import 'package:ylc/ui/Settings/settings.dart';
import 'package:ylc/widgets/navigaton_helper.dart';

class Open extends StatefulWidget {
  @override
  _OpenState createState() => _OpenState();
}

class _OpenState extends State<Open> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('Open source licenses', style: TextStyle(color: Colors.black)),leading: IconButton(icon:Icon(Icons.arrow_back) , onPressed:()=> navigateToSetting(context))),
      body: buildOpen(),
    );
  }
  // ignore: missing_return
  Widget buildOpen()
  {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Conditions of Use',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('We will provide their services to you, which are subject to the conditions stated below in this document. Every time you visit this website, use its services or make a purchase, you accept the following conditions. This is why we urge you to read them carefully.'),
            SizedBox(height: 20,),
            Text('Copyright',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Content published on this website (digital downloads, images, texts, graphics, logos) is the property of [name] and/or its content creators and protected by international copyright laws. The entire compilation of the content found on this website is the exclusive property of [name], with copyright authorship for this compilation by [name].'),
            SizedBox(height: 20,),
            Text('Communications',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('The entire communication with us is electronic. Every time you send us an email or visit our website, you are going to be communicating with us. You hereby consent to receive communications from us. If you subscribe to the news on our website, you are going to receive regular emails from us. We will continue to communicate with you by posting news and notices on our website and by sending you emails. You also agree that all notices, disclosures, agreements and other communications we provide to you electronically meet the legal requirements that such communications be in writing.'),
            SizedBox(height: 20,),
            Text('Applicable Law',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('By visiting this website, you agree that the laws of the [your location], without regard to principles of conflict laws, will govern these terms of service, or any dispute of any sort that might come between [name] and you, or its business partners and associates.'),
          ],
        ),
      ),
    );

  }
  void navigateToSetting(context) {
    navigateToPage(context,SettingsScreen());
  }
}
