import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/core/usecase/usecase.dart';
import 'package:voltwheels_mobile/features/auth/domain/entities/user.dart';
import 'package:voltwheels_mobile/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements UserCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.loginWithEmailPassword(params);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });
}
