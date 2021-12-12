import 'dart:ui';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/enums/category_enum.dart';
import 'package:ylc/models/enums/user_mode.dart';
import 'package:ylc/providers/advocates.dart';
import 'package:ylc/ui/advocates/advocates_page.dart';
import 'package:ylc/ui/bottom_nav_bar_router/main_router.dart';
import 'package:ylc/ui/document/document_generator_screen.dart';
import 'package:ylc/user_config.dart';
import 'package:ylc/widgets/category_card.dart';
import 'package:ylc/widgets/navigaton_helper.dart';
import 'package:ylc/widgets/ui_widgets/horizatal_scrllable_list.dart';
import 'package:ylc/widgets/ui_widgets/main_drawer.dart';
import 'package:ylc/widgets/ui_widgets/news_item.dart';

import '/utils/news_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryType> data = [];
  String _chosenValue;
  List<UserModel> advocates = [];
  List<UserModel> list = [];
  List<UserModel> list1 = [];

  List<UserModel> filteredList = [];

  bool isLoading;



  @override
  void initState() {
    setState(() {
      isLoading = true;
      this.fetchList();
    });

    super.initState();
  }

  Widget buildTitleText(String title) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .title,
      ),
    );
  }

   // Future<List<UserModel>> getList() async{
   //   list = await UserApi.getAllAdvocates(AppConfig.userId);
   //    list = list.getRange(0, 10);
   // }
  @override
  Widget build(BuildContext context) {
    var selectState = DropdownButton<String>(
      icon: Icon(Icons.location_pin),
      focusColor: Colors.black,
      value: _chosenValue,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: <String>[
        'All India',
        'Andhra Pradesh',
        'Assam',
        'Arunachal Pradesh',
        'Bihar',
        'Goa',
        'Gujarat',
        'Jammu and Kashmir',
        'Jharkhand',
        'West Bengal',
        'Karnataka',
        'Kerala',
        'Madhya Pradesh',
        'Maharashtra',
        'Manipur',
        'Meghalaya',
        'Mizoram',
        'Nagaland',
        'Orissa',
        'Punjab',
        'Rajasthan',
        'Sikkim',
        'Tamil Nadu',
        'Tripura',
        'Uttaranchal',
        'Uttar Pradesh',
        'Haryana',
        'Himachal Pradesh',
        'Chhattisgarh',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        );
      }).toList(),
      hint: Text(
        "Select State",
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          filteredList = [];
          _chosenValue = value;
          if (_chosenValue == 'All India') {
            print('llll');
            filteredList = advocates;
          } else {
            advocates.forEach((element) {

              if (element.additionalDetails.state!=null &&element.additionalDetails.state.toLowerCase() ==
                  _chosenValue.toLowerCase()) {
                filteredList.add(element);
              }
            });
          }
          print('${filteredList.length }  filltered');
        },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          selectState,
          SizedBox(width: 22,),
          Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,),
                  onPressed: () {
                    Navigator
                        .push(context, MaterialPageRoute(
                        builder: (context) => AdvocatesPage()));
                  })),
        ],
      ),
      drawer: MainDrawer(),
      body: isLoading || list.length==0
          ? Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).accentColor),
          ))
          :SingleChildScrollView(
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
            buildTitleText('Featured Advocates'),
            HorizontalListScrollable(list: list),
            Divider(),
            Container(
              margin: EdgeInsets.fromLTRB(8, 12, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme
                        .of(context)
                        .textTheme
                        .title,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainRouter(1)));
                      },
                      child: Text('See more'))
                ],
              ),
            ),
            Container(
              height: 120,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: data
                          .map(
                            (e) =>
                            Container(
                              margin: EdgeInsets.all(5),
                              height: 165,
                              width: 130,
                              child: CategoryCard(
                                model: e.data,
                                onTap: () =>
                                    navigateToPage(
                                      context,
                                      AdvocatesPage(model: e.data),
                                    ),
                              ),
                            ),
                      )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(DocumentGeneratorScreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(121,50,143, 0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.article_sharp,
                    color: Colors.white,
                    size: 46,
                  ),
                  title: Text(
                    'Free legal Document Generator',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Divider(),
            buildTitleText('Top 10'),
            HorizontalListScrollable(list: advocates.sublist(24,34)),
            Divider(),
            buildTitleText('Near you'),
            HorizontalListScrollable(list: advocates.sublist(28,34)),
            Divider(),
            buildTitleText('Trending'),
            HorizontalListScrollable(list: advocates.sublist(25, 34)),
            Divider(),
            buildTitleText('News'),
            ...NEWS_LIST
                .map((e) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsItem(e.id),
                ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Future<void> fetchList() async{
    data = List.from(CategoryType.values);
    // await this.getList();
    List<UserModel> value = await UserApi.getAllAdvocates(AppConfig.userId);
      setState(() {
        advocates = value;
        filteredList = value;
        advocates.forEach((element) {
          if(element.photo!=null && element.advocateDetails.experience !=null){
            list.add(element);
          }
        });
        isLoading = false;
      });

  }
}
