import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqlit8_12/connectioin_database.dart';
import 'package:sqlit8_12/user_model.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

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
          return Card(
            child: ListTile(
              title: Text(users[index].name.toString()),
            ),
          );
        },
      ),
    );
  }
}
