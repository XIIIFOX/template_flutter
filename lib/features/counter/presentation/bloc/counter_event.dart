part of 'counter_bloc.dart';

@freezed
abstract class CounterEvent with _$CounterEvent {
  const factory CounterEvent.increment() = CounterIncrement;
  const factory CounterEvent.decrement() = CounterDecrement;
  const factory CounterEvent.reset() = CounterReset;
}
