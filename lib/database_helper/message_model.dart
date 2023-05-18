class MessageModel{
  final int? id;
  final String message;

  //
  MessageModel({this.id, required this.message});

  MessageModel.fromMap(Map<String,dynamic> json):
        id = json["id"],
        message=json['message'];

  Map<String,Object?> toJson(){
    return {
      'id' : id,
      'message': message,
    };
  }
}