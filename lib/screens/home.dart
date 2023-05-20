import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/message_model.dart';
import '../shard/constance.dart';
import '../shard/widget/chat_bubles_for_me.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

CollectionReference userMessage =
    FirebaseFirestore.instance.collection(kMessageCollection);
TextEditingController textEditingController = TextEditingController();
ScrollController scrollController = ScrollController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   var email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: userMessage.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context, snapshot) {
        // ignore: avoid_print
        print(snapshot.data!.docs.length);
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(Icons.messenger_outline),
                  SizedBox(width: 10,),
                  Text('Chat App',style: GoogleFonts.cairo(fontWeight: FontWeight.w500),)
                ],
              ),
              elevation: 10,
            ),
              body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return ChatBuple(
                      messageModel: messageList[index],
                    );
                  },
                ),
              ),
              TextFormField(
                controller: textEditingController,
                onFieldSubmitted: (value) {
                  userMessage.add({
                    ///// 3alshan ab3at data from message to fireStore ///////
                    kMessage: value,
                    ///// 3alshan a3rf order  message in chat ////
                    kCreatedAt: DateTime.now(),
                    kId:email
                  });
                  //// reset the field after submit data ///////
                  scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds:1),
                      curve: Curves.fastOutSlowIn);

                  textEditingController.clear();
                  setState(() {});
                },
                onChanged: (va) {
                  print(va);
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {},
                        icon:
                            const Icon(Icons.schedule_send_outlined, size: 30)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white10))),
              )
            ],
          ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
