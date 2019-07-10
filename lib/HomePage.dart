import 'dart:math';

import 'package:flutter/material.dart';

import 'AddEntryDialog.dart';
import 'Model/WeightSave.dart';
import 'WeightListItem.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeightSave> weightSaves=new List();



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
      floatingActionButton: FloatingActionButton(onPressed: _openAddEntryDialog
        ,tooltip: "Add new weight entry",
        child: Icon(Icons.add),
      ),

    );
  }


  /// Add weight with random weight and date at the current time
  void _addWeightSave( WeightSave weightSave){
    setState(() {
      weightSaves.add(weightSave);

    });
  }

  Future _openAddEntryDialog()async {
    WeightSave save= await
    /// push return object as a promise
    /// The value is returned when the pop method is called. After that will happen we check if we received any value and then add it to list
     Navigator.of(context).push(new MaterialPageRoute<WeightSave>(
        builder: (BuildContext context) {
      return new AddEntryDialog.add(
          weightSaves.isNotEmpty ? weightSaves.last.weight : 60.0);

        },
        fullscreenDialog: true));

    if(save !=null){
      _addWeightSave(save);
    }
  }





}






