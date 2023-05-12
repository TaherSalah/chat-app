import 'package:flutter/material.dart';

import '../shard/widget/chat_buple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
              onChanged: (va) {
                print(va);
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.schedule_send_outlined, size: 30)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25)),
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10))),
            )
          ],
        ));
  }
}
