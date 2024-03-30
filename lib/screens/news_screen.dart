import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/baseurl.dart';
import '../model/category_model.dart';
import '../model/post_model.dart';

import 'list_cat_news.dart';
import 'post_detail.dart';

class PostListScreen extends StatefulWidget {
  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<PostModel>> postDataFuture;
  late Future<List<PostCatModel>> postCatDataFuture;

  @override
  void initState() {
    super.initState();
    postDataFuture = getPostData();
    postCatDataFuture = getPostCatData();
  }

  Future<List<PostModel>> getPostData() async {
    try {
      var url = Uri.parse(Urls.baseUrl + 'api/post.php?post_api');
      var response = await http.get(url);
      final list = json.decode(response.body) as List<dynamic>;
      return list.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching post data: $e');
      throw e;
    }
  }

  Future<List<PostCatModel>> getPostCatData() async {
    try {
      var url = Uri.parse('${Urls.baseUrl}api/post.php?post_cat');
      var response = await http.get(url);
      final list = json.decode(response.body) as List<dynamic>;
      return list.map((e) => PostCatModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching category data: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: postDataFuture,
        builder: (context, postDataSnapshot) {
          if (postDataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (postDataSnapshot.hasError) {
            return Center(child: Text('Error: ${postDataSnapshot.error}'));
          } else {
            List<PostModel> postDataList = postDataSnapshot.data!;
            return FutureBuilder<List<PostCatModel>>(
              future: postCatDataFuture,
              builder: (context, postCatSnapshot) {
                if (postCatSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (postCatSnapshot.hasError) {
                  return Center(child: Text('Error: ${postCatSnapshot.error}'));
                } else {
                  List<PostCatModel> postCatDataList = postCatSnapshot.data!;
                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: postCatDataList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  List<PostModel> filteredPosts = postDataList
                                      .where((post) =>
                                          post.catId ==
                                          postCatDataList[index].catId)
                                      .toList();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryPostListScreen(
                                              posts: filteredPosts),
                                    ),
                                  );
                                },
                                child: Chip(
                                  label: Text(postCatDataList[index].catTitle),
                                  backgroundColor: Colors.blue,
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: postDataList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailsScreen(
                                        post: postDataList[index]),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ListTile(
                                  leading: Image.network(
                                    Urls.imgUrl + postDataList[index].image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(postDataList[index].title),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(postDataList[index].categoryName),
                                      Text('Date: ${postDataList[index].date}'),
                                      // Text('Category: ${postDataList[index].categoryName}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
