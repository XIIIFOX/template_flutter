part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  const factory CounterEvent.increment() = CounterIncrement;
  const factory CounterEvent.decrement() = CounterDecrement;
  const factory CounterEvent.reset() = CounterReset;
}

final class CounterIncrement extends CounterEvent {
  const CounterIncrement();

  @override
  List<Object> get props => const [];
}

final class CounterDecrement extends CounterEvent {
  const CounterDecrement();

  @override
  List<Object> get props => const [];
}

final class CounterReset extends CounterEvent {
  const CounterReset();

  @override
  List<Object> get props => const [];
}
