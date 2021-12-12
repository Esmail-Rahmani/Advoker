import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:ylc/utils/news_list.dart';

class NewsItem extends StatefulWidget {
  final String id;

  NewsItem(this.id);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    final news = NEWS_LIST.firstWhere((element) => element.id == widget.id);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // elevation: 4,
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              news.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Stack(
          //   children: [
          //
          //     Positioned(
          //       top: 0,
          //       right: 0,
          //       child: Container(
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle, color: Colors.black),
          //         child: IconButton(
          //           icon: Icon(
          //             advocate.isFavorite ? Icons.star : Icons.star_border,
          //           ),
          //           color: Colors.blue,
          //           onPressed: () {
          //             advocate.toggleFavoriteStatus();
          //             setState(() {
          //
          //             });
          //           },
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              news.title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ReadMoreText(
              news.newsText,
              style: TextStyle(color: Colors.black),
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',

            ),
          ),
        ],
      ),
    );
  }
}
