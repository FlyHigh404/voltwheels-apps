import '../../../../core/utils/date_utils.dart';

String generateRentalDetails(Duration rentDuration) {
  DateTime now = DateTime.now();
  DateTime returnDateTime = now.add(rentDuration);

  if (rentDuration.inDays >= 1) {
    return "${formatDateTime(now)}"
        " hingga"
        " ${formatDateTime(returnDateTime)}"
        " (${formatDuration(rentDuration)})\n"
        "*toleransi keterlambatan pengembalian unit hanya 15 menit";
  } else {

    return "${formatDateTime(now)}"
        " hingga"
        " ${formatHM(returnDateTime)}"
        " (${formatDuration(rentDuration)})\n"
        "*toleransi keterlambatan pengembalian unit hanya 15 menit";
  }
}
