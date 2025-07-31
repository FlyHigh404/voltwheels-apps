import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

String generateId({required String featureCode}) {
  var uuid = const Uuid();

  String uuidSegment = uuid.v4().substring(0, 4);

  DateTime now = DateTime.now();

  String formattedDate = DateFormat('yyyyMMdd').format(now);

  String formattedTime = DateFormat('HHmm').format(now);

  return '$featureCode-$formattedDate-$formattedTime-$uuidSegment';
}
