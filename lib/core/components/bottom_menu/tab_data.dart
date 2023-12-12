import 'package:flutter/material.dart';

class TabItem {
  String label;
  IconData icon;
  TabItem(this.label, this.icon);

  static final int kTabItemCount = generateTabList().length;
  static List<TabItem> generateTabList() {
    return [
      TabItem('Home', Icons.home_outlined),
      TabItem('Friends', Icons.person_outline),
      TabItem('Reels', Icons.movie_outlined),
      TabItem('Notifications', Icons.notifications_outlined)
    ];
  }
}
