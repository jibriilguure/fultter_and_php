import 'package:flutter/material.dart';
import 'package:kulan_app/screens/post_detail.dart';

import '../core/baseurl.dart';
import '../model/post_model.dart';

class CategoryPostListScreen extends StatelessWidget {
  final List<PostModel> posts;

  const CategoryPostListScreen({Key? key, required this.posts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Posts'),
      ),
      body: posts.isEmpty
          ? Center(
              child: Text('No posts in this category.'),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                PostDetailsScreen(post: posts[index])));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Image.network(
                        Urls.imgUrl + posts[index].image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(posts[index].title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posts[index].categoryName),
                          Text('Date: ${posts[index].date}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
