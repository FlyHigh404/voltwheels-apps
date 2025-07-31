import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/core/usecase/usecase.dart';
import 'package:voltwheels_mobile/features/auth/domain/entities/user.dart';
import 'package:voltwheels_mobile/features/auth/domain/repositories/auth_repository.dart';

class UserRegister implements UserCase<User, UserRegisterParams> {
  final AuthRepository authRepository;

  UserRegister(this.authRepository);

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.registerWithEmailPassword(params);
  }
}

class UserRegisterParams {
  final String name;
  final String email;
  final String password;

  const UserRegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
