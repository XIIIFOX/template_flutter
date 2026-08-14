part of 'counter_bloc.dart';

sealed class CounterState extends Equatable {
  const CounterState();

  const factory CounterState.initial(int value) = CounterInitial;
}

final class CounterInitial extends CounterState {
  const CounterInitial(this.value);

  final int value;

  @override
  List<Object> get props => [value];
}
