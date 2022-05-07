class Movie {
  String title;
  String link;
  String image;
  String subtitle;
  String pubDate;
  String director;
  String actor;
  String userRating;

  Movie({
    required this.title,
    required this.link,
    required this.image,
    required this.subtitle,
    required this.pubDate,
    required this.director,
    required this.actor,
    required this.userRating
  });

  // api 데이터를 받아서 객체로 만들어주는 역할
  factory Movie.fromJson(Map<String, dynamic> data) {
    return Movie(
      title: data["title"] ?? "",
      link: data["link"] ?? "",
      image: data["image"] ?? "",
      subtitle: data["subtitle"] ?? "",
      pubDate: data["pubDate"] ?? "",
      director: data["director"] ?? "",
      actor: data["actor"] ?? "",
      userRating: data["userRating"] ?? ""
    );
  }

}