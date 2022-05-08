import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:movieapp/data/api.dart';
import 'package:movieapp/data/movie.dart';
import 'package:movieapp/data/rank.dart';
import 'package:movieapp/detail.dart';
import 'package:movieapp/commons/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
        home: const MyHomePage(title: 'Movie Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late SearchBar searchBar;

  List<Movie> data = [];
  List<Rank> rank = [];

  _getFirstData(String keyword) async {
    CommonApi api = CommonApi();
    data = await api.getMovieData(keyword);
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailWidget(data: data)));
    });
  }

  _getRankData() async {
    CommonApi api = CommonApi();
    DateTime dateTime = DateTime.now().subtract(Duration(days:1));
    String date = Utils.getFormatTime(dateTime).toString();
    rank = await api.getBoxOffice(date);
    setState(() {});
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('Movie Search'),
        actions: [searchBar.getSearchAction(context)]
    );
  }

  void onSubmitted(String value) {
    setState(() {
      var context = _scaffoldKey.currentContext;

      if (context == null) {
        return;
      }
      _getFirstData(value);
    });
  }

  _MyHomePageState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("Search bar has been cleared");
        },
        onClosed: () {
          print("Search bar has been closed");
        },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRankData();
  }

  Icon getRankIcon(int rInten) {
    if(rInten > 0) {
      return Icon(Icons.upload,color: Colors.red,);
    } else if (rInten < 0) {
      return Icon(Icons.download,color: Colors.blue);
    } else {
      return Icon(null);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("일일 박스오피스", style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: List.generate(rank.length, (idx){
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(children: [
                    Text("${rank[idx].rank}. ${rank[idx].movieNm}",style: TextStyle(fontSize: 15, fontStyle: FontStyle.normal)),
                    getRankIcon(int.parse(rank[idx].rankInten))
                  ],),
                );
              }),
            )
          ],
        ),
      )
    );
  }
}
