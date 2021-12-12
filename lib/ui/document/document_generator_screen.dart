import 'package:flutter/material.dart';

import 'document_generator_form_screen.dart';

class DocumentGeneratorScreen extends StatelessWidget {
  static const routeName = '/document-generator-screen';
  const DocumentGeneratorScreen({Key key}) : super(key: key);

  Widget buildTitleText(BuildContext context, String title) {
    return GestureDetector(
      onTap: (){
      Navigator.of(context).pushNamed(DocumentGeneratorFormScreen.routeName, arguments: title);
      },
      child: Container(
        padding: EdgeInsets.all(18),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document generator' ,),
      ),
      body: Column(
        children: [
          buildTitleText(context, 'Noc Sound'),
          Divider(),
          buildTitleText(context, 'Divorce Application'),
          Divider(),
          buildTitleText(context, 'Death Certificate'),
          Divider(),
          buildTitleText(context, 'Affidavit for rent'),
          Divider(),
          buildTitleText(context, 'Sale Deed'),
          Divider(),
        ],
      ),
    );
  }
}
