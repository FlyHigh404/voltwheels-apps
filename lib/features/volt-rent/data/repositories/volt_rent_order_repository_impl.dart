import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/features/volt-rent/data/datasources/volt_rent_order_remote_datasource.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_order.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/repositories/volt_rent_order_repository.dart';

class VoltRentOrderRepositoryImpl implements VoltRentOrderRepository {
  final VoltRentOrderRemoteDatasource voltRentOrderRemoteDatasource;

  VoltRentOrderRepositoryImpl(this.voltRentOrderRemoteDatasource);

  @override
  Future<Either<Failure, List<VoltRentOrder>>> getUserOrder(
      String userId) async {
    try {
      final response = await voltRentOrderRemoteDatasource.getOrder(userId);

      return right(response);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? ""));
    }
  }
}
