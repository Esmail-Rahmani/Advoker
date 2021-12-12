
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylc/providers/advocates.dart';
import 'package:ylc/widgets/ui_widgets/consult_item.dart';

class ConsultScreen extends StatelessWidget {
  static const routeName = '/consult';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
   // final advocate = Provider.of<Advocates>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: Text('name here' , style: Theme.of(context).textTheme.headline6,)),
            Divider(),
            ConsultItem(DateTime.now().toString(),"Message Consultation",
                '2 Hours',720, DateTime.now().toString(), 'send and receive multiple messages'),
            Divider(),
            ConsultItem(DateTime.now().toString(),"Video Consultation",
                '2 Hours',720, DateTime.now().toString(), 'send and receive multiple messages'),
            Divider(),ConsultItem(DateTime.now().toString(),"Voice Consultation",
                '2 Hours',720, DateTime.now().toString(), 'send and receive multiple messages'),
            Divider(),ConsultItem(DateTime.now().toString(),"Offline Consultation",
                '2 Hours',720, DateTime.now().toString(), 'send and receive multiple messages'),
            Divider(),
          ],
        ),
      ),
    );
  }
}
