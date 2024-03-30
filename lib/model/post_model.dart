class PostModel {
  late final String id;
  late final String title;
  late final String image;
  late final String body;
  late final String date;
  late final String catId;
  late final String categoryName;

  PostModel({
    required this.id,
    required this.title,
    required this.image,
    required this.body,
    required this.categoryName,
    required this.date,
    required this.catId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        body: json['body'],
        date: json['date'],
        categoryName: json['cat_title'],
        catId: json['cat_id'],
      );
}
