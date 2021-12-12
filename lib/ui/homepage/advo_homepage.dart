import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ylc/models/enums/category_enum.dart';
import 'package:ylc/ui/advocates/advocates_page.dart';
import 'package:ylc/ui/advocates/custom_consultation.dart';
import 'package:ylc/ui/homepage/all_categories_page.dart';
import 'package:ylc/values/colors.dart';
import 'package:ylc/values/images.dart';
import 'package:ylc/values/strings.dart';
import 'package:ylc/widgets/category_card.dart';
import 'package:ylc/widgets/navigaton_helper.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePageStates createState() => _HomePageStates();
}

class _HomePageStates extends State<HomePages> {
  // final List<CategoryType> categoriesOnHomePage = [
  //   CategoryType.Family,
  //   CategoryType.RealEstate,
  //   CategoryType.Insurance,
  //   CategoryType.LabourEmployment,
  //   CategoryType.Criminal,
  //   CategoryType.Immigration,
  // ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(

          iconTheme: IconThemeData(color: Colors.green),
          title: Padding(
              padding: const EdgeInsets.only(right:200.0),
              child: Image.asset(
                "images/advocatefull.png",
                height: 45.0,
                fit: BoxFit.cover,
              ),
            ),
            titleSpacing: 0.0,
            backgroundColor: Colors.white,),
        body: ListView(
          children: [
            SizedBox(height: 12),
            Container(
              height: 250,
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          YlcColors.colorFilterWarm,
                          BlendMode.hue,
                        ),
                        child: Image.asset(
                          GeneralImages.appBarImage,
                          height: 200,
                          // color: YlcColors.colorFilterWarm,
                          // colorBlendMode: BlendMode.softLight,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      Strings.yourLegalConsultancy,
                      style: GoogleFonts.lora(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)
              ),
              child: Container(
                color: YlcColors.categoryBackGround,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Your Overall Ratings Are: ",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(" 5 Stars "),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                height: 60,),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
              ),
            ),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)
              ),
              child: Container(
                color: YlcColors.categoryBackGround,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Overall Earnings Are: ",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" Rs. 45,86,980 "),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 40,
                              height: 60,),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)
              ),
              child: Container(
              color: YlcColors.categoryBackGround,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your Overall Consultations Are: ",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" 12,065 "),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 40,
                              height: 60,),
                          ]),
                      SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
            ),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)
              ),
              child: Container(
                color: YlcColors.categoryBackGround,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Upcoming Consultations Are: ",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 8),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("12th March 2021, 3.00pm with Ms.Dolly "),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                height: 60,),
                            ]),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
