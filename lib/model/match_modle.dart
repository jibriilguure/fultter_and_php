class MatchModel {
  final String matchId;
  final String horyalka;
  final DateTime matchDate;
  final String home;
  final String away;
  final String garoonka;
  final String teamHomeName;
  final String teamAwayName;
  final String teamHomeLogo;
  final String teamAwayLogo;
  final String id;
  final String title;
  final String img;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime time;

  MatchModel({
    required this.matchId,
    required this.horyalka,
    required this.matchDate,
    required this.home,
    required this.away,
    required this.garoonka,
    required this.teamHomeName,
    required this.teamAwayName,
    required this.teamHomeLogo,
    required this.teamAwayLogo,
    required this.id,
    required this.title,
    required this.img,
    required this.startDate,
    required this.endDate,
    required this.time,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchId: json['match_id'],
      horyalka: json['horyalka'],
      matchDate: DateTime.parse(json['match_date']),
      home: json['home'],
      away: json['away'],
      garoonka: json['garoonka'],
      teamHomeName: json['teamHomeName'],
      teamAwayName: json['teamAwayName'],
      teamHomeLogo: json['teamHomeLogo'],
      teamAwayLogo: json['teamAwayLogo'],
      id: json['id'],
      title: json['title'],
      img: json['img'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      time: DateTime.parse(json['time']),
    );
  }
}
