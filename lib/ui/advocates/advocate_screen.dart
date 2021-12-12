import 'package:ylc/api/user_api.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/ui/consultation/consult_screen.dart';
import 'package:ylc/utils/categoris_list.dart';

import '../../user_config.dart';
import '/providers/advocates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/advocates_bloc.dart';

class AdvocateScreen extends StatefulWidget {
  static const routeName = '/advocate';
  final id;

  AdvocateScreen(this.id);

  @override
  _AdvocateScreenState createState() => _AdvocateScreenState();
}

class _AdvocateScreenState extends State<AdvocateScreen> {
  final AdvocatesBloc bloc = AdvocatesBloc();

  Widget buildCustomText(String text, Color color) {
    return Container(
      padding: color == Colors.black
          ? EdgeInsets.fromLTRB(10, 10, 10, 25)
          : EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.init(
         AppConfig.userId,
        null,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final advocate = Provider.of<Advocates>(context).findById('a1');
    final Future<UserModel> user = UserApi.getUser(uid: widget.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<UserModel>(
          future: user,
          builder: (context, snapshot) {
            return !snapshot.hasData ? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.black,
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        Text(
                          snapshot.data.additionalDetails.state??'Location',
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                             snapshot.data.photo??TEST_IMAGE_URL,

                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            snapshot.data.name,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        if (snapshot.data.advocateDetails.experience != null)
                          Icon(
                            Icons.verified,
                            color: Colors.deepOrange,
                          ),
                        SizedBox(
                          width: 12,
                        ),
                        if (snapshot.data.advocateDetails.experience != null)
                          Text(
                            '${snapshot.data.advocateDetails.experience} yrs experiences ',
                            style: TextStyle(color: Colors.red),
                          ),
                        Spacer(),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('23 reviews', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  Divider(),
                  buildCustomText('Availability', Colors.red),
                  Divider(),
                  Row(
                    children: [
                      buildCustomText(
                        // '${snapshot.data.advocateDetails.availability.join(',')}',
                          'Monday - Saturday',
                          Colors.black),
                      Spacer(),
                      buildCustomText('', Colors.black),
                    ],
                  ),
                  Divider(),
                  buildCustomText('Service Cities', Colors.red),
                  Divider(),
                  buildCustomText(
                      '${snapshot.data.advocateDetails.serviceCities}',
                      Colors.black),
                  Divider(),
                  buildCustomText('Area of Law', Colors.red),
                  Divider(),
                  buildCustomText(
                      '${snapshot.data.advocateDetails.areaOfLaw.join(', ')}',
                      Colors.black),
                  Divider(),
                  buildCustomText('Visiting court', Colors.red),
                  Divider(),
                  buildCustomText(
                      '${snapshot.data.advocateDetails.visitingCourt}',
                      Colors.black),
                  Divider(),
                  // buildCustomText('Service Cities', Colors.red),
                  // Divider(),
                  // buildCustomText('', Colors.black),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            color:
                                advocate.isFavorite ? Colors.red : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FlatButton(
                            child: Text("Add to Favorite"),
                            textColor: advocate.isFavorite
                                ? Colors.white
                                : Colors.black,
                            onPressed: () {
                              setState(() {
                                advocate.toggleFavoriteStatus();
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FlatButton(
                            child: Text("Consult"),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  ConsultScreen.routeName,
                                  arguments: snapshot.data.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
