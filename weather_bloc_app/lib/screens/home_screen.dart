import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_bloc_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_bloc_app/bloc/weather_event.dart';
import 'package:weather_bloc_app/bloc/weather_state.dart';
import 'package:weather_bloc_app/screens/watchlist_screen.dart';
import 'package:weather_bloc_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? position;

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: StandardBodyWidget(
        onRefresh: () async {
          if (position != null) {
            BlocProvider.of<WeatherBlocBloc>(context).add(FetchWeather(position!));
          }
        },
        bodyWidget: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
          builder: (context, state) {
            if (state is WeatherBlocSuccess) {
              String greetings = getGreetings();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 ${state.weather.areaName}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            greetings,
                            style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        color: Colors.red,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.black12,
                          padding: const EdgeInsets.all(12),
                        ),
                        icon: const Icon(
                          Icons.reorder,
                          size: 27,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WatchlistScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  getWeatherIcon(state.weather.weatherConditionCode!),
                  Center(
                    child: Text(
                      '${state.weather.temperature!.celsius!.round()}°C',
                      style: const TextStyle(color: Colors.white, fontSize: 55, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: Text(
                      state.weather.weatherMain!.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/11.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sunrise',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                DateFormat().add_jm().format(state.weather.sunrise!),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/12.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sunset',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                DateFormat().add_jm().format(state.weather.sunset!),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Image.asset(
                          'assets/13.png',
                          scale: 8,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Temp Max',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${state.weather.tempMax!.celsius!.round()} °C",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ]),
                      Row(children: [
                        Image.asset(
                          'assets/14.png',
                          scale: 8,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Temp Min',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${state.weather.tempMin!.celsius!.round()} °C",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ])
                    ],
                  ),
                ],
              );
            } else if (state is WeatherBlocFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/error.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Error getting the weather data, please try again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (position != null) {
                        BlocProvider.of<WeatherBlocBloc>(context).add(FetchWeather(position!));
                      }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black12)),
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Reload',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            } else {
              return const LoadingWeatherScreen();
            }
          },
        ),
      ),
    );
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position pos = await Geolocator.getCurrentPosition();

    setState(() {
      position = pos;
    });

    if (!mounted) return;
    BlocProvider.of<WeatherBlocBloc>(context).add(FetchWeather(pos));
  }
}

class LoadingWeatherScreen extends StatelessWidget {
  const LoadingWeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              color: Colors.grey,
              width: 150,
              height: 20,
            ),
          ),
          const SizedBox(height: 50),
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
          const SizedBox(height: 30),
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          const SizedBox(height: 30),
          Shimmer.fromColors(
            baseColor: baseShimmerColor,
            highlightColor: highlightShimmerColor,
            child: Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
        ],
      ),
    );
  }
}
