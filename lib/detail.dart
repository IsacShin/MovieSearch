import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String value;
  const DetailWidget({Key? key, required this.value}): super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(value),
      ),
    );
  }
}