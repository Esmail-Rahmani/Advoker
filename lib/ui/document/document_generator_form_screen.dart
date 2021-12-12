import 'package:flutter/material.dart';

import 'generated_screen.dart';

class DocumentGeneratorFormScreen extends StatefulWidget {
  static const routeName = '/document-generator-form';

  const DocumentGeneratorFormScreen({Key key}) : super(key: key);

  @override
  _DocumentGeneratorFormScreenState createState() =>
      _DocumentGeneratorFormScreenState();
}

class _DocumentGeneratorFormScreenState
    extends State<DocumentGeneratorFormScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _mother_nameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _adharCartFocusNode = FocusNode();

  var initVar = {
    // 'image':''
    'name': '',
    'date': '',
    'address': '',
    'father_name': '',
    'mother_name': []
  };

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    Navigator.of(context).pushNamed(GeneratedScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    String title = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
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
              Form(
                key: _form,
                child: Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill your full name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': value,
                            'date': initVar['date'],
                            'address': initVar['address'],
                            'father_name': initVar['father_name'],
                            'mother_name': initVar['mother_name']
                          };
                        },
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            onSaved: (value) {
                              initVar = {
                                // 'image':''
                                'name': value,
                                'date': initVar['date'],
                                'address': initVar['address'],
                                'father_name': initVar['father_name'],
                                'mother_name': initVar['mother_name']
                              };
                            },
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: "Date",
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
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _addressFocusNode,
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': initVar['name'],
                            'date': initVar['date'],
                            'address': value,
                            'father_name': initVar['father_name'],
                            'mother_name': initVar['mother_name']
                          };
                        },
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
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Father Name'),
                        textInputAction: TextInputAction.next,
                        focusNode: _adharCartFocusNode,
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': initVar['name'],
                            'date': initVar['date'],
                            'address': initVar['address'],
                            'father_name': value,
                            'mother_name': initVar['mother_name']
                          };
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter A Name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_mother_nameFocusNode);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Mother Name'),
                        textInputAction: TextInputAction.next,
                        focusNode: _mother_nameFocusNode,
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': initVar['name'],
                            'date': initVar['date'],
                            'address': value,
                            'father_name': initVar['father_name'],
                            'mother_name': initVar['mother_name']
                          };
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter a Name';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FlatButton(
                      child: Text("Clear"),
                      textColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          _form.currentState.reset();
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all( width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FlatButton(
                      child: Text("Generating"),
                      textColor: Colors.white,
                      onPressed: () {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
