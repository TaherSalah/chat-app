import 'package:chat_app/shard/widget/chat_bubbles_for_frind.dart';
import 'package:chat_app/shard/widget/images_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import '../model/message_model.dart';
import '../shard/constance.dart';
import '../shard/widget/app_bar_widget.dart';
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
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot?>(
      stream: userMessage.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        // ignore: avoid_print
        print(snapshot.data!.docs.length);
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: Colors.amberAccent,));
        } else {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              appBar: AppBar(
                elevation: 20,
                centerTitle: true,
                backgroundColor: Colors.black,
                title: defAppBar(),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.asset(
                            ImagesPath.whatsBg,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          reverse: true,
                          controller: scrollController,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            ////// i check for email id with me return chatBubbleForMe else ChatBubbleForFrinds /////////
                            return messageList[index].id == email
                                ? ChatBubblesForMe(
                                    messageModel: messageList[index],
                                  )
                                : ChatBubblesForFrinds(
                                    messageModel: messageList[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                  const DefFormField()
                ],
              ));
        }
      },
    );
  }
}

class DefFormField extends StatefulWidget {
  const DefFormField({Key? key}) : super(key: key);

  @override
  State<DefFormField> createState() => _DefFormFieldState();
}

class _DefFormFieldState extends State<DefFormField> {
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return TextFormField(
      style: GoogleFonts.cairo(
        color: Colors.white,
      ),
      controller: textEditingController,
      onFieldSubmitted: (value) {
        userMessage.add({
          ///// 3alshan ab3at data from message to fireStore ///////
          kMessage: value,
          ///// 3alshan a3rf order  message in chat ////
          kCreatedAt: DateTime.now(),
          kId: email
        });
        //// reset the field after submit data ///////
        scrollController.animateTo(0,
            duration: const Duration(milliseconds: 1),
            curve: Curves.fastOutSlowIn);

        textEditingController.clear();
        setState(() {});
      },
      onChanged: (va) {
        print(va);
      },
      decoration: InputDecoration(
          //// if u make change fillColor in field should change filled value to true and change fill color //////
          filled: true,
          fillColor: Colors.black,
          suffixIcon: IconButton(
              onPressed: () {
                userMessage.add({
                  ///// 3alshan ab3at data from message to fireStore ///////
                  kMessage: textEditingController.text,
                  ///// 3alshan a3rf order  message in chat ////
                  kCreatedAt: DateTime.now(),
                  kId: email
                });
                //// reset the field after submit data ///////
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.fastOutSlowIn);

                textEditingController.clear();
                setState(() {});
              },
              icon: const Icon(IconBroken.Send, color: Colors.white, size: 30)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(25)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 1))),
    );

  }
}
