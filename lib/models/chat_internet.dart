class ChatInternet {
  final String name;
  final String message;
  final String time;
  final String pic;
  final int count;

  ChatInternet({this.name, this.message, this.time, this.pic, this.count});

  factory ChatInternet.fromJson(Map<String, dynamic> json) {
    return ChatInternet(
      pic: json['pic'],
      count: json['count'],
      message: json['message'],
      name: json['name'],
      time: json['time'],
    );
  }
}
