import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubblesForMe extends StatefulWidget {
  final MessageModel messageModel;

  const ChatBubblesForMe({super.key, required this.messageModel});


  @override
  State<ChatBubblesForMe> createState() => _ChatBubblesForMeState();
}
class _ChatBubblesForMeState extends State<ChatBubblesForMe> {
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
        child:  ListTile(
          trailing: Text('${widget.messageModel.createAt}'),
          title: Text(widget.messageModel.message),
          leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png')),
          subtitle: Text(widget.messageModel.id),
        )),
      ),


        SizedBox(height: 10,),

      ],
    );
  }
}
