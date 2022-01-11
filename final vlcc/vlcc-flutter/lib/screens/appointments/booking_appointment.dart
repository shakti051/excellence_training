import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlcc/components/package_name.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/appointments/subscribed_packages.dart';
import 'package:vlcc/widgets/appointment_widgets/appointment_widgets.dart';

class BookingAppointment extends StatelessWidget {
  const BookingAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 24),
                Text("Book Appointment",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading)),
                SizedBox(height: 8),
                SearchAppointmentLocation(),
                SizedBox(height: 20),
                Container(
                  //height: 48,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black54),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'Search location, clinic, speciality'),
                      keyboardType: TextInputType.text),
                ),
                SizedBox(height: 32),
                Text("Subscribed packages (s)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: FontSize.large)),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubscribedPackages()),
                      );
                    },
                    child: PackageName()),
                SizedBox(height: 20),
                PopularSpecialityAppointment(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
