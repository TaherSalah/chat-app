import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/shard/widget/images_path.dart';
import 'package:chat_app/shard/widget/test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatBubblesForMe extends StatefulWidget {
  final MessageModel messageModel;
  DateTime now = DateTime.now();

   ChatBubblesForMe({super.key, required this.messageModel});




  @override
  State<ChatBubblesForMe> createState() => _ChatBubblesForMeState();
}
class _ChatBubblesForMeState extends State<ChatBubblesForMe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(

                  widget.messageModel.id,

                  style:  GoogleFonts.acme(color: Colors.white, fontSize: 10),
                ),

                Text(

                  widget.messageModel.message,

                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(height: 10,),
                Text(
                  ///// for create formate date and time in chat bubbles ////////
                 DateFormat.yMMMd().add_jm().format(DateTime.parse('${widget.messageModel.createAt}')),
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 10),
                ),

              ],
            ),
          ),
        ),
        CustomPaint(painter: Triangle(Colors.black)),
        Image.network(ImagesPath.firstUser,height: 50,width: 50,),

      ],
    );
  }
}
