import 'service.dart';

class Booking {
  Booking({
    required this.id,
    required this.vehicleConfigs,
    required this.workshopName,
    required this.dateLabel,
    required this.timeLabel,
    this.statusByVehicle = const {},
  });

  final String id;
  final List<VehicleServiceConfig> vehicleConfigs;
  final String workshopName;
  final String dateLabel;
  final String timeLabel;
  final Map<String, String> statusByVehicle;

  int get totalEstimate =>
      vehicleConfigs.fold(0, (sum, config) => sum + config.estimate);
}

enum BookingStatus { waiting, confirmed, working, completed, cancelled }

extension BookingStatusX on BookingStatus {
  String get label => switch (this) {
        BookingStatus.waiting => 'Menunggu',
        BookingStatus.confirmed => 'Dikonfirmasi',
        BookingStatus.working => 'Dikerjakan',
        BookingStatus.completed => 'Selesai',
        BookingStatus.cancelled => 'Dibatalkan'
      };
}
