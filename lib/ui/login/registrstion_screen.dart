import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ylc/api/collection_ref.dart';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/services/upload_service.dart';
import 'package:ylc/ui/onboarding/upload_documents.dart';
import 'package:ylc/ui/profile/locate.dart';
import 'package:http/http.dart' as http;

import 'attachments_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';
  final UserModel model;


  RegistrationScreen({this.model});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String _image;
  final ImagePicker _picker = ImagePicker();

  DateTime selectedDate = DateTime(2000);
  final _officeFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _adharCartFocusNode = FocusNode();
  List<String> servicesCities;
  String _date;
  File _pickedImage;
  int cityCount = 0;
  List<StateModel> states = [];
  StateModel selectedState;
  List<CityModel> cities = [];
  List finalThreecities = [];
  CityModel selectedCity;
  var _cities;

  List<CityModel> cityList = [];

  @override
  void initState() {
    this.getStateData();
    super.initState();
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    _image = _pickedImage.path;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2010));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print('${picked.millisecondsSinceEpoch} picked date');
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _date = picked.millisecondsSinceEpoch.toString();
        _dateController.text = date;
      });
  }

  Future<void> _saveForm(
    String state,
    String address,
    String city,
    int date,
  ) async {
    String userId = Provider.of<UserModel>(context, listen: false).id;

    final url = await UploadService.uploadImageToFirebase(_pickedImage);

    AdditionalDetails details = AdditionalDetails(
      dateOfBirth: date,
      state: state,
      address: address,
      city: city,
    );
      String selected= '' ;
      cityList.forEach((element) {

        selected += element.name +', ';
      });
      print(selected);
    try {
      var result = await UserApi.updateAdditionalDetails(userId, details);
      AdvocateDetails detail = AdvocateDetails(
        serviceCities: selected,
      );
      await UserApi.updateAdvocateDetails(userId, detail);
      await UserApi.updatePhoto(userId, url);

      final isValid = _form.currentState.validate();
      if (!isValid || result == null) {
        return;
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UploadDocuments()));

      print(result.message);
    } on Exception catch (e) {
      print(e);
      // TODO
    }
  }

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

    _cities = cities
        .map((city) => MultiSelectItem<CityModel>(city, city.name))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(),
        actions: [
          IconButton(
            icon: Image.asset('images/LOGO.png'),
            onPressed: () {},
            iconSize: 70,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage)
                        : NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPuk1ANhAl5pGnajh1J2Jk83E0kVXsJtUy7Q&usqp=CAU'),
                  ),
                ),
              ),
              Form(
                key: _form,
                child: Expanded(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            onSaved: (value) {
                              print(value);
                            },
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: "Date of Birth",
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please enter a date for your task";
                              return null;
                            },
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Address'),
                        controller: _addressController,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _addressFocusNode,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter an address';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_adharCartFocusNode);
                        },
                      ),
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
                      Divider(),
                      MultiSelectDialogField(
                        items: _cities,
                        title: Text("Services Cities"),
                        selectedColor: Colors.blue,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        buttonIcon: Icon(
                          Icons.location_city,
                          color: Colors.blue,
                        ),
                        buttonText: Text(
                          "Services Cities",
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          //_selectedAnimals = results;
                          cityList =  List<CityModel>.from(results);
                                                },
                      ),
                    ],
                  ),
                ),
              ),
              FlatButton(
                child: Text("Submit"),
                textColor: Colors.white,
                color: Colors.blueAccent,
                onPressed: () {
                  _saveForm(
                      selectedState.name,
                      _addressController.text,
                      cityList.first.name,
                      Timestamp.fromDate(DateFormat('d/M/yyyy')
                              .parse(_dateController.text))
                          .millisecondsSinceEpoch);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MultiSelectInput extends StatefulWidget {
  const MultiSelectInput({
    Key key,
    @required this.cityList,
  }) : super(key: key);

  final List<CityModel> cityList;

  @override
  _MultiSelectInputState createState() => _MultiSelectInputState();
}

class _MultiSelectInputState extends State<MultiSelectInput> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {},
      child: ChipsInput(
        initialValue: [],
        decoration: InputDecoration(
          labelText: "Services Cities",
        ),
        maxChips: 3,
        findSuggestions: (String query) {
          if (query.length != 0) {
            var lowercaseQuery = query.toLowerCase();
            return widget.cityList.where((profile) {
              return profile.name.toLowerCase().contains(query.toLowerCase());
            }).toList(growable: false)
              ..sort((a, b) => a.name
                  .toLowerCase()
                  .indexOf(lowercaseQuery)
                  .compareTo(b.name.toLowerCase().indexOf(lowercaseQuery)));
          } else {
            return const <Text>[];
          }
        },
        onChanged: (data) {
          setState(() {
            print('${data.join(', ')}');
          });
        },
        allowChipEditing: true,
        chipBuilder: (context, state, profile) {
          return InputChip(
            key: ObjectKey(profile),
            label: profile,
            onDeleted: () => state.deleteChip(profile),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
        suggestionBuilder: (context, state, profile) {
          return ListTile(
            key: ObjectKey(profile),
            title: profile,
            subtitle: profile,
            onTap: () => state.selectSuggestion(profile),
          );
        },
      ),
    );
  }
}
