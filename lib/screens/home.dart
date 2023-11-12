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
    List<MessageModel>messageList=[];
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black,
                title:defAppBar(),
              ),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    ImagesPath.whatsBg,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  ListView.builder(
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
                  TextFormField(
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
                        suffixIcon: IconButton(
                            onPressed: () async {},
                            icon: const Icon(Icons.schedule_send_outlined,
                                size: 30)),
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
  }


  }

