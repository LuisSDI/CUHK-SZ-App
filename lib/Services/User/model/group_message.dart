import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessage{
  String senderId;
  String message;
  FieldValue timeStamp;

  GroupMessage({
    this.senderId,this.message, this.timeStamp
  });

  Map toMap(){
    Map map = Map<String,dynamic>();
    map['senderId'] = this.senderId;
    map['message'] = this.message;
    map['timeStamp'] = this.timeStamp;
    return map;
  }

  GroupMessage fromMap( Map<String,dynamic> map){
    GroupMessage _message = GroupMessage();
    _message.senderId = map['senderId'];
    _message.message = map['message'];
    _message.timeStamp = map['timeStamp'];
    return _message;
  }
}