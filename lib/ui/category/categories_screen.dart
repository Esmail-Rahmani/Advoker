import 'package:flutter/material.dart';
import 'package:ylc/utils/categoris_list.dart';
import 'package:ylc/widgets/ui_widgets/category_item.dart';
class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories-screen';
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
          padding: const EdgeInsets.all(25),
          children: CATEGORIES.map((e)=> CategoryItem(e.id,e.title, TEST_IMAGE_URL)).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          )),
    );
  }
}
