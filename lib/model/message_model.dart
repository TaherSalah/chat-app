import 'package:chat_app/shard/constance.dart';

class MessageModel {
  String message;

  MessageModel(this.message);

  factory MessageModel.fromJson( jsonData) {
    return MessageModel(jsonData[kMessage]);
  }
}
