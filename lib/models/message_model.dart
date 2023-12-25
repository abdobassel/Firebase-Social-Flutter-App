class MessageModel {
  String? ReceiverId;
  String? txt;

  String? senderId;
  String? dateTime;
  String? imageMessage;

  MessageModel(
      {this.ReceiverId,
      this.dateTime,
      this.senderId,
      this.txt,
      this.imageMessage});

  MessageModel.fromJson(Map<String, dynamic> json) {
    ReceiverId = json['ReceiverId'];
    senderId = json['senderId'];
    imageMessage = json['imageMessage'];
    dateTime = json['dateTime'];

    txt = json['txt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ReceiverId': ReceiverId,
      'imageMessage': imageMessage,
      'senderId': senderId,
      'dateTime': dateTime,
      'txt': txt,
    };
  }
}
