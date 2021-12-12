
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/providers/advocates.dart';
import 'package:ylc/ui/advocates/advocate_screen.dart';

class CategoryAdvocatesItem extends StatelessWidget {
  static const routeName = '/advocate';
  final String name;
  final String imageUrl;
  final bool favorite;
  final String location;
  final int reviews;
  final int experince;
  final String id;


  CategoryAdvocatesItem(
      {this.name,
      this.imageUrl,
      this.favorite,
      this.location,
      this.reviews,
      this.experince,
      this.id});

  void selectAdvocate(ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (context) => AdvocateScreen(id)));
  }

  @override
  Widget build(BuildContext context) {
    // final advocate = Provider.of<Advocates>(context).findById(id);

    return Scaffold(
        body: InkWell(
      onTap: () => selectAdvocate(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                favorite ?
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: IconButton(
                        icon: Icon(
                          favorite ? Icons.star : Icons.star_border,
                        ),
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    ),
                  ): Text(''),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Text(
                    '${location}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Row(
                    children: [
                      Icon(Icons.verified , color:Colors.deepOrange,),
                      SizedBox(width: 12,),
                      Text(
                        '${experince} yrs experiences ',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star , color:Colors.deepOrange,),
                      SizedBox(width: 8,),
                      Text('${reviews} reviews',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
