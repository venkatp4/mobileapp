import 'package:flutter/material.dart';

import '../../../core/CustomAppBar.dart';
import '../../../core/CustomColors.dart';

class WorkflowDetails extends StatelessWidget {
  const WorkflowDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        actions: [
          AppBarAction(icon: Icon(Icons.add_a_photo), onPressed: () => {}),
        ],
        backgroundColor: CustomColors.white24,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [Text("Dummy Controller")],
          ),
        ),
      ),
    );
  }
}
