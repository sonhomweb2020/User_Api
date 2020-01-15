import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  Map UserList; 
  List users;
  Future setUser() async {
    String url = "https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=beautiful&image_type=photo&pretty=true";
    http.Response response = await http.get(url);
    UserList =  json.decode(response.body); 
    setState(() {
     users =UserList["hits"];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User information"),
      ),
      body: ListView.builder(
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (BuildContext context, int i){
          final UserName = users[i];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                      children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage("${UserName["userImageURL"]}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("${UserName["user"]}"),
                      ), 
                    ],
                    ),
                      Image.network("${UserName["largeImageURL"]}",width: 400.0,)
                    ],
                  ),
                ),
              )
            ),
          );
        }
      ),
    );
  }
}