import 'package:flutter/material.dart';

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
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Align(
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
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                      'World Hello World World Hello WorldWorld Hello WorldWorld Hello WorldWorld Hello World'),
                ),
              ),
            );
          },
        ));
  }
}
