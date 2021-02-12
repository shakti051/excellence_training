import 'package:feedback/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _search = TextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .6,
          margin: EdgeInsets.only(left: 16, top: 16, right: 60),
          height: 40,
          child: TextFormField(
            controller: _search,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(18.0),
                ),
              ),
              labelText: 'Search',
              suffixIcon: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.BACKGROUND_COLOR,
                  child: Icon(Icons.search)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(8, 16, 0, 16),
                child: Image.asset('assets/images/alert.png')),
            Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Image.asset('assets/images/msg.png')),
          ],
        ),
      ],
    );
  }
}
