import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/status_model.dart';
import 'package:http/http.dart' as http;

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Divider(
                height: 10.0,
              ),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "https://i.picsum.photos/id/1074/5472/3648.jpg?hmac=w-Fbv9bl0KpEUgZugbsiGk3Y2-LGAuiLZOYsRk0zo4A"),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tap to add status update",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Updates",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          FutureBuilder<List<StatusModel>>(
            future: getStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<StatusModel> data = snapshot.data;
                return _statusListView(data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error} occured");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

Future<List<StatusModel>> getStatus() async {
  final url = "https://6022cb3e57efd60017258beb.mockapi.io/status";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List statusData = jsonDecode(response.body);
    return statusData.map((status) => StatusModel.fromJson(status)).toList();
  } else {
    throw Exception("Failed to get data from API");
  }
}

ListView _statusListView(data) {
  return ListView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return _tile(
          data[index].name, data[index].pic, data[index].time, context);
    },
  );
}

ListTile _tile(String name, String pic, String time, context) => ListTile(
      leading: Container(
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        child: CircleAvatar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(pic),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
