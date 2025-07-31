import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/features/auth/domain/entities/user.dart';

import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_login.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_register.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailPassword(UserLoginParams params);

  Future<Either<Failure, User>> registerWithEmailPassword(
      UserRegisterParams params);
}
