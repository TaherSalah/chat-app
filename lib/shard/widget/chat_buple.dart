import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';

class ChatBuple extends StatefulWidget {
  final MessageModel messageModel;

  const ChatBuple({super.key, required this.messageModel});


  @override
  State<ChatBuple> createState() => _ChatBupleState();
}
class _ChatBupleState extends State<ChatBuple> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Align(
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
        child:  Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
              widget.messageModel.message),
        ),
      ),

    ),
        SizedBox(height: 10,),
        // Text(
        //   '${widget.messageModel.createAt}'),

      ],
    );
  }
}
