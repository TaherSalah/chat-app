import 'package:chat_app/shard/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  String id;
  DateTime createAt;

  MessageModel({required this.message,
    required this.id
    , required this.createAt
  });

  factory MessageModel.fromJson( jsonData) {
    return MessageModel(
      message:    jsonData[kMessage],
      id: jsonData[kId],
      createAt:  (jsonData[kCreatedAt] as Timestamp).toDate(),
    );
  }
}
