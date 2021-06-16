import 'package:flutter/material.dart';
import 'package:udafarm/models/model_kamus.dart';
import 'package:udafarm/widget/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:udafarm/widget/custom_circular_progress.dart';

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
              padding: EdgeInsets.all(5.0),
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
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: CustomCircular(),
                  )
                : Expanded(
                    child: _search.length != 0 || controller.text.isNotEmpty
                        ? _performSearch()
                        : _createSearchView(),
                  ),
          ],
        ),
      ),
    );
  }

  ListView _performSearch() {
    return ListView.builder(
      itemCount: _search.length,
      itemBuilder: (context, i) {
        final b = _search[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Card(
            child: ExpansionTile(
              title: Text(
                b!.judul,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                ListTile(
                  title: Text(b.isi),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
    );
  }

  ListView _createSearchView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: _list.length,
      itemBuilder: (content, i) {
        final a = _list[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Card(
            child: ExpansionTile(
              title: Text(
                a!.judul,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                ListTile(
                  title: Text(a.isi),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}
