import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer_test/bloc/user_bloc.dart';
import 'package:prayer_test/model/prayer_iteme.dart';
import 'package:prayer_test/model/prayer_response.dart';
import 'package:prayer_test/model/user.dart';
import 'package:prayer_test/model/user_response.dart';
import 'package:prayer_test/repository/user_api_provider.dart';

class UserWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserWidgetState();
  }
}

class _UserWidgetState extends State<UserWidget> {
  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PrayerResponse>( // UserResponse
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<PrayerResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Loading data from API...",
            style: Theme.of(context).textTheme.subtitle),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error",
            style: Theme.of(context).textTheme.subtitle),
      ],
    ));
  }

  Widget _buildUserWidget(PrayerResponse data) {
    PrayerItem user = data.results[0]; // User
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
           icon: Icon(Icons.info_outline),
           onPressed: (){
            // call getInformation methode
             UserApiProvider().getInformation();
          }),
//          CircleAvatar(
//            radius: 70,
//            backgroundImage: NetworkImage(user.Midnight,),
//          ),
          Text(
            "${_capitalizeFirstLetter(user.Midnight)} ${_capitalizeFirstLetter(user.Isha,)}",
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            user.Maghrib,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5,
            ),
          ),
          Text(
            user.Sunset +
                ", " +
                user.Asr,
            style: Theme.of(context).textTheme.body1,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5,
            ),
          ),
          Text(
            user.Imsak,
            style: Theme.of(context).textTheme.body1,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5,
            ),
          ),
          Text(
            user.Fajr,
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ),
    );
  }

  _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(0, text.length);
  }
}
