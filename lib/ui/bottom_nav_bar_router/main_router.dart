import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/enums/user_mode.dart';
import 'package:ylc/ui/chat/chat_listing.dart';
import 'package:ylc/ui/consultation/my_consultations.dart';
import 'package:ylc/ui/homepage/advo_homepage.dart';
import 'package:ylc/ui/homepage/all_categories_page.dart';
import 'package:ylc/ui/homepage/drawer.dart';
import 'package:ylc/ui/homepage/home_screen.dart';
import 'package:ylc/ui/homepage/home_screen_advocate.dart';
import 'package:ylc/ui/homepage/homepage.dart';
import 'package:ylc/ui/notification/notification.dart';
import 'package:ylc/ui/profile/profile.dart';
import 'package:ylc/ui/questions_module/screens/questions_page.dart';
import 'package:ylc/values/colors.dart';
import 'package:ylc/widgets/ui_widgets/main_drawer.dart';

class MainRouter extends StatefulWidget {
  var currentIndex =0;

  MainRouter(this.currentIndex);

  @override
  _MainRouterState createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  final key = GlobalKey<ScaffoldState>();
  bool isAdvocate;


   List<IconData> bottomIconsData = [
    Icons.home,
    Icons.category_outlined,
    Icons.question_answer_outlined,
    Icons.chat,
  ];

  void changeIndex(int i) {
    if (i == 4) {
      // key.currentState.openEndDrawer();
      return;
    }
    if (widget.currentIndex != i) {
      setState(() {
        widget.currentIndex = i;
      });
    }
  }

  List<Widget> pages = [
    AdvocateHomeScreen(),
    NotificationPage(),
    QuestionsPage(),

    ChatListingPage(),
  ];
  List<Widget> Userpages = [
    HomeScreen(),
    AllCategoriesPage(),
    QuestionsPage(),

    ChatListingPage(),
  ];

  @override
  void initState() {
    isAdvocate = Provider.of<UserModel>(context, listen: false).isAdvocate ;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[900],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 26),
        unselectedIconTheme: IconThemeData(size: 22),
        type: BottomNavigationBarType.fixed,
        onTap: changeIndex,
        items: bottomIconsData
            .map(
              (data) => BottomNavigationBarItem(icon: Icon(data), label: ''),
            )
            .toList(),
      ),

      body:
      // pages[widget.currentIndex],
      isAdvocate ? pages[widget.currentIndex]:  Userpages[widget.currentIndex],
      // body: UploadDocuments(),
    );
  }
}
