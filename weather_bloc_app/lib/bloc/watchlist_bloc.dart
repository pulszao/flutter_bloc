import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchlistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
