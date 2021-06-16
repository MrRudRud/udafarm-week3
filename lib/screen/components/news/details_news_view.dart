import 'package:flutter/material.dart';
import 'package:udafarm/models/model_berita.dart';
import 'package:udafarm/widget/circle_button.dart';
import 'package:udafarm/widget/constant.dart';

class DetailNewsView extends StatelessWidget {
  final ModelBerita news;
  const DetailNewsView({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
              child: Row(
                children: [
                  CircleButton(
                    icon: Icons.arrow_back_ios,
                    onTap: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  CircleButton(
                    icon: Icons.share,
                    onTap: () {},
                  ),
                  CircleButton(
                    icon: Icons.favorite_border,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 12.0),
            Hero(
              tag: news.judul,
              child: Container(
                height: 170.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(baseUrl + 'gallery/' + news.foto),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              news.judul,
              style: kTitleCard.copyWith(fontSize: 25.0),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Text('Date: ' + (news.tglBerita).toString().substring(0, 10),
                    style: kDetailContent),
                SizedBox(width: 5.0),
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              news.isi,
              style: descriptionStyle,
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
