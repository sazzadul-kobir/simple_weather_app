
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage> {
  
   final weatherservice=weatherService(apiKey: '####');
   weatherModel? weather;

   Future _fetchWeather() async{
     String cityName=await weatherservice.getCurrentCity();


     try{
       final Weather=await weatherservice.getWeather(cityName);

       setState(() {
         weather=Weather;
       });
     }catch(e){
       print(e);
     }

   }

   getWeatherAnimation(String? mainCondion){
    if(mainCondion==null) return 'assets/sunny.json';

    switch(mainCondion.toLowerCase()){
      case'clouds':
      case'mist':
      case'smoke':
      case'haze':
      case'dust':
      case'fog':
        return 'assets/cloud.json';
      case'rain':
      case'drizzle':
      case'shower rain':
        return 'assets/rain.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';

    }

   }




   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();

  }
  
  @override
  Widget build(BuildContext context) {


    return Scaffold (
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            Text(weather?.cityName ?? "city..."),
           Lottie.asset(getWeatherAnimation(weather?.mainCondition)),
          Text('${weather?.temperature.round().toString()}C'??"temp...")
          ],
        ),
      ),
    );
  }
}
