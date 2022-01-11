import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vlcc/models/package_listing_model.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';

import 'color_cards.dart';

class PackageCards extends StatefulWidget {
  final PackageDetail packageDetail;
  final bool isInfo;
  final Widget tags;
  final int index;
  final String cardType;
  final void Function() onTap;
  final Color color;

  const PackageCards({
    Key? key,
    required this.tags,
    required this.onTap,
    this.cardType = 'View Details',
    this.isInfo = false,
    required this.packageDetail,
    this.index = 1,
    required this.color,
  }) : super(key: key);

  @override
  _PackageCardsState createState() => _PackageCardsState();
}

class _PackageCardsState extends State<PackageCards> {
  @override
  Widget build(BuildContext context) {
    return packageCards(widget.tags);
  }

  Widget packageCards(Widget tags) {
    var expiryDate = DateFormat.yMMMMd('en_US')
        .format(widget.packageDetail.bookingExpiryDate ?? DateTime.now());
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, PaddingSize.extraLarge, 0, 0),
      child: Stack(
        children: [
          Badge(
            badgeColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            badgeContent: tags,
            position: widget.isInfo
                ? BadgePosition.topStart(top: -15, start: -11)
                : BadgePosition.topEnd(),
            child: ColorfulCard(
              cardColor: widget.color,
              infoCard: widget.isInfo,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MarginSize.normal,
                    top: MarginSize.normal,
                    bottom: MarginSize.extraSmall),
                child: Text(
                  widget.packageDetail.bookingNumber,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.heading),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: MarginSize.normal),
                child: Text(
                  widget.packageDetail.centerName,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.small),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 4),
              //   margin: EdgeInsets.only(left: MarginSize.normal),
              //   child: Text(
              //     "Men's grooming",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontFamily: FontName.frutinger,
              //         fontWeight: FontWeight.w600,
              //         fontSize: FontSize.small),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MarginSize.normal),
                    child: Text(
                      "*Valid till $expiryDate",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.extraSmall),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    margin: EdgeInsets.only(right: MarginSize.normal),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)]
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        // ignore: unnecessary_lambdas
                        onPressed: widget.onTap,
                        child: Text(
                          widget.cardType,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: FontName.frutinger,
                            color:
                                Colors.primaries[widget.index].withOpacity(0.5),
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
