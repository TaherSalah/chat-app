import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../shard/constance.dart';
import '../shard/widget/chat_buple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

CollectionReference userMessage =
    FirebaseFirestore.instance.collection(kMessageCollection);

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white12,
          title: const Row(
            children: [
              Icon(Icons.chat),
              SizedBox(
                width: 10,
              ),
              Text('Chat App')
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ChatBuple();
                },
              ),
            ),
            TextFormField(
              onFieldSubmitted: (value) {
                userMessage.add({
                  'message': value,
                });
              },
              onChanged: (va) {
                print(va);
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        AssetsAudioPlayer.newPlayer().open(
                          Audio("assets/sound/001.mp3"),
                          showNotification: true,
                        );
                        setState(() {});
                      },
                      icon: const Icon(Icons.schedule_send_outlined, size: 30)),
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
