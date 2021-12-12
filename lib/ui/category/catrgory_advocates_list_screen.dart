
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylc/providers/advocates.dart';
import 'package:ylc/widgets/ui_widgets/category_advocates_item.dart';

class CategoryAdvocatesListScreen extends StatelessWidget {
  static const routeName = '/category-advocates-list';

  // advocateListByCategoryId

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = args['id'];
    final title = args['title'];
    final list = Provider.of<Advocates>(context).advocateListByCategoryId(id);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(child: Text(title ,)),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.search , size: 30,)),
        ],
      ),
      body:
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  return Container(
                      // height:170,child: CategoryAdvocatesItem(list[i].id)
                  );
                }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.filter_alt),
      ),
    );
  }
}
