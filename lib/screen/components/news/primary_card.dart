import 'package:flutter/material.dart';
import 'package:udafarm/models/model_berita.dart';
import 'package:udafarm/widget/constant.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  final ModelBerita news;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kGrey3, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: news.idBerita,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(baseUrl + 'gallery/' + news.foto),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              news.judul,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: kTitleCard,
            ),
          ],
        ),
      ),
    );
  }
}
