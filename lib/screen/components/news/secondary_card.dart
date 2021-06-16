import 'package:flutter/material.dart';
import 'package:udafarm/models/model_berita.dart';
import 'package:udafarm/widget/constant.dart';

class SecondaryCard extends StatelessWidget {
  final ModelBerita news;

  const SecondaryCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kGrey3, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 90.0,
            height: 135.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(baseUrl + 'gallery/' + news.foto),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.judul,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kTitleCard,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    news.isi,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kDetailContent,
                  ),
                  Spacer(),
                  Text(
                    'Date: ' + (news.tglBerita).toString().substring(0, 10),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: kDetailContent,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
