import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/services/token_model.dart';

import '../../../../core/error/midtrans_failures.dart';

class TokenService {
  Future<Either<Failure, TokenModel>> getToken() async {
    var apiUrl = dotenv.env['BASE_URL'] ?? '';

    var payload = {
      "id": DateTime.now().millisecondsSinceEpoch, // Unique Id
      "productName": "Motor Udara",
      "price": 12500,
      "quantity": 1
    };

    try {
      var response = await GetIt.instance<Dio>().post(
        apiUrl,
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {

        return right(TokenModel(token: response.data['token']));
      } else {
        return left(ServerFailure(
            data: response.data,
            code: response.statusCode ?? 500,
            message: 'Unknown Error'));
      }
    } catch (e) {
      return left(ServerFailure(
          data: e.toString(), code: 400, message: 'Unknown Error'));
    }
  }
}
