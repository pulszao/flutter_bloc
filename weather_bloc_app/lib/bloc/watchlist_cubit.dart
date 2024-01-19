import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends HydratedCubit<WatchlistState> {
  WatchlistCubit() : super(const WatchlistState(watchlist: []));

  void addCity(String data) {
    List<String> watchlist = List.from(state.watchlist);
    watchlist.add(data);

    emit(
      WatchlistState(watchlist: watchlist),
    );
  }

  void removeCity(String data) {
    List<String> watchlist = state.watchlist;
    watchlist.remove(data);

    emit(
      WatchlistState(watchlist: watchlist),
    );
  }

  @override
  WatchlistState? fromJson(Map<String, dynamic> json) {
    return WatchlistState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(WatchlistState state) {
    return state.toMap();
  }
}
