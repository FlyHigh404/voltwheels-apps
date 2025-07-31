import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_order.dart';

abstract class VoltRentOrderRepository {
  Future<Either<Failure, List<VoltRentOrder>>> getUserOrder(String userId);
}