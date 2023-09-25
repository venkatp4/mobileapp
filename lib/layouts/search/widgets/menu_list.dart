import 'package:ez/layouts/process/controller/processlayout_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/menuheading.dart';
import '../models/menu.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'menu_tile.dart';
import 'menu_tile_title.dart';

class MenuList extends StatelessWidget {
  //final controller = Get.put(ProcesslayoutController());
  MenuList({Key? key}) : super(key: key);
  final controller = new ProcesslayoutController();

  @override
  Widget build(BuildContext context) {
    debugPrint('3--------------------------------------------');
    debugPrint('3--------------------------------------------yy ' +
        menus.length.toString());
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, int i) {
        return Container(
          child: Column(children: <Widget>[
            MenuTileTitle(label: 'Information', color: Colors.black),
            MenuTile(
              label: 'Edit Profiles',
              icon: MdiIcons.squareEditOutline,
              color: Colors.black,
              onTap: () =>
                  controller.gototoast('/editprofile', 'Edit Profile', context),
            ),
            MenuTile(
              label: 'E-mail',
              icon: MdiIcons.emailOutline,
              color: Colors.black,
              onTap: () => controller.gototoast('/email', 'E-Mail', context),
            ),
            MenuTile(
              label: 'Password',
              icon: MdiIcons.lockOutline,
              color: Colors.black,
/*              onTap: () =>
                  controller.gototoast('/password', 'Password', context),*/
              onTap: () =>
                  controller.gototoast('/otpscreen', 'Password', context),
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            MenuTileTitle(label: 'Preferences', color: Colors.black),
            MenuTile(
              label: 'Notification',
              icon: MdiIcons.bellOutline,
              color: Colors.black,
              onTap: () => controller.gototoast(
                  '/notification', 'Notification', context),
            ),
            MenuTile(
              label: 'Language',
              icon: MdiIcons.web,
              color: Colors.black,
              onTap: () =>
                  controller.gototoast('/languages', 'Languages', context),
            ),
            MenuTile(
              label: 'Shortcut',
              icon: MdiIcons.pin,
              color: Colors.black,
              onTap: () =>
                  controller.gototoast('/shortcut', 'ShortCut', context),
            ),
            MenuTile(
              label: 'Theme',
              icon: MdiIcons.themeLightDark,
              color: Colors.black,
              onTap: () => controller.gototoast('/theme', 'Theme', context),
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            MenuTileTitle(label: 'Account', color: Colors.black),
            MenuTile(
              label: 'Help & Support',
              icon: MdiIcons.plus,
              color: Colors.black,
              onTap: () =>
                  controller.gototoast('/help', 'Help & Support', context),
            ),
            MenuTile(
              label: 'Logout',
              icon: MdiIcons.logout,
              color: Colors.black,
              onTap: () => controller.gototoast('/logout', 'Logout', context),
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
          ]),
        ); /*MenuTile(
            label: 'menu.label',
            icon: controller.activeRoute.value == menu.ic
                ? menu.activeIcon
                : menu.icon,
            color: controller.activeRoute.value == menu.route
                ? BrandColors.secondary
                : Colors.white70,
            isActive: controller.activeRoute.value == menu.route,
            onTap: () => controller.goto(menu.route),
          ),*/
      },
    );
  }
/*
  Widget buildmenu(BuildContext context, final innermenus) {
    debugPrint('Inner  ' + innermenus.length.toString());
    return MenuTile(
      label: innermenus[0].label,
      icon: controller.activeRoute.value == innermenus[0].route
          ? innermenus[0].activeIcon
          : innermenus[0].icon,
      color: controller.activeRoute.value == innermenus[0].route
          ? Colors.black
          : Colors.black,
      isActive: controller.activeRoute.value == innermenus[0].route,
      onTap: () => controller.goto(innermenus[0].route),
    );
  }*/

/*  Widget buildmenu(BuildContext context, final innermenus) {
    debugPrint('Inner');
    debugPrint(innermenus.toString());
    debugPrint('44============--------------------------------------------');
    return ListView.builder(
      itemCount: 1, // innermenus.length,
      itemBuilder: (_, int j) {
        debugPrint('1============--------------------------------------------');
        debugPrint(
            innermenus.length.toString() + '--------- ' + j.toString() + " ");
        final menu = innermenus[j];
        debugPrint('2============--------------------------------------------');
        return MenuTile(
          label: menu.label,
          icon: controller.activeRoute.value == menu.route
              ? menu.activeIcon
              : menu.icon,
          color: controller.activeRoute.value == menu.route
              ? Colors.black
              : Colors.black,
          isActive: controller.activeRoute.value == menu.route,
          onTap: () => controller.goto(menu.route),
        );
      },
    );
  }*/

  goto(String route) {
    //toggleDrawer();
    // Get.toNamed(route);
  }

  final menus = [
    // MenuHeading(label: 'one'),
    Menu(
      label: 'Edit Profiles',
      icon: MdiIcons.squareEditOutline,
      activeIcon: MdiIcons.squareEditOutline,
      route: '/editprofile',
    ),
    Menu(
      label: 'E-mail',
      icon: MdiIcons.emailOutline,
      activeIcon: MdiIcons.emailOutline,
      route: '/email',
    ),
    Menu(
      label: 'Password',
      icon: MdiIcons.lockOutline,
      activeIcon: MdiIcons.lockOutline,
      route: '/password',
    ),
    MenuHeading(label: 'two'),
    Menu(
      label: 'Notification',
      icon: MdiIcons.bellAlert,
      activeIcon: MdiIcons.bellAlert,
      route: '/editprofile',
    ),
    Menu(
      label: 'Language',
      icon: MdiIcons.signLanguage,
      activeIcon: MdiIcons.signLanguage,
      route: '/email',
    ),
    Menu(
      label: 'Shortcut',
      icon: MdiIcons.lockOutline,
      activeIcon: MdiIcons.lockOutline,
      route: '/password',
    ),
    Menu(
      label: 'Theme',
      icon: MdiIcons.themeLightDark,
      activeIcon: MdiIcons.themeLightDark,
      route: '/password',
    ),
    MenuHeading(label: 'Three'),
    Menu(
      label: 'Help & Support',
      icon: MdiIcons.help,
      activeIcon: MdiIcons.help,
      route: '/editprofile',
    ),
    Menu(
      label: 'Logout',
      icon: MdiIcons.logout,
      activeIcon: MdiIcons.logout,
      route: '/email',
    )
  ];
}
