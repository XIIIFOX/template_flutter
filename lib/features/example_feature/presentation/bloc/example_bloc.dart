import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_flutter/features/example_feature/domain/usecases/get_example_data.dart';

import 'package:template_flutter/core/error/failures.dart';
import 'package:template_flutter/features/example_feature/domain/entities/example_entity.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final GetExampleData getExampleData;

  ExampleBloc({required this.getExampleData})
      : super(const ExampleState.initial()) {
    on<ExampleEvent>((event, emit) async {
      switch (event) {
        case GetExampleDataRequested():
          await _onGetExampleData(emit);
        case RefreshExampleDataRequested():
          await _onRefreshExampleData(emit);
      }
    });
  }

  Future<void> _onGetExampleData(Emitter<ExampleState> emit) async {
    emit(const ExampleState.loading());
    final result = await getExampleData(NoParams());
    result.fold(
      (failure) => emit(ExampleState.error(failure)),
      (data) => emit(ExampleState.loaded(data)),
    );
  }

  Future<void> _onRefreshExampleData(Emitter<ExampleState> emit) async {
    emit(const ExampleState.loading());
    final result = await getExampleData(NoParams());
    result.fold(
      (failure) => emit(ExampleState.error(failure)),
      (data) => emit(ExampleState.loaded(data)),
    );
  }
}

extension ExampleStateMatching on ExampleState {
  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ExampleEntity> data)? loaded,
    T Function(Failure failure)? error,
    required T Function() orElse,
  }) =>
      switch (this) {
        ExampleInitial() when initial != null => initial(),
        ExampleLoading() when loading != null => loading(),
        ExampleLoaded(:final data) when loaded != null => loaded(data),
        ExampleError(:final failure) when error != null => error(failure),
        _ => orElse(),
      };
}
