import 'dart:convert';


import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart'as http;

class weatherService{

  static const base_url='http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  weatherService({required this.apiKey});

  Future<weatherModel> getWeather(String cityName) async{
    final response=await http.get(Uri.parse('$base_url?q=$cityName&appid=$apiKey&units=metric'));

    if(response.statusCode==200){

      return weatherModel.fromJson(jsonDecode(response.body));

    }else{
      throw "failed to load weather data";
    }
  }

  Future<String> getCurrentCity() async{
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }


    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMark=await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city=placeMark[0].locality;

    return city?? "";

  }

}