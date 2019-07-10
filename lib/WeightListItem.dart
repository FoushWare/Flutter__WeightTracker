import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Model/WeightSave.dart';

class WeightListItem extends StatelessWidget {
  final WeightSave weightSave;
  final double weightDifference;

  const WeightListItem( this.weightSave, this.weightDifference);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                new DateFormat.yMMMMd().format(weightSave.dateTime),
                textScaleFactor: 0.9,
                textAlign: TextAlign.left,
              ),
              Text(
                new DateFormat.EEEE().format(weightSave.dateTime),
                textScaleFactor: 0.8,
                textAlign: TextAlign.right,
                style: new TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: new Text(
              weightSave.weight.toString(),
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            ),
        ),
        Expanded(
            child: new Text(
              weightDifference.toString(),
              textScaleFactor: 1.6,
              textAlign: TextAlign.right,
            ),
        ),
      ],
    );
  }
}

