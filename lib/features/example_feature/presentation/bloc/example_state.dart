part of 'example_bloc.dart';

sealed class ExampleState extends Equatable {
  const ExampleState();

  const factory ExampleState.initial() = ExampleInitial;
  const factory ExampleState.loading() = ExampleLoading;
  const factory ExampleState.loaded(List<ExampleEntity> data) = ExampleLoaded;
  const factory ExampleState.error(Failure failure) = ExampleError;
}

final class ExampleInitial extends ExampleState {
  const ExampleInitial();

  @override
  List<Object> get props => const [];
}

final class ExampleLoading extends ExampleState {
  const ExampleLoading();

  @override
  List<Object> get props => const [];
}

final class ExampleLoaded extends ExampleState {
  const ExampleLoaded(this.data);

  final List<ExampleEntity> data;

  @override
  List<Object> get props => const [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExampleLoaded && listEquals(other.data, data);

  @override
  int get hashCode => Object.hashAll(data);
}

final class ExampleError extends ExampleState {
  const ExampleError(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
