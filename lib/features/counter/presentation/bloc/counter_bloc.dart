import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState.initial(0)) {
    on<CounterEvent>((event, emit) {
      switch (event) {
        case CounterIncrement():
          _onIncrement(emit);
        case CounterDecrement():
          _onDecrement(emit);
        case CounterReset():
          _onReset(emit);
      }
    });
  }

  void _onIncrement(Emitter<CounterState> emit) {
    final currentValue = state.value;
    emit(CounterState.initial(currentValue + 1));
  }

  void _onDecrement(Emitter<CounterState> emit) {
    final currentValue = state.value;
    emit(CounterState.initial(currentValue - 1));
  }

  void _onReset(Emitter<CounterState> emit) {
    emit(const CounterState.initial(0));
  }
}

extension CounterStateExtension on CounterState {
  int get value => switch (this) { CounterInitial(:final value) => value };
}
