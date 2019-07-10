import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weight_tracker/WeightListItem.dart';

import 'Model/WeightSave.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    List<WeightSave> weightSaves=new List();

    void addWeightSave(){
      setState(() {
        weightSaves.add(
          WeightSave(DateTime.now(), Random().nextInt(100).toDouble())
        );
      });
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("weight tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children:
          weightSaves.map((WeightSave WS){//calculating difference
            double difference = weightSaves.first == WS
                ? 0.0
                : WS.weight -
                weightSaves[weightSaves.indexOf(WS) - 1].weight;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: WeightListItem(WS,difference),
            );

          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: addWeightSave
      ,tooltip: "Add new weight entry",
      child: Icon(Icons.add),
      ),

    );
  }
}
