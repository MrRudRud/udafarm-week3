import 'package:flutter/material.dart';
import 'package:udafarm/models/model_berita.dart';
import 'package:udafarm/screen/components/news/details_news_view.dart';
import 'package:udafarm/screen/components/news/primary_card.dart';
import 'package:udafarm/screen/components/news/secondary_card.dart';
import 'package:udafarm/widget/constant.dart';

class ImageSlider extends StatelessWidget {
  final List<ModelBerita> listBerita;

  const ImageSlider({
    Key? key,
    required this.listBerita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.only(left: 5.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: listBerita.length,
                itemBuilder: (context, index) {
                  var news = listBerita[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailNewsView(news: news)),
                      );
                    },
                    child: PrimaryCard(news: news),
                  );
                }),
          ),
          SizedBox(height: 25.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text(
                "BASED ON YOUR READING HISTORY",
                style: kNonActiveTabStyle,
              ),
            ),
          ),
          ListView.builder(
            itemCount: listBerita.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var news = listBerita[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailNewsView(news: news),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 135.0,
                  margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: SecondaryCard(news: news),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
