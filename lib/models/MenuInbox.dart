import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

List dataList = [
  {
    "name": "My Inbox",
    "id": ".01",
    "subMenu": [
      {
        "id": ".01_ibx",
        "name": "Inbox (0)",
        "counts": 0,
        "icon": MdiIcons.mail
      },
      {
        "id": ".01_snt",
        "name": "Sent (0)",
        "counts": 0,
        "icon": MdiIcons.arrangeSendToBack
      },
      {
        "id": ".01_str",
        "name": "Started (0)",
        "counts": 0,
        "icon": MdiIcons.box
      },
      {
        "id": ".01_cmp",
        "name": "Completed (0)",
        "counts": 0,
        "icon": MdiIcons.cube
      }
    ]
  },
  {
    "name": "See All Inbox",
    "id": ".02",
    "subMenu": [
      {
        "name": "SIGNODE Production3",
        "id": "1",
        "subMenu": [
          {
            "id": "1_ibx",
            "name": "Inbox (2)",
            "counts": 1,
            "icon": MdiIcons.mail
          },
          {
            "id": "1_snt",
            "name": "Sent (0)",
            "counts": 0,
            "icon": MdiIcons.arrangeSendToBack
          },
          {
            "id": "1_str",
            "name": "Started (0)",
            "counts": 0,
            "icon": MdiIcons.box
          },
          {
            "id": "1_cmp",
            "name": "Completed (5)",
            "counts": 8,
            "icon": MdiIcons.cube
          }
        ]
      },
      {
        "name": "Cost Optimization",
        "id": "2",
        "subMenu": [
          {
            "id": "2_ibx",
            "name": "Inbox (0)",
            "counts": 0,
            "icon": MdiIcons.mail
          },
          {
            "id": "2_snt",
            "name": "Sent (0)",
            "counts": 0,
            "icon": MdiIcons.arrangeSendToBack
          },
          {
            "id": "2_str",
            "name": "Started (3)",
            "counts": 0,
            "icon": MdiIcons.box
          },
          {
            "id": "2_com",
            "name": "Completed (0)",
            "counts": 0,
            "icon": MdiIcons.cube
          }
        ]
      },
      {
        "name": "SIGNODE Production3",
        "id": "3",
        "subMenu": [
          {
            "id": "3_ibx",
            "name": "Inbox (2)",
            "counts": 1,
            "icon": MdiIcons.mail
          },
          {
            "id": "3_snt",
            "name": "Sent (0)",
            "counts": 0,
            "icon": MdiIcons.arrangeSendToBack
          },
          {
            "id": "3_str",
            "name": "Started (0)",
            "counts": 0,
            "icon": MdiIcons.box
          },
          {
            "id": "3_cmp",
            "name": "Completed (5)",
            "counts": 8,
            "icon": MdiIcons.cube
          }
        ]
      },
      {
        "name": "Cost Optimization",
        "id": "4",
        "subMenu": [
          {
            "id": "4_ibx",
            "name": "Inbox (0)",
            "counts": 0,
            "icon": MdiIcons.mail
          },
          {
            "id": "4_snt",
            "name": "Sent (0)",
            "counts": 0,
            "icon": MdiIcons.arrangeSendToBack
          },
          {
            "id": "4_str",
            "name": "Started (3)",
            "counts": 0,
            "icon": MdiIcons.box
          },
          {
            "id": "4_cmp",
            "name": "Completed (0)",
            "counts": 0,
            "icon": MdiIcons.cube
          }
        ]
      },
      {
        "name": "SIGNODE Production3",
        "id": "5",
        "subMenu": [
          {
            "id": "5_ibx",
            "name": "Inbox (2)",
            "counts": 1,
            "icon": MdiIcons.mail
          },
          {
            "id": "5_snt",
            "name": "Sent (0)",
            "counts": 0,
            "icon": MdiIcons.arrangeSendToBack
          },
          {
            "id": "5_str",
            "name": "Started (0)",
            "counts": 0,
            "icon": MdiIcons.box
          },
          {
            "id": "5_cmp",
            "name": "Completed (5)",
            "counts": 8,
            "icon": MdiIcons.cube
          }
        ]
      },
      {
        "name": "Cost Optimization",
        "id": "6",
        "subMenu": [
          {
            "id": "6_ibx",
            "name": "Inbox (0)",
            "counts": 0,
            "icon": MdiIcons.mail
          },
          {
            "id": "6_snt",
            "name": "Sent (0)",
            "counts": 0,
            "icon": MdiIcons.arrangeSendToBack
          },
          {
            "id": "6_str",
            "name": "Started (3)",
            "counts": 0,
            "icon": MdiIcons.box
          },
          {
            "id": "6_cmp",
            "name": "Completed (0)",
            "counts": 0,
            "icon": MdiIcons.cube
          }
        ]
      }
    ]
  }
];

class MenuInbox {
  String name = '';
  String id = '';

  List<MenuInbox> subMenu = [];

  MenuInbox({required this.name, required this.subMenu});

  MenuInbox.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['subMenu'] != null) {
      subMenu.clear();
      //icon = MdiIcons.arrowLeftBold;
      json['subMenu'].forEach((v) {
        subMenu?.add(new MenuInbox.fromJson(v));
      });
    }
  }
}
