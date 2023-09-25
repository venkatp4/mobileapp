import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Labels extends StatefulWidget {
  final String sLabel;

  const Labels({required this.sLabel});

  @override
  _LabelsState createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: DefaultTextStyle(
                style: TextStyle(decoration: TextDecoration.none),
                child: Text(widget.sLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400))),
          ),
        ),
      ],
    );
  }
}
