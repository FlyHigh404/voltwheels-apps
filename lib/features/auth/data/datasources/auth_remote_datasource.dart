import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/features/auth/data/models/user_model.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_login.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_register.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> registerWithEmailPassword(UserRegisterParams params);

  Future<UserModel> loginWithEmailPassword(UserLoginParams params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> loginWithEmailPassword(UserLoginParams params) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return UserModel(id: '1', email: params.email, name: 'Nico');
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword(UserRegisterParams params) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return UserModel(id: '12', email: params.email, name: params.name);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
