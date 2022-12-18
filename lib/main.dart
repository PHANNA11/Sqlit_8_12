import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlit8_12/connectioin_database.dart';
import 'package:sqlit8_12/list_data.dart';
import 'package:sqlit8_12/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', userObj: User()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.userObj});

  final String title;
  User userObj;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  initObject() {
    nameController.text = widget.userObj.name.toString();
    ageController.text = widget.userObj.age.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userObj.id != null) {
      initObject();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter name',
                  label: Text('Name')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Age',
                  label: Text('age')),
            ),
          ),
          widget.userObj.id == null
              ? CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text('save'),
                  onPressed: () async {
                    await DBConnection().insertData(User(
                        id: DateTime.now().millisecond,
                        name: nameController.text,
                        age: int.parse(ageController.text)));
                  })
              : CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text('update'),
                  onPressed: () async {
                    await DBConnection()
                        .updateData(User(
                            id: widget.userObj.id,
                            name: nameController.text,
                            age: int.parse(ageController.text)))
                        .then((value) => Navigator.pop(context));
                  })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListData(),
              ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.menu),
      ),
    );
  }
}
