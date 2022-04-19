import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI
  var time; // the time in that location
  String flag; //url to an asset flag icon
  String url; //location url
  late bool isDayTime; // true or false if daytime or not

  WorldTime({required this.location,  required this.flag, required this.url});

  Future<void> getTime() async{

    try {
      Response response = await get(
          "https://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);
      // print(data['utc_offset']);

      // get properties from data
      String datetime = data['datetime'];
      String hour_offset = data['utc_offset'].substring(1, 3);
      String minute_offset = data['utc_offset'].substring(4);
      // print(datetime);
      // print('$hour_offset, $minute_offset');

      // Create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(hour_offset),minutes: int.parse(minute_offset)));

      // Set the time property
      isDayTime = now.hour > 6 && now.hour < 17 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print("Caught error: $e");
      time = "Could not get time data";
    }
  }

}

