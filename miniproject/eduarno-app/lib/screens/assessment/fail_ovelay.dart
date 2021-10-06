import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utilities/constants.dart';

class FailOverlay extends ModalRoute<void> {
  FailOverlay();
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.red[400].withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400].withOpacity(0.2),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryGreenColor),
          ),
          child: Text("Continue")),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Flexible(
              child: Text(
            "Sorry you have failed in your assessment\n Please try again after 3 months",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
