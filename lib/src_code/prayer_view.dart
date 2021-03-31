import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer_test/bloc/user_bloc.dart';
import 'package:prayer_test/model/prayer_iteme.dart';
import 'package:prayer_test/model/prayer_response.dart';
import 'package:prayer_test/model/user.dart';
import 'package:prayer_test/model/user_response.dart';
import 'package:prayer_test/repository/user_api_provider.dart';
import 'package:prayer_test/src_code/api_provider.dart';

class PrayerWidget extends StatefulWidget {
  @override
  _PrayerWidgetState createState() => _PrayerWidgetState();
}

class _PrayerWidgetState extends State<PrayerWidget> {
  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  Future getList() async {
    var list_val = await PrayerProvider().getInformation();
    return list_val;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPrayerWidget();
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

  Widget _buildPrayerWidget() {
    return FutureBuilder(
        future: getList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTilePrayer(
                      time_prayer: snapshot.data[index].toString(),
                      index: index,
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(0, text.length);
  }
}

class ListTilePrayer extends StatelessWidget {
  final String time_prayer;
  final int index;
  const ListTilePrayer({
    Key key,
    this.index,
    this.time_prayer,
  }) : super(key: key);
  Text ChoicePrayer() {
    switch (index) {
      case 0:
        {
          return Text('Al Fajer');
        }
        break;
      case 1:
        {
          return Text('Imsake');
        }
        break;
      case 2:
        {
          return Text('Shorouk');
        }
        break;
      case 3:
        {
          return Text('Duhur');
        }
        break;
      case 4:
        {
          return Text('Asre');
        }
        break;
      case 5:
        {
          return Text('Maghribe');
        }
        break;
      case 6:
        {
          return Text('Isha');
        }
        break;
      case 7:
        {
          return Text('Midnight');
        }
        break;
      default:
        {
          return Text('');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        subtitle: Text(time_prayer.toString()),
        title: ChoicePrayer(),
      ),
    );
  }
}
