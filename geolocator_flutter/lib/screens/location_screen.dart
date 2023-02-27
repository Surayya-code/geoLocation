import 'package:flutter/material.dart';
import 'package:geolocator_flutter/screens/city_screen.dart';
import 'package:geolocator_flutter/services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key,
   this.locationWeather});

  final dynamic locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String notification;

   @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData==null){
        temperature=0;
        weatherIcon='Error';
        notification='Unable to get weather data';
        cityName='';
        return;
      }
      cityName= weatherData['name'];
      double temp=weatherData['main']['temp'];
      temperature= temp.toInt();
      var condition= weatherData['weather'][0]['id'];
      weatherIcon=weather.getWeatherIcon(condition);
      notification=weather.getMessage(temperature);
      print(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/bright.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData=await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedname=await Navigator.push(context, MaterialPageRoute(builder: (context){
                         return const CityScreen();
                      }));
                      if(typedname!=null){
                      var weatherData=await weather.getCityWeather(typedname);
                      updateUI(weatherData);
                      }
                     // print(typedname);
                    },
                    child: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children:  [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding:const EdgeInsets.only(right: 15.0),
                child: Text(
                 // "It's 🍦 time in San Francisco!"
                 '$notification in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}