class MessageModel{
  late String mesg;
  late String? senderId ;
  late String? receiverId;
  late String? dateTime;

  MessageModel({required this.mesg,this.senderId,this.receiverId,this.dateTime});

  MessageModel.fromjson(Map<String,dynamic>json){
    mesg = json['message'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic>toMap(){
    return {
      'message' : mesg,
      'senderId' : senderId,
      'receiverId' : receiverId,
      'dateTime' : dateTime
    };

  }
}