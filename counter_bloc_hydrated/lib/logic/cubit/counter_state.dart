part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncremented;

  const CounterState({required this.counterValue, this.wasIncremented = false});

  @override
  List<Object> get props => [counterValue, wasIncremented];

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'],
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) => CounterState.fromMap(json.decode(source));
}
