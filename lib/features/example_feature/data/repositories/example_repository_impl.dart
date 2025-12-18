import 'package:dartz/dartz.dart';
import 'package:template_flutter/core/error/failures.dart';
import 'package:template_flutter/core/network/network_info.dart';
import 'package:template_flutter/features/example_feature/data/datasources/example_remote_datasource.dart';
import 'package:template_flutter/features/example_feature/domain/entities/example_entity.dart';
import 'package:template_flutter/features/example_feature/domain/repositories/example_repository.dart';

/// Реализация репозитория для примера
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ExampleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ExampleEntity>>> getExampleData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getExampleData();
        return Right(remoteData.map((model) => model.toEntity()).toList());
      } on ServerFailure catch (failure) {
        return Left(failure);
      } on NetworkFailure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure('Unexpected error: $e'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}


