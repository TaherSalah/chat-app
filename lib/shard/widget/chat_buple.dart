import 'package:flutter/material.dart';

class ChatBuple extends StatefulWidget {
  const ChatBuple({Key? key}) : super(key: key);

  @override
  State<ChatBuple> createState() => _ChatBupleState();
}

class _ChatBupleState extends State<ChatBuple> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 10),
        decoration: const BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(15))),
        padding: const EdgeInsets.all(10),
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
              'World Hello WorldWorld Hello World'),
        ),
      ),
    );
  }
}
