import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/baseurl.dart';
import '../model/horyaal.dart';
import 'fixture_screen.dart'; // Import the fixture screen file

class CategoryListScreen extends StatefulWidget {
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<HoryaalCatModel> horyaalCatList = [];

  Future<void> getHoryaalCatData() async {
    try {
      var url = Uri.parse(Urls.baseUrl + 'api/horyaal.php?horyaal_cat');

      var response = await http.get(url);
      final list = json.decode(response.body) as List<dynamic>;
      setState(() {
        horyaalCatList = list.map((e) => HoryaalCatModel.fromJson(e)).toList();
      });
    } catch (e) {
      print('Khalad ka jira HORYAAL CAT PAGE: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getHoryaalCatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: horyaalCatList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    Urls.imgUrlHoryaal + horyaalCatList[index].image),
              ),
              title: Text(horyaalCatList[index].title),
              onTap: () {
                // Navigate to the fixture screen with the selected category ID
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FixtureScreen(
                      catId: horyaalCatList[index].id,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
