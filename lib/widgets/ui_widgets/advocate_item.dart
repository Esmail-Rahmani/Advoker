import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/enums/user_mode.dart';
import 'package:ylc/ui/advocates/advocate_screen.dart';
import 'package:ylc/utils/categoris_list.dart';


import './/providers/advocates.dart';

class AdvocateItem extends StatefulWidget {
  final UserModel model;

  AdvocateItem(this.model);


  @override
  _AdvocateItemState createState() => _AdvocateItemState();
}

class _AdvocateItemState extends State<AdvocateItem> {

  void selectAdvocate(ctx, String id) {
    Navigator.push(ctx, MaterialPageRoute(builder: (context) => AdvocateScreen(id)));
  }
  @override
  Widget build(BuildContext context) {
    UserModel user = widget.model;

    return InkWell(
      onTap: () => selectAdvocate(context , user.id),
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // elevation: 4,
        margin: EdgeInsets.all(0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    user.photo?? TEST_IMAGE_URL,
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: IconButton(
                      icon: Icon(
                        user.isVerified ? Icons.star : Icons.star_border,
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(user.name , style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'sofiapro-bold'),),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(1, 10, 1, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${user.advocateDetails.experience??0} yrs exp',
                    style: TextStyle(color: Color.fromARGB(255,245, 130, 98), fontSize: 14),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text('${12} reviews',
                    style: TextStyle(color: Color.fromARGB(255,245, 130, 98), fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
