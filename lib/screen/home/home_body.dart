import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:udafarm/models/model_berita.dart';
import 'package:udafarm/screen/components/news/image_slider.dart';
import 'package:udafarm/widget/constant.dart';
import 'package:udafarm/widget/custom_circular_progress.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<ModelBerita> listBerita = [];
  var loading = false;

  Future<List?> getData() async {
    setState(() {
      loading = true;
    });

    final responseData = await http.get(Uri.parse(baseUrl + 'get_berita.php'));

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data) {
          listBerita.add(ModelBerita.fromJson(i));
        }

        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loading
            ? Center(
                child: CustomCircular(),
              )
            : ImageSlider(listBerita: listBerita));
  }
}
