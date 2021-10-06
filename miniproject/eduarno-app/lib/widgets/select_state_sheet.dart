import 'package:eduarno/repo/bloc/profile/model/location_state.dart';
import 'package:flutter/material.dart';

class SelectLocationStateBottomSheet extends StatelessWidget {
  final List<LocationState> options;
  final void Function(String, String) onSelected;
  final String title;

  const SelectLocationStateBottomSheet(
      {Key key, this.onSelected, @required this.options, this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.1),
      child: options == null || options.isEmpty
          ? ListTile(
              onTap: () => Navigator.pop(context),
              title: Text(
                'No Item Found!',
                style: TextStyle(color: Colors.red),
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                //   child: Text(
                //     title,
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                //   ),
                // ),
                for (LocationState option in options)
                  ListTile(
                    onTap: () => onSelected(option.state, option.stateId),
                    title: Text(option.state),
                  )
              ],
            ),
    );
  }
}
