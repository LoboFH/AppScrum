import 'dart:convert';
import 'package:flutter/material.dart';
import 'Item.dart';
import 'item_detail_screen.dart';

class JsonListViewScreen extends StatefulWidget {
  @override
  _JsonListViewScreenState createState() => _JsonListViewScreenState();
}

class _JsonListViewScreenState extends State<JsonListViewScreen> {
  late List<Item> items;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    // Carga el JSON desde el archivo assets
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data_scrum.json');
    List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      items = jsonList.map((item) => Item.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scrum Elements'),
          backgroundColor: Colors.green.shade300,
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailScreen(item: items[index])),
                  );
                },
                child: Text(items[index].name),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade100,
                  textStyle: const TextStyle(fontSize: 18),
                  padding: const EdgeInsets.all(20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
