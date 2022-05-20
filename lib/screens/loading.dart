import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '47e5849aa6e840d8c3ed763847ed0fab';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double longitude3;
  late double latitude3;

  @override
  initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }

  Future<void> getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric');

    var weather_data = await network.getJsonData();
    print(weather_data);

    var air_data = await network.getAirData();
    print(air_data);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => WeatherScreen(
              parseWeatherData: weather_data,
              parseAirPollution: air_data,
            )));
  }

// void fetchData() async{
//   http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
//   if(response.statusCode == 200) {
//     String jsonData = response.body;
//     var myJson = jsonDecode(jsonData)['wind']['speed'];
//     var myJson2 = jsonDecode(jsonData)['id'];
//     print(myJson);
//     print(myJson2);
//   }
//   else {
//     print(response.statusCode);
//   }
//   //print(response.body);
// }
}
