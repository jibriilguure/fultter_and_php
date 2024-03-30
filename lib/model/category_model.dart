class PostCatModel {
  late final String catId;

  late final String catTitle;
  //late final String postId;

  PostCatModel({
    required this.catId,
    required this.catTitle,
    // required this.postId,
  });

  factory PostCatModel.fromJson(Map<String, dynamic> json) => PostCatModel(
        catId: json['cat_id'],
        catTitle: json['cat_title'],
        // postId: json['post_id'],
      );
}
