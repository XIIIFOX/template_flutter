import 'package:dartz/dartz.dart';
import 'package:template_flutter/core/error/failures.dart';
import 'package:template_flutter/features/example_feature/domain/entities/example_entity.dart';

abstract class ExampleRepository {
  Future<Either<Failure, List<ExampleEntity>>> getExampleData();
}
