import 'package:flutter/material.dart';
import 'package:ylc/widgets/ui_widgets/main_drawer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),

        title: Text('Notification' , style: TextStyle(color: Colors.black),),

      ),
      drawer: MainDrawer(),

      body: Center(
        child: Text('No notification'),
      ),
    );
  }
}
