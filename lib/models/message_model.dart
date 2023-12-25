class MessageModel {
  String? ReceiverId;
  String? txt;

  String? senderId;
  String? dateTime;

  MessageModel({this.ReceiverId, this.dateTime, this.senderId, this.txt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    ReceiverId = json['ReceiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];

    txt = json['txt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ReceiverId': ReceiverId,
      'senderId': senderId,
      'dateTime': dateTime,
      'txt': txt,
    };
  }
}
