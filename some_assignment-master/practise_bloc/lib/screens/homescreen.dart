import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_bloc/blocs/profilebloc/profile_bloc.dart';
import 'package:practise_bloc/blocs/profilebloc/profile_event.dart';
import 'package:practise_bloc/blocs/profilebloc/profile_state.dart';
import 'package:practise_bloc/model/profile/profileDetails.dart';
import 'package:practise_bloc/widgets/profile_widgets.dart/id_card.dart';

class ShowProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _proflieBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoad) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.cyan)),
          );
        }
        if (state is ProfileInitial) {
          _proflieBloc.add(ProfileLoading());
        }
        return Scaffold(
            body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                if (state is ProfileSuccess) ...{
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        ProfileDetails profileDetails =
                            ProfileDetails.fromJson(state.data.toJson());
                        return Column(
                          children: <Widget>[
                            IdCard(profileDetails: profileDetails),
                          ],
                        );
                      }),
                }
              ],
            ),
          ),
        ));
      },
    );
  }
}
