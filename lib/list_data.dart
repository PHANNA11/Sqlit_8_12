import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqlit8_12/connectioin_database.dart';
import 'package:sqlit8_12/main.dart';
import 'package:sqlit8_12/user_model.dart';

class ListData extends StatefulWidget {
  ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  late DBConnection db;
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DBConnection();
    db.readData().then((value) {
      setState(() {
        users = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          return Card(
            child: ListTile(
              leading: user.profile == null
                  ? CircleAvatar(child: Text(user.name!.substring(0, 1)))
                  : CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    FileImage(File(user.profile.toString())))),
                      ),
                    ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                            title: 'Edit User Info', userObj: user)));
              },
              onLongPress: () async {
                await DBConnection().deleteData(user.id!).whenComplete(() {
                  db.readData().then((value) {
                    setState(() {
                      users = value;
                    });
                  });
                });
              },
              title: Text(user.name.toString()),
            ),
          );
        },
      ),
    );
  }
}
