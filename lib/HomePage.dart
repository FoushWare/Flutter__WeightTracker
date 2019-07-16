import 'dart:math';

import 'package:flutter/material.dart';

import 'AddEntryDialog.dart';
import 'Model/WeightEntry.dart';
import 'WeightListItem.dart';
import 'package:firebase_database/firebase_database.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}
/// Get Main reference of the app
final mainReference=FirebaseDatabase.instance.reference();

class _HomePageState extends State<HomePage> {
  List<WeightEntry> weightSaves=new List();
  ScrollController _listViewScrollController=new ScrollController();
  double _itemExtent=50.0;

  _HomePageState(){
    mainReference.onChildAdded.listen(_onEntryAdded);
    mainReference.onChildChanged.listen(_onEntryEdited);
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
        shrinkWrap: true,
        reverse: true,
        controller: _listViewScrollController,
        itemCount: weightSaves.length,
        itemBuilder: (buildContext, index) {
          //calculating difference
          double difference = index == 0
              ? 0.0
              : weightSaves[index].weight - weightSaves[index - 1].weight;
          return new InkWell(
              onTap: () => _openEditEntryDialog(weightSaves[index]),
              child: new WeightListItem(weightSaves[index], difference));
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openAddEntryDialog,
        tooltip: 'Add new weight entry',
        child: new Icon(Icons.add),
      ),
    );
  }


  /// Add weight with random weight and date at the current time
//  void _addWeightSave( WeightSave weightSave){
//    setState(() {
//      weightSaves.add(weightSave);
//
//    });
//  }

  Future _openAddEntryDialog() async {
    WeightEntry entry =
    await Navigator.of(context).push(new MaterialPageRoute<WeightEntry>(
        builder: (BuildContext context) {
          return new WeightEntryDialog.add(
              weightSaves.isNotEmpty ? weightSaves.last.weight : 60.0);
        },
        fullscreenDialog: true));
    if (entry != null) {
      mainReference.push().set(entry.toJson());
    }
  }

  _openEditEntryDialog(WeightEntry weightEntry) {
    Navigator
        .of(context)
        .push(
      new MaterialPageRoute<WeightEntry>(
        builder: (BuildContext context) {
          return new WeightEntryDialog.edit(weightEntry);
        },
        fullscreenDialog: true,
      ),
    )
        .then((WeightEntry newEntry) {
      if (newEntry != null) {
        mainReference.child(weightEntry.key).set(newEntry.toJson());
      }
    });
  }


  _onEntryEdited(Event event) {
    var oldValue =
    weightSaves.singleWhere((entry) => entry.key == event.snapshot.key);
    setState(() {
      weightSaves[weightSaves.indexOf(oldValue)] =
      new WeightEntry.fromSnapshot(event.snapshot);
      weightSaves.sort((we1, we2) => we1.dateTime.compareTo(we2.dateTime));
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      weightSaves.add(new WeightEntry.fromSnapshot(event.snapshot));
      weightSaves.sort((we1, we2) => we1.dateTime.compareTo(we2.dateTime));
    });
    _scrollToTop();
  }

  _scrollToTop() {
    _listViewScrollController.animateTo(
      weightSaves.length * _itemExtent,
      duration: const Duration(microseconds: 1),
      curve: new ElasticInCurve(0.01),
    );
  }
}










