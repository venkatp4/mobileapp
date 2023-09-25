import 'package:flutter/material.dart';

class TabLayoutHome extends StatelessWidget {
  //List<Tab>? tabvalues;

  final List<Tab> tabvalues = <Tab>[
    Tab(text: ' 1'),
    Tab(text: ' 2'),
    Tab(text: ' 3'),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: tabvalues.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: tabvalues,
            ),
          ),
          body: TabBarView(
            children: [
              Text("TAB ONE CONTENT"),
              Text("TAB TWO CONTENT"),
              Text("TAB THREE CONTENT"),
            ],
          ),
        ));
  }
}
