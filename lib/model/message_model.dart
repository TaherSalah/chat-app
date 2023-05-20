import 'package:chat_app/shard/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  // DateTime createAt;

  MessageModel({required this.message
    // , required this.createAt
  });

  factory MessageModel.fromJson( jsonData) {
    return MessageModel(
      message:    jsonData[kMessage],
      // createAt:  (jsonData[kCreatedAt] as Timestamp).toDate(),
    );
  }
}
