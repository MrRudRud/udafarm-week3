import 'package:flutter/material.dart';
import 'package:udafarm/screen/components/gallery/page_gallery.dart';
import 'package:udafarm/widget/circle_button.dart';
import 'package:udafarm/widget/constant.dart';

class GalleryDetail extends StatelessWidget {
  final FeatureImage gallery;

  const GalleryDetail({required this.gallery});

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
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Hero(
              tag: gallery.judul,
              child: Container(
                height: 170.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image:
                        NetworkImage(baseUrl + 'gallery/' + gallery.fileName),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 17.0),
            Text(
              gallery.judul,
              style: kTitleCard.copyWith(fontSize: 25.0),
            ),
            SizedBox(height: 10.0),
            Text(
              gallery.desc,
              style: descriptionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
