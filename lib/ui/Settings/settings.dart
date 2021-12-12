
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:ylc/ui/Settings/OpenL.dart';
import 'package:ylc/ui/Settings/privacy.dart';
import 'package:ylc/ui/bottom_nav_bar_router/main_router.dart';
import 'package:ylc/widgets/navigaton_helper.dart';
import 'package:package_info/package_info.dart';
import 'TermaServices.dart';
import 'OpenL.dart';
import 'feedback.dart';
import 'privacy.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
   _infoTile( String subtitle) {
    return (subtitle.isNotEmpty ? subtitle : 'Not set');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),

          title: Text('Settings' ,style: TextStyle(color: Colors.black),),leading: IconButton(icon:Icon(Icons.arrow_back) , onPressed:()=>navigateToProfile(context))),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile(
              title: 'App version',
              subtitle: _infoTile( _packageInfo.version),
              leading: Icon(Icons.app_settings_alt),
            ),
            SettingsTile(
              title: 'FAQs',
              leading: Icon(Icons.question_answer),
            ),
            SettingsTile(
                title: 'Privacy Policy', leading: Icon(Icons.policy),onPressed:navigateToPolicy),
            SettingsTile(
                title: 'Terms of Service ', leading: Icon(Icons.description),onPressed:navigateToTerms),
            SettingsTile(
                title: 'Open source licenses',
                leading: Icon(Icons.collections_bookmark),onPressed:navigateToOpen),
            SettingsTile(
                title: 'Feedback',
                leading: Icon(Icons.feedback_rounded),onPressed:navigateToFeed),
          ],
        ),
      ],
    );
  }
  void navigateToProfile(context) {
    navigateToPage(context,MainRouter(0));
  }
  void navigateToTerms(context) {
    navigateToPage(context,Terms());
  }
  void navigateToPolicy(context) {
    navigateToPage(context,Policy());
  }
  void navigateToOpen(context) {
    navigateToPage(context,Open());
  }
  void navigateToFeed(context) {
    navigateToPage(context,ReachUs());
  }

}


















































































// import 'package:flutter/material.dart';
// import 'package:ylc/ui/bottom_nav_bar_router/main_router.dart';
// import 'package:ylc/widgets/navigaton_helper.dart';
// import 'package:package_info/package_info.dart';
//
// class Settings extends StatefulWidget {
//   @override
//   _SettingsState createState() => _SettingsState();
// }
//
// class _SettingsState extends State<Settings> {

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Settings'),
//               leading: IconButton(
//                    icon: const Icon(Icons.arrow_back),
//                    onPressed: () {
//                     navigateToProfile(context);
//                   },
//     ),
//     ),
//       body:Container(
//         color:Colors.white ,
//         child: ListView(
//               children: <Widget>[
//                 Container(
//                   height: 50,
//                   color: Colors.white,
//                   child:ListTile(title: Text('Privacy Policy'),subtitle:),
//                 ),
//                 SizedBox(height: 10,),
//                 Divider(height: 5,),
//                 Container(
//                   height: 50,
//                   color: Colors.white,
//                   child: Text('FAQs'),
//                 ),
//                 Divider(height: 5,),
//                 Container(
//                   height: 50,
//                   color: Colors.white,
//                   child: Text('Privacy Policy'),
//                 ),
//                 Divider(height: 5,),
//                 Container(
//                   height: 50,
//                   color: Colors.white,
//                   child: Text('Terms of Use'),
//                 ),
//                 Divider(height: 5,),
//                 Container(
//                   height: 50,
//                   color: Colors.white,
//                   child: Text('Feedback'),
//                 ),
//               ],
//             ),
//       ),
//         );
//   }
// }


