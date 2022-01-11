import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/widgets/gradient_button.dart';

class LocationBottomBar extends StatelessWidget {
  const LocationBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Change Location",
                      style: TextStyle(
                          fontFamily: FontName.frutinger,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.large)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: Colors.grey))
                ],
              ),
              SizedBox(height: 20),
              Divider(color: AppColors.backBorder, thickness: 1.0),
              SizedBox(height: 24),
              Text("Location",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              SizedBox(height: 10),
              Container(
                  //   height: 48,
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
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Search city...'),
                      keyboardType: TextInputType.text)),
              SizedBox(height: 24),
              Text("Preferred Range",
                  style: TextStyle(
                      fontFamily: FontName.frutinger,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.normal)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(40)),
                    child: Text("< 5km",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(40)),
                    child: Text("< 30km",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(40)),
                    child: Text("< 50km",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(40)),
                    child: Text("< 50-100km",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.normal)),
                  ),
                ],
              ),
              SizedBox(height: 26),
              GradientButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Update",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.large,
                            color: Colors.white)),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
