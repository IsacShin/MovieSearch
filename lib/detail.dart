import 'package:flutter/material.dart';
import 'package:movieapp/data/movie.dart';
import 'package:movieapp/webview.dart';
import 'package:movieapp/widgets/moviebox.dart';

class DetailWidget extends StatelessWidget {
  final List<Movie> data;

  const DetailWidget({Key? key, required this.data}): super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: data.isEmpty ? const Center(
        child: Text("검색하신 영화정보가 없습니다.", style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),)
      ) : ListView(
        //padding: EdgeInsets.fromLTRB(0, 16, 0, 45),
        children: List.generate(data.length, (idx){
          return InkWell(
            child:MovieBoxWidget(movie: data[idx],),
            onTap: () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewWidget(linkUrl: data[idx].link)));
            },
          );
        }),
      )
    );
  }
}