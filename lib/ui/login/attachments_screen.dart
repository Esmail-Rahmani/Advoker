import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../../app.dart';

class AttachmentsScreen extends StatefulWidget {
  static const routeName = '/attachments';

  const AttachmentsScreen({Key key}) : super(key: key);

  @override
  _AttachmentsScreenState createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends State<AttachmentsScreen> {
  String _fileName;
  String _path;
  List<String> _extension = ['jpeg', 'png', 'pdf', 'doc'];

  @override
  void initState() {
    super.initState();
  }

  void _openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);

      print(file.path);
    } else {
      // User canceled the picker
    }
    if (!mounted) return;
    setState(() {
      _fileName = _path != null ? _path.split('/').last : '...';
    });
  }

  Widget buildUploadWidget(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
           _openFileExplorer();
        },
        child: DottedBorder(
          dashPattern: [8],
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          color: Colors.blue,
          strokeWidth: 2,
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.add,
                      size: 32,
                    ),
                  ),
                  title: Text('Upload $text'),
                )),
          ),
        ),
      ),
    );
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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Attachments',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              buildUploadWidget('PanCart'),
              buildUploadWidget('Certificate'),
              buildUploadWidget('License'),
              Spacer(),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                    primary: Colors.black,
                  ),
                  onPressed: saveAttachments,
                  child: Text('Next >',
                  style: TextStyle(
                    fontSize: 16
                  ),),
                ),
              )
            ],
          ),
        ));
  }

  void saveAttachments() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => RootWidget(),
      ),
          (route) => false,
    );
  }
}
