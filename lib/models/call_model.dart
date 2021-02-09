class CallModel {
  final String name;
  final String time;
  final String pic;

  CallModel({this.name, this.time, this.pic});

  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(name: json['name'], time: json['time'], pic: json['pic']);
  }
}
