import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_bloc_app/bloc/watchlist_cubit.dart';
import 'package:weather_bloc_app/utils/utils.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: StandardBodyWidget(
          onRefresh: () async {},
          bodyWidget: BlocBuilder<WatchlistCubit, WatchlistState>(
            builder: (context, state) {
              List<Widget> citiesWidget = [];
              for (String city in state.watchlist) {
                citiesWidget.add(Text(city));
              }

              return Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 45,
                    width: 360,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      onFieldSubmitted: (data) {
                        BlocProvider.of<WatchlistCubit>(context).addCity(data);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff1f1f1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 25),
                        hintText: "Search for Items",
                        hintStyle: TextStyle(color: Colors.grey.shade700),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Column(
                    children: citiesWidget,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoadingWatchlist extends StatelessWidget {
  const LoadingWatchlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          6,
          (index) => Column(
            children: [
              Shimmer.fromColors(
                baseColor: baseShimmerColor,
                highlightColor: highlightShimmerColor,
                child: Container(
                  color: Colors.grey,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
