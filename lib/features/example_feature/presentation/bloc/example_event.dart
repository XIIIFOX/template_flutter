part of 'example_bloc.dart';

sealed class ExampleEvent extends Equatable {
  const ExampleEvent();

  const factory ExampleEvent.getExampleData() = GetExampleDataRequested;
  const factory ExampleEvent.refreshExampleData() = RefreshExampleDataRequested;
}

final class GetExampleDataRequested extends ExampleEvent {
  const GetExampleDataRequested();

  @override
  List<Object> get props => const [];
}

final class RefreshExampleDataRequested extends ExampleEvent {
  const RefreshExampleDataRequested();

  @override
  List<Object> get props => const [];
}
