import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/call_model.dart';
import 'package:http/http.dart' as http;

class CallsScreen extends StatefulWidget {
  const CallsScreen({Key key}) : super(key: key);

  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CallModel>>(
        future: getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CallModel> data = snapshot.data;
            return _callsListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error} occured");
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

Future<List<CallModel>> getCalls() async {
  final url = "https://6022cb3e57efd60017258beb.mockapi.io/calls";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List callsData = jsonDecode(response.body);
    return callsData.map((calls) => CallModel.fromJson(calls)).toList();
  } else {
    throw Exception("Failed to get data from API");
  }
}

ListView _callsListView(data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return _tile(
          data[index].name, data[index].pic, data[index].time, context);
    },
  );
}

ListTile _tile(String name, String pic, String time, context) => ListTile(
      leading: CircleAvatar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(pic),
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
        children: [
          Icon(
            Icons.call_made,
            color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      trailing: Icon(
        Icons.video_call_rounded,
        color: Colors.green,
        size: 30.0,
      ),
    );
