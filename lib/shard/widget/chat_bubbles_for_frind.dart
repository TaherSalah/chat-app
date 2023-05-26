import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/shard/widget/images_path.dart';
import 'package:chat_app/shard/widget/triangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatBubblesForFrinds extends StatefulWidget {
  final MessageModel messageModel;

  const ChatBubblesForFrinds({super.key, required this.messageModel});

  @override
  State<ChatBubblesForFrinds> createState() => _ChatBubblesForFrindsState();
}

class _ChatBubblesForFrindsState extends State<ChatBubblesForFrinds> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          ImagesPath.lastUser,
          width: 50,
          height: 50,
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(5),
          child: CustomPaint(
            painter: Triangle(Colors.grey.shade300),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.messageModel.message,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ///// for create formate date and time in chat bubbles ////////
                  DateFormat.yMMMd().add_jm().format(
                      DateTime.parse('${widget.messageModel.createAt}')),
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
