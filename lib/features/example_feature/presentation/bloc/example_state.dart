part of 'example_bloc.dart';

@freezed
abstract class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = ExampleInitial;
  const factory ExampleState.loading() = ExampleLoading;
  const factory ExampleState.loaded(List<ExampleEntity> data) = ExampleLoaded;
  const factory ExampleState.error(Failure failure) = ExampleError;
}
