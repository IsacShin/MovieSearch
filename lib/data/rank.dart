class Rank {
  String rank;
  String rankInten;
  String movieNm;

  Rank({
    required this.rank,
    required this.rankInten,
    required this.movieNm,

  });

  // api 데이터를 받아서 객체로 만들어주는 역할
  factory Rank.fromJson(Map<String, dynamic> data) {
    return Rank(
        rank: data["rank"] ?? "",
        rankInten: data["rankInten"] ?? "",
        movieNm: data["movieNm"] ?? "",
    );
  }

}