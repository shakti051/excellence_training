import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/custom_input_cards.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class ClinicProfileBooking extends StatefulWidget {
  const ClinicProfileBooking({
    Key? key,
  }) : super(key: key);

  @override
  _ClinicProfileBookingState createState() => _ClinicProfileBookingState();
}

bool isExpanded = false;

class _ClinicProfileBookingState extends State<ClinicProfileBooking>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
        controller: ScrollController(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
                bottom: TabBar(
                  padding: EdgeInsets.only(right: screenSize.width * 0.32),
                  indicatorColor: AppColors.profileEnabled,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: AppColors.profileEnabled,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(
                      color: AppColors.profileEnabled,
                      fontWeight: FontWeight.w600),
                  labelStyle: TextStyle(
                    color: AppColors.profileEnabled,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: tabController,
                  tabs: const <Widget>[
                    Tab(
                      child: Text(
                        'Basic information',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Services',
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                excludeHeaderSemantics: true,
                expandedHeight: 380,
                pinned: true,
                floating: true,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(PaddingSize.small),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          // border: Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.keyboard_backspace,
                        size: 24,
                      )),
                ),
                actions: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(PaddingSize.small),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          // border: Border.all(width: 1, color: AppColors.backBorder),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/icons/forward.svg'),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: SizedBox(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 253,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            // stretchModes: const [StretchMode.blurBackground],
                            child: Image.asset(
                              'assets/images/fill.png',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 180,
                            ),
                            // Image.asset("assets/images/rounded.png"),
                            clinicCard(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ];
        },
        body: body(),
      ),
    );
  }

  Widget body() => TabBarView(
        controller: tabController,
        children: [
          basicInformation(),
          services(),
        ],
      );

  Padding services() {
    return Padding(
      padding: const EdgeInsets.all(PaddingSize.extraLarge),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              HeadingTitleText(
                  fontSize: FontSize.extraLarge, title: 'Dermatology services'),
            ],
          ),
          bookingList(6),
          Row(
            children: [
              HeadingTitleText(
                  fontSize: FontSize.extraLarge, title: 'Dermatology services'),
            ],
          ),
          bookingList(3),
        ],
      ),
    );
  }

  Widget bookingList(int listCount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PaddingSize.extraLarge),
      child: Column(
        children: List.generate(listCount, (index) {
          return ListTile(
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: AppColors.orangeShadow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                primary: Colors.white,
                side: BorderSide(color: AppColors.orange),
              ),
              onPressed: () {
                final snackBar = SnackBar(
                    backgroundColor: AppColors.orange,
                    content: Text(
                      'We will be right back in a moment',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: HeadingTitleText(
                fontSize: FontSize.normal,
                title: 'Book',
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
            tileColor: index % 2 == 0 ? AppColors.greyBackground : Colors.white,
            title: HeadingTitleText(
              padding: 0,
              fontSize: FontSize.normal,
              title: 'Skin allergy',
              fontWeight: FontWeight.w400,
            ),
            subtitle: RichText(
              text: TextSpan(
                  text: 'Price : ',
                  style: TextStyle(
                      fontSize: FontSize.small,
                      fontWeight: FontWeight.w400,
                      color: AppColors.profileEnabled),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Rs. 1250',
                      style: TextStyle(
                          fontSize: FontSize.small,
                          fontWeight: FontWeight.w700,
                          color: AppColors.profileEnabled),
                    )
                  ]),
            ),
          );
        }),
      ),
    );
  }

  Widget basicInformation() {
    return ListView(
      // physics: ClampingScrollPhysics(),
      children: [
        FieldCards(
          columnWidgets: [
            Wrap(
              children: [
                AnimatedSize(
                  // ignore: deprecated_member_use
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  child: ConstrainedBox(
                    constraints: isExpanded
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 50.0),
                    child: Text(
                      'Ive time had hall was albions his. Fathers albions companie aye he he long his. Mammon is or of little though neer upon. Adieu but she at grace, bower a from bower was hour deemed where his, night seek to in congealed sighed the known the brow. Disappointed now if did the land now one, counsel her parting and grief riot steel him. Was deeds only childe though. To but would one dote mote a mirth it and, the rhyme fabled would and, a these from though cared memory was womans, ever in know sister loved done, and waste from.',
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                isExpanded
                    ? TextButton(
                        onPressed: () => setState(() => isExpanded = false),
                        child: Text(
                          'Read less',
                          style: TextStyle(color: AppColors.orange),
                        ))
                    : TextButton(
                        onPressed: () => setState(() => isExpanded = true),
                        child: Text(
                          'Read more',
                          style: TextStyle(color: AppColors.orange),
                        ))
              ],
            ),
          ],
          cardTitle: 'About',
          headerPadding: PaddingSize.normal,
        ),
        FieldCards(columnWidgets: [
          ConstrainedBox(
            constraints: BoxConstraints(),
            child: HeadingTitleText(
              fontSize: FontSize.normal,
              title:
                  'M-14, M-Block Market, Greater Kailash - II Saint Albans, NY 11412',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.watch_later_rounded,
                  color: AppColors.profileEnabled,
                ),
              ),
              HeadingTitleText(
                fontSize: FontSize.normal,
                title: '09:00 am - 06:00 pm',
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/orangeCall.svg'),
              ),
              HeadingTitleText(
                fontSize: FontSize.normal,
                title: '011 41632464',
                color: AppColors.orange,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/orangeMail.svg'),
              ),
              HeadingTitleText(
                fontSize: FontSize.normal,
                title: 'gk.dl@vlccwellness.com',
                color: AppColors.orange,
              ),
            ],
          ),
        ], cardTitle: 'Contact details'),
        // Padding(
        //   padding: const EdgeInsets.all(PaddingSize.extraLarge),
        //   child: Placeholder(),
        // ),
      ],
    );
  }

  Widget clinicCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        shadowColor: Colors.black26,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 24, 0),
              child: Image.asset("assets/images/rounded.png"),
            ),
            SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: HeadingTitleText(
                          fontSize: FontSize.heading,
                          title: 'Safe health clinic'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: HeadingTitleText(
                          fontSize: FontSize.normal,
                          fontWeight: FontWeight.w600,
                          title: 'Safety and Grooming'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: HeadingTitleText(
                          fontSize: FontSize.normal,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          title: 'Mayur Vihar, Delhi'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          RichText(
                            text: TextSpan(
                              text: ' 4.8 ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.profileEnabled,
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: '(1387 Feedback)',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

// InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//               padding: EdgeInsets.all(PaddingSize.small),
//               decoration: BoxDecoration(
//                   border: Border.all(width: 1, color: AppColors.backBorder),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Icon(
//                 Icons.keyboard_backspace,
//                 size: 24,
//               )),
//         ),
