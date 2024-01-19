part of 'watchlist_cubit.dart';

class WatchlistState extends Equatable {
  final List<String> watchlist;

  const WatchlistState({required this.watchlist});

  @override
  List<Object> get props => [watchlist];

  Map<String, dynamic> toMap() {
    return {
      'watchlist': watchlist,
    };
  }

  factory WatchlistState.fromMap(Map<String, dynamic> map) {
    return WatchlistState(
      watchlist: map['watchlist'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WatchlistState.fromJson(String source) => WatchlistState.fromMap(json.decode(source));
}
