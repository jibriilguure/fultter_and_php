class HoryaalCatModel {
  late final String id;

  late final String title;
  late final String image;
  late final String startDate;
  late final String endDate;

  HoryaalCatModel({
    required this.id,
    required this.title,
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  factory HoryaalCatModel.fromJson(Map<String, dynamic> json) =>
      HoryaalCatModel(
        id: json['id'],
        title: json['title'],
        image: json['img'],
        startDate: json['start_date'],
        endDate: json['end_date'],
      );
}
