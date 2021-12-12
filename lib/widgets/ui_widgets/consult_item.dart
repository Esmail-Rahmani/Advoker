import 'package:flutter/material.dart';

class ConsultItem extends StatelessWidget {
  final String id;
  final String title;
  final String time;
  final double price;
  final String date;
  final String description;

  ConsultItem(
      this.id, this.title, this.time, this.price, this.date, this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
        Divider(),
        Row(
          children: [
            Spacer(),
            Icon(Icons.monetization_on_rounded , color: Colors.purple,),
            Text(price.toString()),
            Spacer(),
            Icon(Icons.access_time_outlined,color: Colors.purple,),
            Text(time),
            Spacer(),
          ],
        ),
        Container(
            padding: EdgeInsets.all(6),
            child: Text(description ,style: TextStyle(
              color: Colors.grey[700]
            ),)),
        Divider(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Text('Book $title')),
      ],
    );
  }
}
