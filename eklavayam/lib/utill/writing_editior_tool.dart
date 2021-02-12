import 'package:flutter/material.dart';

class WritingEditiorTool extends InheritedWidget {
  const WritingEditiorTool({
    Key key,
    @required this.object,
    @required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  final dynamic object;

  static WritingEditiorTool of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(
        WritingEditiorTool) as WritingEditiorTool;
  }

  @override
  bool updateShouldNotify(WritingEditiorTool old) {
    return object != old.object;
  }
}