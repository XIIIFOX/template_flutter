part of 'example_bloc.dart';

@freezed
abstract class ExampleEvent with _$ExampleEvent {
  const factory ExampleEvent.getExampleData() = GetExampleDataRequested;
  const factory ExampleEvent.refreshExampleData() = RefreshExampleDataRequested;
}
