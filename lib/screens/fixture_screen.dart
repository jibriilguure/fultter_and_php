import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:kulan_app/model/match_modle.dart';

import '../core/baseurl.dart';
import 'matchDetails.dart';

class FixtureItem extends StatelessWidget {
  final MatchModel match;

  const FixtureItem({required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                child: Image.network(
                  Urls.imgUrlHTeam + match.teamHomeLogo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${match.teamHomeName} vs ${match.teamAwayName}'),
                      // Text(match.matchDate),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                child: Image.network(
                  Urls.imgUrlHTeam + match.teamAwayLogo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FixtureScreen extends StatefulWidget {
  final String? catId;

  const FixtureScreen({Key? key, this.catId}) : super(key: key);
  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  List<MatchModel> matchList = [];
  Future<void> getMatchData() async {
    try {
      var url = Uri.parse(Urls.baseUrl + 'api/horyaal.php?match_api');

      var response = await http.get(
        url,
      );
      final list = json.decode(response.body) as List<dynamic>;
      setState(() {
        matchList = list.map((e) => MatchModel.fromJson(e)).toList();
        if (widget.catId != null) {
          matchList = matchList
              .where((match) => match.horyalka == widget.catId)
              .toList();
        }
      });
    } catch (e) {
      print('Error fetching match data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getMatchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixtures'),
      ),
      body: ListView.builder(
        itemCount: matchList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MatchDetailsScreen(match: matchList[index]),
                  ),
                );
              },
              child: FixtureItem(match: matchList[index]));
        },
      ),
    );
  }
}
