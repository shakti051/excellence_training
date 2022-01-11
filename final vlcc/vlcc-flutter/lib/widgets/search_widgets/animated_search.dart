import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/resources/app_colors.dart';

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({Key? key}) : super(key: key);

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  final TextEditingController searchController = TextEditingController();
  var _isfolded = true;

  void runFilter(
      {required String enteredKeyword,
      required DatabaseHelper databaseHelper}) {
    var serviceList = databaseHelper.serviceMasterDbList;
    databaseHelper.serviceFilterList = serviceList;
    List<ServiceMasterDatabase> _filterService = [];
    if (enteredKeyword.trim().isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // results = serviceList;
      _filterService = databaseHelper.serviceMasterDbList;
    } else {
      _filterService = serviceList
          .where(
            (service) => service.serviceSubCategory2.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    databaseHelper.serviceFilterList = _filterService;
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = context.watch<DatabaseHelper>();
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _isfolded ? 56 : MediaQuery.of(context).size.width - 200,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: _isfolded
                  ? null
                  : TextField(
                      controller: searchController,
                      onChanged: (value) => runFilter(
                        databaseHelper: databaseProvider,
                        enteredKeyword: value,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: AppColors.orange,
                          overflow: TextOverflow.ellipsis,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_isfolded ? 32 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_isfolded ? 32 : 0),
                  bottomRight: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    _isfolded ? Icons.search : Icons.close,
                    color: AppColors.orange,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _isfolded = !_isfolded;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
