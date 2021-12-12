import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/app.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/local/auth_model.dart';
import 'package:ylc/services/auth_service.dart';
import 'package:ylc/ui/Settings/TermaServices.dart';
import 'package:ylc/ui/Settings/settings.dart';
import 'package:ylc/ui/profile/profile.dart';
import 'package:ylc/ui/questions_module/screens/ask_question_page.dart';
import 'package:ylc/ui/questions_module/screens/questions_page.dart';
import 'package:ylc/user_config.dart';
import '../navigaton_helper.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  UserModel user;

  bool isLoading =true;

  Widget buildSidebarTitle(
      BuildContext context, String text, Function navigate) {
    return Container(
      color: Colors.black,
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
              fontFamily: 'RobotoCondensed', fontSize: 20, color: Colors.white),
        ),
        onTap: () => navigate(context),
      ),
    );
  }
  @override
  void initState() {

    setState(() {
      isLoading = true;
    });
    UserApi.getUser(uid: AppConfig.userId).then((value) {
      setState(() {
        user = value;
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(30, 40, 10, 10),
              color: Colors.black,
              child: isLoading? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  )):Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        user.photo==null? 'https://www.woolha.com/media/2020/03/eevee.png':user.photo),
                    minRadius: 50,
                    maxRadius: 75,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppConfig.userName,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        user.phone??'null',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildSidebarTitle(context, "Profile ", navigateToProfile),
            buildSidebarTitle(context, "Questions ", navigateToAllQuestions),
            buildSidebarTitle(context, "Favorites", () {}),
            buildSidebarTitle(context, "Settings", navigateToSettings),
            buildSidebarTitle(context, "Terms", navigateToTerms),
            Container(
              color: Colors.black,
              child: ListTile(
                title: Text(
                  'Share',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 20,
                      color: Colors.white),
                ),
                onTap: share,
              ),
            ),
            buildSidebarTitle(context, "Rate App", () {}),
            buildSidebarTitle(context, "Logout", _signOut),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  void _signOut(BuildContext context) async {
    var result = await Auth.signOut();
    var au = Auth();
    au.googleSignOut();
    if (result.isSuccess) {
      Phoenix.rebirth(context);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => RootWidget(),
      //   ),
      //   (route) => false,
      // );
    }
  }

  void navigateToAskQuestions(context) {
    navigateToPage(context, AskQuestionsPage());
  }

  void navigateToSettings(context) {
    navigateToPage(context, SettingsScreen());
  }

  void navigateToAllQuestions(context) {
    navigateToPage(context, QuestionsPage());
  }

  void navigateToUsersQuestions(context) {
    navigateToPage(
      context,
      QuestionsPage(userId: Provider.of<AuthModel>(context, listen: false).uid),
    );
  }
  void navigateToTerms(context) {
    navigateToPage(context,Terms());
  }
  void navigateToProfile(context) {
    navigateToPage(context, Profile());
  }
}
