import 'package:flutter/material.dart';
import 'package:udafarm/models/model_kamus.dart';
import 'package:udafarm/widget/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PageDictionary extends StatefulWidget {
  const PageDictionary({Key? key}) : super(key: key);

  @override
  _PageDictionaryState createState() => _PageDictionaryState();
}

class _PageDictionaryState extends State<PageDictionary> {
  // Model
  List<ModelKamus?> _list = [];
  List<ModelKamus?> _search = [];

  String msg = "", title = "";

  TextEditingController controller = TextEditingController();

  var loading = false;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });

    final response = await http.get(Uri.parse(baseUrl + "get_kamus.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(
        () {
          for (Map i in data) {
            _list.add(ModelKamus.fromJson(i));
            loading = false;
          }
        },
      );
    }
  }

  onSearch(String text) async {
    _search.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      // kolom apa yang akan kita cari (misal judul)
      if (f!.judul.toLowerCase().contains(text.toLowerCase())) _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: _search.length != 0 || controller.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: _search.length,
                            itemBuilder: (context, i) {
                              final b = _search[i];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      b!.judul,
                                      style: kTitleCard.copyWith(
                                          color: kPrimaryColor),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        print('press');
                                      },
                                      child: Icon(
                                        Icons.keyboard_tab_rounded,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (content, i) {
                              final a = _list[i];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      a!.judul,
                                      style: kTitleCard.copyWith(
                                          color: kPrimaryColor),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        print('press');
                                      },
                                      child: Icon(
                                        Icons.keyboard_tab_rounded,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  // _showDialog(msg, title) {
  //   slideDialog.showSlideDialog(
  //     context: context,
  //     child: Container(
  //       padding: EdgeInsets.all(20),
  //       child: Column(
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(
  //             height: 10.0,
  //           ),
  //           Text(
  //             msg,
  //             style: TextStyle(fontSize: 17),
  //           ),
  //         ],
  //       ),
  //     ),
  //     barrierColor: Colors.white.withOpacity(0.7),
  //     pillColor: Colors.red,
  //     backgroundColor: kGrey3,
  //   );
  // }
}
