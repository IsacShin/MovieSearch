import 'package:flutter/material.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:movieapp/data/movie.dart';

class MovieBoxWidget extends StatelessWidget {
  final Movie movie;

  MovieBoxWidget({Key? key, required this.movie}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white10,
      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 163,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          movie.image.isEmpty ? Image.asset("assets/img/empty.jpeg", width: 110,height: 163,fit: BoxFit.fitHeight,) : Image.network(movie.image,width: 110,height: 163,fit: BoxFit.cover,),
          SizedBox(width: 10,),
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Flexible(
                  child:Text("${HtmlCharacterEntities.decode(movie.title)}(${movie.pubDate})",
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    overflow: TextOverflow.fade,
                  ),
                ),
                SizedBox(height: 15,),
                Text("평점: ${movie.userRating}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),),
                SizedBox(height: 3,),
                Text("감독: ${movie.director}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),),
                SizedBox(height: 3,),
                movie.actor != "" ? Text("출연 배우: ${movie.actor}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15), overflow: TextOverflow.ellipsis,) : Text(""),
              ],
            ),
          )

        ],
      ),
    );
  }
}