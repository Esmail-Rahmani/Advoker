import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/enums/drawer_item_enum.dart';
import 'package:ylc/models/enums/user_mode.dart';
import 'package:ylc/models/local/auth_model.dart';
import 'package:ylc/models/local/drawer_item_model.dart';
import 'package:ylc/services/auth_service.dart';
import '../Settings/settings.dart';
import 'package:ylc/ui/advocates/advocates_page.dart';
import 'package:ylc/ui/consultation/my_consultations.dart';
import 'package:ylc/ui/onboarding/upload_documents.dart';
import 'package:ylc/ui/profile/profile.dart';
import 'package:ylc/ui/questions_module/screens/ask_question_page.dart';
import 'package:ylc/ui/questions_module/screens/questions_page.dart';
import 'package:ylc/values/images.dart';
import 'package:ylc/values/strings.dart';
import 'package:ylc/widgets/custom_back_button.dart';
import 'package:ylc/widgets/drawer_item_card.dart';
import 'package:ylc/widgets/hide_widget.dart';
import 'package:ylc/widgets/navigaton_helper.dart';
import 'package:ylc/widgets/profile_image.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:app_review/app_review.dart';


class CustomDrawer extends StatefulWidget {
  final UserMode userMode;

  const CustomDrawer({Key key, this.userMode}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String appID = "";
  String output = "";
  @override
  void initState() {
    super.initState();
    AppReview.getAppID.then((onValue) {
      setState(() {
        appID = onValue;
      });
      print("App ID" + appID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      GeneralImages.profileBg,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => navigateToProfile(context),
                            child: ProfileImage(
                              photo: userModel.photo,
                              radius: 35,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            userModel.name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText(Strings.general),
                  DrawerItemCard(
                    model: DrawerItem.Profile.data,
                    onTap: () => navigateToProfile(context),
                  ),
                  HideWidget(
                    hide: widget.userMode == UserMode.User,
                    child: userModel.isVerified
                        ? DrawerItemCard(
                      model: DrawerItem.Verified.data,
                      color: Colors.green,
                    )
                        : DrawerItemCard(
                      model: DrawerItem.GetVerified.data,
                      onTap:
                      Provider.of<UserModel>(context, listen: false)
                          .isVerified
                          ? null
                          : () => navigateToVerifyDocuments(context),
                    ),
                  ),
                  DrawerItemCard(
                    model: DrawerItem.Advocates.data,
                    onTap: () => navigateToAdvocatesPage(context),
                  ),
                  DrawerItemCard(
                    model: DrawerItem.Questions.data,
                    onTap: () => navigateToAllQuestions(context),
                  ),
                  DrawerItemCard(
                    model: DrawerItem.MyQuestions.data,
                    onTap: () => navigateToUsersQuestions(context),
                  ),
                  // DrawerItemCard(
                  //   model: DrawerItem.MyAnswers.data,
                  //   onTap: () => navigateToUsersQuestions(context),
                  // ),

                  DrawerItemCard(
                    model: DrawerItem.AskQuestion.data,
                    onTap: () => navigateToAskQuestions(context),
                  ),
                  DrawerItemCard(model: DrawerItem.Following.data),
                  titleText(Strings.myConsultation),
                  DrawerItemCard(
                    model: widget.userMode == UserMode.User
                        ? DrawerItem.MyBookings.data
                        : DrawerItem.BookedByMe.data,
                    onTap: () => navigateToConsultations(context),
                  ),
                  titleText(Strings.others),
                  DrawerItemCard(model: DrawerItem.Share.data,
                      onTap: ()=>share() ),
                  DrawerItemCard(model: DrawerItem.RateApp.data, onTap: ()=>{
                    AppReview.requestReview.then((onValue) {
                      setState(() {
                        output = onValue;
                      });
                      print(onValue);
                    })},),
                  DrawerItemCard(model: DrawerItem.Settings.data, onTap: () => navigateToSettings(context)),
                  DrawerItemCard(
                    model: DrawerItemModel(null, 'Logout'),
                    onTap: () {
                      _signOut(context);
                    },
                  ),
                ],
              ),
            ),
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
        chooserTitle: 'Example Chooser Title'
    );
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

  void navigateToProfile(context) {
    navigateToPage(context, Profile());
  }

  void navigateToAdvocatesPage(context) {
    navigateToPage(context, AdvocatesPage());
  }

  void navigateToConsultations(context) {
    navigateToPage(context, MyConsultations());
  }

  void navigateToVerifyDocuments(context) {
    navigateToPage(
      context,
      UploadDocuments(
        shouldPopOnUpload: true,
      ),
    );
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    var result = await Auth.signOut();
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
}
