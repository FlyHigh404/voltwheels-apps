import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:voltwheels_mobile/features/auth/domain/entities/user.dart';
import 'package:voltwheels_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_login.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_register.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      UserLoginParams params) async {
    try {
      final response =
          await authRemoteDataSource.loginWithEmailPassword(params);

      return right(response);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailPassword(
      UserRegisterParams params) async {
    try {
      final response =
          await authRemoteDataSource.registerWithEmailPassword(params);

      return right(response);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }
}
