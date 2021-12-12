import 'dart:ui';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ylc/providers/advocates.dart';
import 'package:ylc/ui/advocates/advocates_page.dart';
import 'package:ylc/ui/bottom_nav_bar_router/main_router.dart';
import 'package:ylc/ui/category/categories_screen.dart';
import 'package:ylc/ui/document/document_generator_screen.dart';
import 'package:ylc/utils/categoris_list.dart';
import 'package:ylc/widgets/ui_widgets/category_item.dart';
import 'package:ylc/widgets/ui_widgets/horizatal_scrllable_list.dart';
import 'package:ylc/widgets/ui_widgets/main_drawer.dart';
import 'package:ylc/widgets/ui_widgets/news_item.dart';

import '/utils/news_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvocateHomeScreen extends StatefulWidget {
  const AdvocateHomeScreen({Key key}) : super(key: key);

  @override
  _AdvocateHomeScreenState createState() => _AdvocateHomeScreenState();
}

class _AdvocateHomeScreenState extends State<AdvocateHomeScreen> {
  Widget buildTitleText(String title) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<Advocates>(context).list;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),

        title: Center(child: Text('Home', style: TextStyle(color: Colors.black),)),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,),
                  onPressed:(){
                    Navigator
                        .push(context, MaterialPageRoute(builder:(context) => AdvocatesPage()));
                  })),
        ],
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.black),
              child: ListTile(
                title: Text(
                  'Check the Law of the Day',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                    primary: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Read",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTitleText('Upcoming consultation'),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 7.0,
                  percent: 0.8,
                  center: new Text("5"),
                  progressColor: Colors.green,
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('your earning this month'),
                Icon(

                  Icons.trending_up_sharp,
                  color: Colors.blue,
                  size: 35,
                ),
              ],
            ),
            buildTitleText('12,457.98'),
            Divider(),
            buildTitleText('News'),
            ...NEWS_LIST
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewsItem(e.id),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
