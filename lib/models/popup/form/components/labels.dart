import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Labels extends StatefulWidget {
  final String sLabel;
  final bool bRequired;

  const Labels({required this.sLabel, required this.bRequired});

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
                child: new RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: new TextSpan(
                    style: new TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        color: Color(0xff64748b),
                        //64748b
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(text: widget.sLabel),
                      !widget.bRequired
                          ? TextSpan(
                              text: ' (optional)',
                              style: new TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  color: Color(0xff94a3b8),
                                  fontWeight: FontWeight.w400))
                          : TextSpan(text: ''),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
