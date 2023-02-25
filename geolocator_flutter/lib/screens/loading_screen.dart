
import 'package:flutter/material.dart';
import 'package:geolocator_flutter/services/location.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
 
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
  
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
     getData();
  }
  void getLocation() async {
    Location location=Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }
 void getData()async {
    String baseUrl='https://api.openweathermap.org/data/2.5/weather?q=London&appid=b937abbf9dc05d5ca708b797a8388924';
    Uri weatherUrl = Uri.parse(baseUrl);
    http.Response response = await http.get(weatherUrl);
   if(response.statusCode==200){
    String data=response.body;
    // var longitude=jsonDecode(data)['coord']['lon'];
    // print(longitude);
    // var weatherDescrp=jsonDecode(data)['weather'][0]['description'];
    // print(weatherDescrp);
    var jsonData=jsonDecode(data);
    var temperature= jsonData['main']['temp'];
    var condition= jsonData['weather'][0]['id'];
    var cityName= jsonData(data)['name'];
    print(cityName);
   }else{
   print(response.statusCode);
   
   }
 }

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       //Get the current location
      //       getLocation();
      //     },
      //     child: Text('Get Location'),
      //   ),
      // ),
    );
  }
}