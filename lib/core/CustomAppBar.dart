import 'package:flutter/material.dart';

import 'CustomColors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<AppBarAction> actions;
  final List<AppBarAction> leadingActions;
  final Color backgroundColor;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final double elevation;
  final Widget? titleWidget;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleStyle,
    this.actions = const [],
    this.leadingActions = const [],
    this.backgroundColor = CustomColors.white,
    this.flexibleSpace,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.elevation = 4.0,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveTitle = title.isNotEmpty ? title : null;
    final leadingWidgets = <Widget>[];

    leadingWidgets.addAll(
      leadingActions.map((action) {
        return IconButton(
          color: CustomColors.sapphireBlue,
          icon: action.icon,
          onPressed: action.onPressed,
        );
      }),
    );

    return AppBar(
      iconTheme: IconThemeData(color: CustomColors.sapphireBlue),
      title: effectiveTitle != null
          ? Text(
              effectiveTitle,
              style: titleStyle,
            )
          : titleWidget,
      actions: actions.map((action) {
        return IconButton(
          color: CustomColors.sapphireBlue,
          icon: action.icon,
          onPressed: action.onPressed,
        );
      }).toList(),
      leading: leadingWidgets.isNotEmpty
          ? Row(
              children: leadingWidgets,
            )
          : null,
      backgroundColor: backgroundColor,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      elevation: elevation,
      toolbarHeight: _calculateToolbarHeight(context),
    );
  }

  double _calculateToolbarHeight(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = AppBar().preferredSize.height;
    return statusBarHeight + appBarHeight;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarAction {
  final Widget icon;
  final VoidCallback onPressed;

  AppBarAction({
    required this.icon,
    required this.onPressed,
  });
}
