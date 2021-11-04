import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location for the UI
  late String time; // time in that location
  String flag; // flag corresponding to that location
  String url; // url location for fetching the data from the API
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //request the data from the API
      Response rep =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map myData = jsonDecode(rep.body);

      //extract the properties from the data
      String dateTime = myData['datetime'];
      String offset = myData['utc_offset'].substring(1, 3);

      //extract the time
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      //set the tiome property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caugth the error $e');
      time = 'couldn\'t fetch the data from API';
    }
  }
}
