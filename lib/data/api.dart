import 'dart:convert';

import 'package:movieapp/data/movie.dart';
import 'package:http/http.dart' as http;

class CommonApi {
  final CLIENT_ID = "lsuuj9ha49rrzy5JJN7U";
  final CLIENT_SECRET = "bas4FaRpI5";

  final String URL_GET_MOVIE_DATA = "https://openapi.naver.com/v1/search/movie";

  Future<List<Movie>> getMovieData(String keyword) async {
    String url = "$URL_GET_MOVIE_DATA?"
        "query=$keyword"
        "&display=10";
    Uri uri = Uri.parse(url);

    Map<String,String> header = {
      "X-Naver-Client-Id": CLIENT_ID,
      "X-Naver-Client-Secret": CLIENT_SECRET
    };

    final response = await http.get(uri,headers: header);

    print(utf8.decode(response.bodyBytes));

    List<Movie> data = [];
    if(response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String,dynamic>;

      for(final _res in res["items"]) {
        final m = Movie.fromJson(_res as Map<String,dynamic>);
        data.add(m);
      }

      return data;
    }else {
      return [];
    }
  }
}