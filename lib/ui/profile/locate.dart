import 'dart:ui';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ylc/api/user_api.dart';
import 'package:ylc/keys/sharedpref.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/ui/profile/advocate_profile_tab_view.dart';
import 'package:ylc/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CityModel for cities
class CityModel {
  String sId;
  String id;
  String name;
  String stateId;

  CityModel({this.sId, this.id, this.name, this.stateId});

  CityModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    return data;
  }
}

//StateModel for States
class StateModel {
  String sId;
  String id;
  String name;
  String countryId;

  StateModel({this.sId, this.id, this.name, this.countryId});

  StateModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}

class LocateAdvo extends StatefulWidget {
  @override
  _LocateAdvoState createState() => _LocateAdvoState();
}

class _LocateAdvoState extends State<LocateAdvo> {
  UserModel userModel;
  int cityCount = 0;
  List<StateModel> states = [];
  StateModel selectedState;
  List<CityModel> cities = [];
  List finalThreecities = [];
  CityModel selectedCity;

//Getting states from db
  Future getStateData() async {
    var response =
        await http.get(Uri.https('servermac24.herokuapp.com', 'states'));
    var json = jsonDecode(response.body) as List;
    json.forEach((element) {
      states.add(StateModel.fromJson(element));
    });

    setState(() {});
  }

//Getting cities from db
  Future getCityData() async {
    cities.clear();
    var response2 = await http.get(
        Uri.https('servermac24.herokuapp.com', 'cities/${selectedState.id}'));
    var json2 = jsonDecode(response2.body) as List;
    json2.forEach((element) {
      cities.add(CityModel.fromJson(element));
    });
    setState(() {});
  }

//for adding cities to list

  void finalCities() {
    if (cityCount < 3) {
      finalThreecities.add(selectedCity);
      cityCount++;
      debugPrint('city added');
      debugPrint('$cityCount');
    } else {
      debugPrint('maximum service cities are three');
    }

    //Saving Data locally using Shares Preferences
    SharedPrefhelper().savelocation1(finalThreecities[0]);
    SharedPrefhelper().savelocation2(finalThreecities[1]);
    SharedPrefhelper().savelocation3(finalThreecities[2]);

    setState(() {});
    //Clearing object data to take next data

    selectedState = null;
    selectedCity = null;
    getUserDetails();
    //Sending data to database

    if (finalThreecities != null && cityCount == 3) {
      String allCities =
          '${finalThreecities[0]} , ${finalThreecities[0]} , ${finalThreecities[0]}';
      var details =
          userModel.advocateDetails.copyWith(serviceCities: allCities);
      UserApi.updateAdvocateDetails(userModel.id, details);
      Auth.updateUser(userModel.copyWith(advocateDetails: details));
    }
  }

  SharedPref sharedPref = SharedPref();
  String LocName1;
  getUserDetails() async {
    LocName1 = await sharedPref.read('LOCATION1');
  }

  @override
  void initState() {
    super.initState();
    this.getStateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Service Cities'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'First Service State',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),

              //city selection after passing a selected state
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButtonHideUnderline(
                      child: new DropdownButton<StateModel>(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        hint: Text(
                          "Select State",
                        ),
                        value: selectedState,
                        items: states.map((StateModel value) {
                          return new DropdownMenuItem<StateModel>(
                            value: value,
                            child: new Text(
                              value.name,
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          selectedState = val;
                          getCityData();
                        },
                      ),
                    ),
                  ]),
              SizedBox(
                height: 30.0,
              ),

              //city selection based on state
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButtonHideUnderline(
                    child: new DropdownButton<CityModel>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      hint: Text(
                        "Select City",
                      ),
                      value: selectedCity,
                      items: cities.map((CityModel value) {
                        return new DropdownMenuItem<CityModel>(
                          value: value,
                          child: new Text(
                            value.name,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCity = val;
                        });
                      },
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Add City',
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.amber,
                            backgroundColor: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      finalCities();
                    },
                  ),
                ],
              ),
              // Text(LocName1 == null ? "" : LocName1)
              Text('$LocName1')
            ],
          ),
        ));
  }
}

class SharedPrefhelper {
  static String locationOneKey = "LOCATION1";
  static String locationTwoKey = "LOCATION2";
  static String locationThreeKey = "LOCATION3";

  Future<bool> savelocation1(String getLocationOne) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(locationOneKey, getLocationOne);
  }

  Future<bool> savelocation2(String getLocationTwo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(locationTwoKey, getLocationTwo);
  }

  Future<bool> savelocation3(String getLocationThree) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(locationThreeKey, getLocationThree);
  }

  Future<String> getLocationOne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(locationOneKey);
  }

  Future<String> getLocationTwo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(locationTwoKey);
  }

  Future<String> getLocationThree() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(locationThreeKey);
  }
}

// void sendData(){
  

//                         // var result = await openInputDialog(
//                         //   context,
//                           initialValue:
//                               userModel.advocateDetails?.serviceCities,
//                           hintText: Strings.serviceCityHint,
//                         );
//                         if (result != null) {
//                           var details = userModel.advocateDetails
//                               .copyWith(serviceCities: result);
//                           UserApi.updateAdvocateDetails(userModel.id, details);
//                           Auth.updateUser(
//                               userModel.copyWith(advocateDetails: details));
//                         }
//                       }
//                     : null,
              
// }

