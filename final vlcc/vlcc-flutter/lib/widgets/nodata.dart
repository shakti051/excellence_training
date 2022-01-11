import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

enum NoDataSelectType {
  packageInvoiceList,
  bookingInvoiceList,
  package,
  empty,
  appointment,
  reminders,
  upcomingAppointment,
  feelsEmptyHere,
}

class NoDataScreen extends StatelessWidget {
  final NoDataSelectType noDataSelect;
  final String feelsEmptyHereMessage;
  const NoDataScreen({
    Key? key,
    this.noDataSelect = NoDataSelectType.packageInvoiceList,
    this.feelsEmptyHereMessage = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(noDataSelect: noDataSelect);
  }

  Widget body({required NoDataSelectType noDataSelect}) {
    switch (noDataSelect) {
      case NoDataSelectType.reminders:
        return invoiceListNoData(
            text1: 'Looks like you have not explored our ',
            text2: 'services. ',
            text3: 'You also can add reminders to your bookings.');
      case NoDataSelectType.packageInvoiceList:
        return invoiceListNoData(
            text1: 'All your past',
            text2: ' bookings done through Package',
            text3:
                ' will be shown here. You would also be able to download the invoices.');
      case NoDataSelectType.bookingInvoiceList:
        return invoiceListNoData(
            text1: 'All your past',
            text2: ' bookings done through cash',
            text3:
                ' will be shown here. You would also be able to download the invoices.');
      case NoDataSelectType.package:
        return awSnap();
      case NoDataSelectType.empty:
        return noData();
      case NoDataSelectType.appointment:
        return bookNew();
      case NoDataSelectType.upcomingAppointment:
        return upcomingAppointment();
      case NoDataSelectType.feelsEmptyHere:
        return invoiceListNoData(
            text1: '', text2: feelsEmptyHereMessage, text3: ' ');
      default:
        return SizedBox();
    }
  }

  Widget awSnap() {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        strokeWidth: 2,
        color: AppColors.grey,
        dashPattern: const [8],
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeadingTitleText(
                fontSize: FontSize.extraLarge, title: 'Feels Empty Here!'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "It shouldn’t be empty. Your health is important, we'll inform you when ",
                    style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.normal,
                      fontSize: FontSize.defaultFont,
                      color: AppColors.grey,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: ' VLCC Centre',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' will be available near you.',
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upcomingAppointment() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MarginSize.defaulty),
      child: Center(
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          strokeWidth: 2,
          color: AppColors.grey,
          dashPattern: const [8],
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeadingTitleText(
                  fontSize: FontSize.extraLarge, title: 'Feels Empty Here!'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Your upcoming appointments will be available here. ",
                    style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.normal,
                      fontSize: FontSize.defaultFont,
                      color: AppColors.grey,
                    ),
                    // children: const <TextSpan>[
                    //   TextSpan(
                    //     text: '',
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    //   TextSpan(
                    //     text: ' will be available near you.',
                    //   )
                    // ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookNew() {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        strokeWidth: 2,
        color: AppColors.grey,
        dashPattern: const [8],
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeadingTitleText(
                fontSize: FontSize.extraLarge, title: 'Feels Empty Here!'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "It shouldn’t be empty. Your health is important, let’s schedule an appointment with ",
                    style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.normal,
                      fontSize: FontSize.defaultFont,
                      color: AppColors.grey,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: ' VLCC experts',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' near you.',
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noData() {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        strokeWidth: 2,
        color: AppColors.grey,
        dashPattern: const [8],
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeadingTitleText(
                fontSize: FontSize.extraLarge, title: 'No Packages'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        'We can’t find any packages associated to your account. Contact your nearest',
                    style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.normal,
                      fontSize: FontSize.defaultFont,
                      color: AppColors.grey,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: ' VLCC Centre',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' to subscribe to a package.',
                      )
                    ]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    HeadingTitleText(
                      fontSize: FontSize.defaultFont,
                      title: 'Perks :',
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                perks(title: 'Discounted services'),
                perks(title: 'Discounted services'),
                perks(title: 'Discounted services'),
                perks(title: 'Discounted services'),
              ],
            )
          ],
        ),
      ),
    );
  }

  ListTile perks({required String title}) {
    return ListTile(
      minLeadingWidth: 30.0,
      leading: SvgPicture.asset(SVGAsset.checkBox),
      horizontalTitleGap: 0,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: FontName.frutinger,
          fontWeight: FontWeight.normal,
          fontSize: FontSize.defaultFont,
          color: AppColors.grey,
        ),
      ),
    );
  }

  Widget invoiceListNoData(
      {required String text1, required String text2, required String text3}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              SVGAsset.noDataPad,
              filterQuality: FilterQuality.high,
            ),
          ),
          HeadingTitleText(
              fontSize: FontSize.extraLarge, title: 'There’s nothing here!'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: text1,
                  style: TextStyle(
                    fontFamily: FontName.frutinger,
                    fontWeight: FontWeight.normal,
                    fontSize: FontSize.defaultFont,
                    color: AppColors.grey,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: text2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: text3,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
