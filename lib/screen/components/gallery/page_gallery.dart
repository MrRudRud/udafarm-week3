import 'package:flutter/material.dart';
import 'package:udafarm/screen/components/gallery/detail_gallery.dart';
import 'package:udafarm/widget/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PageGallery extends StatelessWidget {
  const PageGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Gallery(),
    );
  }
}

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  Future<List?> fetchGalleryData() async {
    final response = await http.get(Uri.parse(baseUrl + "/get_gallery.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List?>(
        future: fetchGalleryData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) {
                var list = snapshot.data;
                return FeatureImage(
                  index: index,
                  judul: list![index]['judul'],
                  desc: list[index]['descripsi'],
                  fileName: list[index]['namafile'],
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class FeatureImage extends StatelessWidget {
  final String judul;
  final String desc;
  final String fileName;
  final int index;

  const FeatureImage({
    required this.judul,
    required this.desc,
    required this.fileName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: index,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryDetail(
                    gallery: FeatureImage(
                      index: index,
                      judul: judul,
                      desc: desc,
                      fileName: fileName,
                    ),
                  ),
                ),
              );
            },
            child: GridTile(
              footer: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          judul,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: kGrey3,
                          ),
                        ),
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(baseUrl + "gallery/" + fileName),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
