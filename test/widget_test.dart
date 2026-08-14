import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter/features/counter/presentation/bloc/counter_bloc.dart';

void main() {
  test('counter preserves increment, decrement, and reset behavior', () async {
    final bloc = CounterBloc();
    final states = <int>[];
    final subscription = bloc.stream.listen((state) => states.add(state.value));

    bloc
      ..add(const CounterEvent.increment())
      ..add(const CounterEvent.reset())
      ..add(const CounterEvent.decrement());
    await bloc.close();
    await subscription.cancel();

    expect(states, [1, 0, -1]);
  });
}
