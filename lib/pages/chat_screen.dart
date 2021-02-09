import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_internet.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatInternet>>(
        future: fetchChatData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChatInternet> data = snapshot.data;
            return _chatsListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error} occured");
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

Future<List<ChatInternet>> fetchChatData() async {
  final url = "https://6022cb3e57efd60017258beb.mockapi.io/chats";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List chatData = jsonDecode(response.body);
    return chatData.map((chats) => ChatInternet.fromJson(chats)).toList();
  } else {
    throw Exception("Failed to get data from API");
  }
}

ListView _chatsListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _tile(data[index].name, data[index].message, data[index].pic,
            data[index].time, data[index].count, context);
      });
}

ListTile _tile(String name, String message, String pic, String time, int count,
        context) =>
    ListTile(
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
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(fontSize: 10),
                )),
          ),
        ],
      ),
    );
