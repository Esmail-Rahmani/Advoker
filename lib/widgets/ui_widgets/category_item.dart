
import 'package:flutter/material.dart';
import 'package:ylc/ui/category/catrgory_advocates_list_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;


  CategoryItem(this.id, this.title, this.imageUrl);

  void selectCategory(ctx){
    Navigator.of(ctx).pushNamed(
        CategoryAdvocatesListScreen.routeName,arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(imageUrl , height: 70,),
            FittedBox(
              child: Text(title , style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black,),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
