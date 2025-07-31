import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/core/usecase/usecase.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_order.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/repositories/volt_rent_order_repository.dart';

class GetUserOrder implements VoltRentOrderCase<List<VoltRentOrder>, String> {
  final VoltRentOrderRepository voltRentOrderRepository;

  GetUserOrder(this.voltRentOrderRepository);

  @override
  Future<Either<Failure, List<VoltRentOrder>>> call(params) {
    return voltRentOrderRepository.getUserOrder(params);
  }
}
