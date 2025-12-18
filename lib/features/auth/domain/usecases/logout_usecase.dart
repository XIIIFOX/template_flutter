import 'package:dartz/dartz.dart';
import 'package:template_flutter/core/error/failures.dart';
import 'package:template_flutter/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}

