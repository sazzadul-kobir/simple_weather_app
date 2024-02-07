
import 'package:flutter/foundation.dart';

class weatherModel{
  String cityName;
  double temperature;
  String mainCondition;

  weatherModel({required this.cityName,required this.temperature, required this.mainCondition});

  factory weatherModel.fromJson(Map<String, dynamic> json){
    return weatherModel(
        cityName: json['name'],
        temperature: json['main']['temp'],
        mainCondition: json['weather'][0]['main']
    );
  }
}