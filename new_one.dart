import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Chooser',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: Color.fromARGB(255, 255, 255, 255),
        accentColor: Color.fromARGB(255, 156, 255, 35),
        canvasColor: Color.fromARGB(255, 132, 36, 36),
        fontFamily: 'Merriweather',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = [
    Item(name: 'Apple', imagePath: 'fruits/apple.png'),
    Item(name: 'banana', imagePath: 'fruits/banana.png'),
    Item(name: 'Orange', imagePath: 'fruits/orange.png'),
    Item(name: 'Mango', imagePath: 'fruits/mango.png'),
    Item(name: 'watermelon', imagePath: 'fruits/watermelon.png'),
    Item(name: 'durian', imagePath: 'fruits/durian.png'),
    Item(name: 'kiwi', imagePath: 'fruits/kiwi.png'),
  ];

  String? selectedChoice;
  String? displayedImage;
  bool isListVisible = false;

  void displayChoice() {
  Item? chosenItem = findItem(selectedChoice);

  if (chosenItem != null) {
    setState(() {
      displayedImage = chosenItem.imagePath;
    });
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Item'),
          content: Text('The entered item is not in the list.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

Item? findItem(String? name) {
  if (name == null) return null;
  
  for (var item in items) {
    if (item.name.toLowerCase() == name.toLowerCase()) {
      return item;
    }
  }
  
  return null;
}
  void feelingLucky() {
    Random random = Random();
    int index = random.nextInt(items.length);

    setState(() {
      displayedImage = items[index].imagePath;
    });
  }

  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Chooser by Rashad 2020355'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _textFieldController,
                onChanged: (value) {
                  setState(() {
                    selectedChoice = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter an item',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isListVisible = !isListVisible;
                  });
                },
                child: Text('Choose an Item'),
              ),
              SizedBox(height: 16.0),
              Visibility(
                visible: isListVisible,
                child: Container(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index].name),
                        onTap: () {
                          setState(() {
                            selectedChoice = items[index].name;
                            isListVisible = false;
                          });
                          _textFieldController.text = selectedChoice!;
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  displayChoice();
                },
                child: Text('Display Choice'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  feelingLucky();
                },
                child: Text("I'm feeling Lucky"),
              ),
              SizedBox(height: 16.0),
              displayedImage != null
                  ? Image.asset(
                      displayedImage!,
                      width: 200.0,
                      height: 200.0,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final String imagePath;

  Item({required this.name, required this.imagePath});
}
