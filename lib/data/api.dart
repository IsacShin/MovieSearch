import 'dart:convert';

import 'package:movieapp/data/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/data/rank.dart';

class CommonApi {
  final CLIENT_ID = "lsuuj9ha49rrzy5JJN7U";
  final CLIENT_SECRET = "bas4FaRpI5";
  final KEY = "21ff783d67634b7bf1cbef3901cf4957";

  final String URL_GET_MOVIE_DATA = "https://openapi.naver.com/v1/search/movie";
  final String URL_GET_BOXOFFICE = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";

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

  Future<List<Rank>> getBoxOffice(String date) async {
    String url = "$URL_GET_BOXOFFICE?"
        "key=$KEY"
        "&targetDt=$date"
        "&itemPerPage=10";

    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    print(utf8.decode(response.bodyBytes));

    List<Rank> data = [];
    if(response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String,dynamic>;

      for(final _res in res["boxOfficeResult"]["dailyBoxOfficeList"]) {
        final r = Rank.fromJson(_res as Map<String,dynamic>);
        data.add(r);
      }

      return data;
    }else {
      return [];
    }
  }
}