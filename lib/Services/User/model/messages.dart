import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String senderId;
  String receiverId;
  String message;
  FieldValue timeStamp;

  Message({
    this.senderId,this.receiverId,this.message, this.timeStamp
});

  Map toMap(){
    Map map = Map<String,dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['message'] = this.message;
    map['timeStamp'] = this.timeStamp;
    return map;
  }

  Message fromMap( Map<String,dynamic> map){
    Message _message = Message();
    _message.senderId = map['senderId'];
    _message.receiverId = map['receiverId'];
    _message.message = map['message'];
    _message.timeStamp = map['timeStamp'];
    return _message;
  }
}