import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogScreen extends StatelessWidget {
  AlertDialogScreen(BuildContext ctx);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout?'),
            content: const Text('Do You Want Logout?'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    // Write code to delete item
                  },
                  child: const Text(
                    'Yes',
                  )),
            ],
          );
        });
  }
}
