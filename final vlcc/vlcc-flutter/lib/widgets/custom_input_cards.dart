import 'package:flutter/material.dart';
import 'package:vlcc/resources/dimensions.dart';

import 'heading_title_text.dart';

class FieldCards extends StatelessWidget {
  final List<Widget> columnWidgets;
  final double headerPadding;
  final double columnCardPadding;
  final double mainCardPadding;
  final String cardTitle;
  const FieldCards(
      {Key? key,
      required this.columnWidgets,
      required this.cardTitle,
      this.headerPadding = PaddingSize.small,
      this.columnCardPadding = PaddingSize.standard,
      this.mainCardPadding = PaddingSize.small})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return inputFieldCards(cardTitle, columnWidgets: columnWidgets);
  }

  Widget inputFieldCards(String cardTitle,
      {required List<Widget> columnWidgets}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          mainCardPadding, mainCardPadding, mainCardPadding, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
        elevation: 0.6,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(headerPadding),
              child: Row(
                children: [
                  HeadingTitleText(
                    fontSize: FontSize.large,
                    title: cardTitle,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.all(columnCardPadding),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: columnWidgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
