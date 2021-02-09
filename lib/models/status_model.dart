class StatusModel {
  final String name;
  final String time;
  final String pic;

  StatusModel({this.name, this.time, this.pic});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      pic: json['pic'],
      name: json['name'],
      time: json['time'],
    );
  }
}
