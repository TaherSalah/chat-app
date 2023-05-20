import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatBubblesForFrinds extends StatefulWidget {
  final MessageModel messageModel;

  const ChatBubblesForFrinds({super.key, required this.messageModel});

  @override
  State<ChatBubblesForFrinds> createState() => _ChatBubblesForFrindsState();
}

class _ChatBubblesForFrindsState extends State<ChatBubblesForFrinds> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
              margin: const EdgeInsets.only(top: 20, right: 10),
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(widget.messageModel.message),
                leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png')),
                subtitle: Text('${widget.messageModel.createAt}'),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
