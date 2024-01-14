// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';


class InfoBook extends StatelessWidget {
  String text;
  String count;
  
  InfoBook({
    Key? key,
    required this.text,
    required this.count,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width/20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width/2.7,
            child: Text(text, style: const TextStyle( fontSize: 16, color: Color.fromARGB(1000, 130, 135, 150)),)),
          Flexible(
            child: Text(count, style: const TextStyle( fontSize: 16,), softWrap: true,)
            ),
        ],
      ),
    );
  }
}
