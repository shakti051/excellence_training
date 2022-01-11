import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/providers/feedback_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class ConsultationFeedback extends StatefulWidget {
  const ConsultationFeedback({Key? key}) : super(key: key);

  @override
  State<ConsultationFeedback> createState() => _ConsultationFeedbackState();
}

class _ConsultationFeedbackState extends State<ConsultationFeedback> {
  bool _peopleName = false;

  @override
  Widget build(BuildContext context) {
    final recommendType = context.watch<FeedbackProvider>();
    final rating = context.watch<FeedbackProvider>();
    final remindDuration = context.watch<FeedbackProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Transform.scale(
            scale: 1.4,
            child: Container(
              margin: EdgeInsets.only(left: 24, top: 12, bottom: 12),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.backBorder),
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(SVGAsset.backButton),
              ),
            ),
          ),
          title: Text("Consultation Feedback",
              style: TextStyle(
                  height: 1.5,
                  color: Colors.black87,
                  fontFamily: FontName.frutinger,
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.extraLarge)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text("How was your experience?",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading)),
                SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: 'Would you recommend ',
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.normal),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Safe Health clinic ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'to your friends?'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        recommendType.selectYes();
                      },
                      child: Row(
                        children: [
                          recommendType.getYes
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: SvgPicture.asset(SVGAsset.activeRadio))
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  width: 24.0,
                                  height: 24.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    border: Border.all(
                                        color: AppColors.backBorder,
                                        width: 2.0),
                                  ),
                                ),
                          Text("Yes",
                              style: TextStyle(
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.large)),
                        ],
                      ),
                    ),
                    SizedBox(width: 50),
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        recommendType.selectNo();
                      },

                      child: Row(
                        children: [
                          recommendType.getNo
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: SvgPicture.asset(SVGAsset.activeRadio))
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  width: 24.0,
                                  height: 24.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    border: Border.all(
                                        color: AppColors.backBorder,
                                        width: 2.0),
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.only(right: 14),
                            child: Text("No",
                                style: TextStyle(
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.large)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Text("Did your request start on time?",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.normal)),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          // ignore: unnecessary_lambdas
                          onTap: () {
                            remindDuration.selectOnTime();
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            padding: EdgeInsets.symmetric(
                                horizontal: PaddingSize.normal),
                            decoration: BoxDecoration(
                              color: remindDuration.getOnTime
                                  ? AppColors.orange
                                  : null,
                              border: Border.all(
                                  width: 1, color: AppColors.backBorder),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SvgPicture.asset(SVGAsset.time,
                                height: 50,
                                color: remindDuration.getOnTime
                                    ? Colors.white
                                    : AppColors.navyBlue),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text("On time",
                              style: TextStyle(
                                  color: remindDuration.getOnTime
                                      ? Colors.black87
                                      : Colors.grey,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.normal)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          // ignore: unnecessary_lambdas
                          onTap: () {
                            remindDuration.selectTenMin();
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            padding: EdgeInsets.only(top: PaddingSize.middle),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.backBorder),
                              color:
                                  Provider.of<FeedbackProvider>(context).getTen
                                      ? AppColors.orange
                                      : AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text("10m",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: remindDuration.getTen
                                        ? Colors.white
                                        : AppColors.navyBlue,
                                    fontFamily: FontName.oswald,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.extraLarge)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text("10 min later",
                              style: TextStyle(
                                  color: remindDuration.getTen
                                      ? Colors.black87
                                      : Colors.grey,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.normal)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          // ignore: unnecessary_lambdas
                          onTap: () {
                            remindDuration.selectThirtyMin();
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            padding: EdgeInsets.only(top: PaddingSize.middle),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.backBorder),
                              borderRadius: BorderRadius.circular(15),
                              color: remindDuration.getThirtyMin
                                  ? AppColors.orange
                                  : AppColors.backgroundColor,
                            ),
                            child: Text("30m",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: remindDuration.getThirtyMin
                                        ? Colors.white
                                        : AppColors.navyBlue,
                                    fontFamily: FontName.oswald,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.extraLarge)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text("30 min later",
                              style: TextStyle(
                                  color: remindDuration.getThirtyMin
                                      ? Colors.black87
                                      : Colors.grey,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.normal)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          // ignore: unnecessary_lambdas
                          onTap: () {
                            remindDuration.selectTwoHour();
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            padding: EdgeInsets.only(top: PaddingSize.middle),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.backBorder),
                              borderRadius: BorderRadius.circular(15),
                              color: remindDuration.getTwoHour
                                  ? AppColors.orange
                                  : null,
                            ),
                            child: Text("2h",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: remindDuration.getTwoHour
                                        ? Colors.white
                                        : AppColors.navyBlue,
                                    fontFamily: FontName.oswald,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.extraLarge)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text("2h later",
                              style: TextStyle(
                                  color: remindDuration.getTwoHour
                                      ? Colors.black87
                                      : Colors.grey,
                                  fontFamily: FontName.frutinger,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.normal)),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text("How would you rate overall experience?",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.normal)),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        rating.selectOneStar();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MarginSize.small),
                        child: SvgPicture.asset(
                          SVGAsset.stars,
                          width: 50,
                          color: rating.oneStar ? null : Colors.grey[200],
                        ),
                      ),
                    ),
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        rating.selectTwoStar();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MarginSize.small),
                        child: SvgPicture.asset(
                          SVGAsset.stars,
                          width: 50,
                          color: rating.twoStar ? null : Colors.grey[200],
                        ),
                      ),
                    ),
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        rating.selectThreeStar();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MarginSize.small),
                        child: SvgPicture.asset(
                          SVGAsset.stars,
                          width: 50,
                          color: rating.threeStar ? null : Colors.grey[200],
                        ),
                      ),
                    ),
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        rating.selectFourStar();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MarginSize.small),
                        child: SvgPicture.asset(
                          SVGAsset.stars,
                          width: 50,
                          color: rating.fourStar ? null : Colors.grey[200],
                        ),
                      ),
                    ),
                    GestureDetector(
                      // ignore: unnecessary_lambdas
                      onTap: () {
                        rating.selectFiveStar();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MarginSize.small),
                        child: SvgPicture.asset(
                          SVGAsset.stars,
                          width: 50,
                          color: rating.fiveStar ? null : Colors.grey[200],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text("Any additional comments? (Optional)",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.normal)),
                SizedBox(height: 20),
                TextFormField(
                    maxLines: 5,
                    maxLength: 1000,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.orangeProfile),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Tell people about your experience'),
                    keyboardType: TextInputType.text),
                SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('public as anonymously'),
                  value: _peopleName,
                  onChanged: (bool value) {
                    setState(() {
                      _peopleName = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                GradientButton(
                  height: 50,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Edit Reminder",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.large)),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
