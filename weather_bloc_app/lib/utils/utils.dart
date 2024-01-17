import 'dart:ui';
import 'package:flutter/material.dart';

Color baseShimmerColor = const Color(0x6F868686);
Color highlightShimmerColor = const Color(0x6FA7A7A7);

class StandardBodyWidget extends StatelessWidget {
  const StandardBodyWidget({
    super.key,
    required this.bodyWidget,
    required this.onRefresh,
  });

  final Widget bodyWidget;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 1.2 * kToolbarHeight, 30, 20),
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Colors.lightBlueAccent),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -0.3),
                child: Container(
                  height: 300,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              bodyWidget,
            ],
          ),
        ),
      ),
    );
  }
}

Widget getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300:
      return Image.asset('assets/1.png');
    case >= 300 && < 400:
      return Image.asset('assets/2.png');
    case >= 500 && < 600:
      return Image.asset('assets/3.png');
    case >= 600 && < 700:
      return Image.asset('assets/4.png');
    case >= 700 && < 800:
      return Image.asset('assets/5.png');
    case == 800:
      return Image.asset('assets/6.png');
    case > 800 && <= 804:
      return Image.asset('assets/7.png');
    default:
      return Image.asset('assets/7.png');
  }
}

String getGreetings() {
  final DateTime now = DateTime.now();

  switch (now.hour) {
    case >= 5 && < 13:
      return 'Good Morning';
    case >= 13 && < 18:
      return 'Good Afternoon';
    case >= 18 && < 22:
      return 'Good Evening';
    case >= 22 || >= 0 && < 5:
      return 'Good Night';
    default:
      return 'Good Morning';
  }
}
