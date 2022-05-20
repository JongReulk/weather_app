import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, this.parseWeatherData, this.parseAirPollution}) : super(key: key);

  final parseWeatherData;
  final parseAirPollution;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String cityName;
  late int temp;
  late Widget icon;
  late String description;
  late Widget airIcon;
  late Widget airState;
  var date = DateTime.now();
  late double pm2_5;
  late double pm10;

  @override
  initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    description = weatherData['weather'][0]['description'];
    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    //print(description);
    double temp2 = weatherData['main']['temp'];
    temp = temp2.round();
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    pm10 = airData['list'][0]['components']['pm10']; // 미세먼지 농도
    pm2_5 = airData['list'][0]['components']['pm2_5']; // 초미세먼지 농도

    //print(temp);
    //print(cityName);
    print(pm2_5);
    print(pm10);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.near_me),
            iconSize: 30.0,
          ),
        ),
        title: Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_searching),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Text(
                                '$cityName',
                                style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic((Duration(minutes: 1)),
                                      builder: (context) {
                                    //print('${getSystemTime()}');
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16, color: Colors.white),
                                    );
                                  }),
                                  Text(DateFormat(' - EEEE, ').format(date),
                                      style: GoogleFonts.lato(
                                          fontSize: 16, color: Colors.white)),
                                  Text(
                                    DateFormat('d MMM, yyy').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$temp\u2103',
                                style: GoogleFonts.lato(
                                  fontSize: 85,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  icon,
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(description,
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          height: 15.0,
                          thickness: 2.0,
                          color: Colors.white30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'AQI(대기질지수)',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                airIcon,
                                SizedBox(
                                  height: 10,
                                ),
                                airState
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  pm10.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '㎍/m3',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  pm2_5.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '㎍/m3',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  // Widget CityandDay(){
  //   return
  // }
}
