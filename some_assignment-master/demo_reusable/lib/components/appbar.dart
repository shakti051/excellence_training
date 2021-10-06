import 'package:flutter/material.dart';

class IAppBar extends PreferredSize {
  //
  final Widget child;
  final double height;
  final Color color;

  IAppBar({
   @required this.child,
    this.color:Colors.white,
    this.height:kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: color ?? Colors.red,
      alignment: Alignment.center,
      child: child,
    );
  }
}
