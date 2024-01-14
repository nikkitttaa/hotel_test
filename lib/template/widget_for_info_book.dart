import 'package:flutter/material.dart';

class InfoCountBook extends StatefulWidget {
  const InfoCountBook({super.key, required this.text, required this.count});

  final String text;
  final String count;
  

  @override
  State<InfoCountBook> createState() => _InfoCountBookState();
}

class _InfoCountBookState extends State<InfoCountBook> {

  late String count;
  late String text;

  @override 
  void initState() {
    super.initState();
    text = widget.text;
    count = widget.count;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
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