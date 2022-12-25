import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? profile;
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
        actions: [
          IconButton(
              onPressed: () {
                getImageFromGallary();
              },
              icon: const Icon(Icons.image))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 200,
              width: double.infinity,
              child: profile == null
                  ? const Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://imgs.search.brave.com/RixRBxtlzZdsqVfWyxdSGhKqgL_mrg70tAkap4DCYCs/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9pY29u/LWxpYnJhcnkuY29t/L2ltYWdlcy9uby1w/cm9maWxlLXBpYy1p/Y29uL25vLXByb2Zp/bGUtcGljLWljb24t/Ny5qcGc'),
                    )
                  : Image(
                      fit: BoxFit.cover,
                      image: FileImage(File(profile!.path)))),
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
                        age: int.parse(ageController.text),
                        profile: profile!.path));
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

  getImageFromGallary() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      profile = File(file!.path);
    });
  }
}
