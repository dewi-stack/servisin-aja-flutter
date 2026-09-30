import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../domain/entities/booking.dart';
import '../domain/entities/service.dart';
import '../domain/entities/vehicle.dart';
import '../domain/entities/workshop.dart';
import '../domain/repositories/booking_repository.dart';

class BookingController extends ChangeNotifier {
  BookingController({
    required BookingRepository repository,
  }) {
    vehicles = List.unmodifiable(
      repository.getVehicles(),
    );

    activeBooking = repository.getActiveBooking();

    selectedVehicleIds.addAll([
      'vario-160',
      'nmax-155',
    ]);
  }

  late final List<Vehicle> vehicles;
  late Booking activeBooking;

  final List<String> selectedVehicleIds = [];

  final Map<String, VehicleServiceConfig> _configs = {};

  final Map<String, String> statusByVehicle = {
    ...MockData.sampleBooking().statusByVehicle,
  };

  String workshop = MockData.workshops.first.name;
  String dateLabel = MockData.dates.first;
  String timeLabel = MockData.times[1];

  double? rating;
  String ratingNote = '';

  bool bookingSubmitted = true;

  // ==========================================================================
  // VEHICLES
  // ==========================================================================

  List<Vehicle> get selectedVehicles {
    return vehicles
        .where(
          (vehicle) => selectedVehicleIds.contains(vehicle.id),
        )
        .toList();
  }

// ==========================================================================
// MASTER DATA
// ==========================================================================

  List<Workshop> get workshops {
    return MockData.workshops;
  }

  List<ServiceOption> get services {
    return MockData.services;
  }

  List<PartOption> get parts {
    return MockData.parts;
  }

// Daftar tanggal yang tersedia.
  List<String> get dates {
    return MockData.dates;
  }

// Daftar jam yang tersedia.
  List<String> get times {
    return MockData.times;
  }

// Booking dapat dilanjutkan jika minimal ada satu kendaraan
// dan data bengkel + jadwal sudah tersedia.
  bool get canReview {
    return selectedVehicles.isNotEmpty &&
        workshop.trim().isNotEmpty &&
        dateLabel.trim().isNotEmpty &&
        timeLabel.trim().isNotEmpty;
  }

  // ==========================================================================
  // BOOKING SUMMARY
  // ==========================================================================

  int get totalEstimate {
    return selectedVehicles.fold(
      0,
      (sum, vehicle) => sum + configFor(vehicle.id).estimate,
    );
  }

  int get totalDurationMinutes {
    return selectedVehicles.fold(
      0,
      (sum, vehicle) => sum + configFor(vehicle.id).durationMinutes,
    );
  }

  int get completedVehicleCount {
    return statusByVehicle.values
        .where(
          (value) => value == 'Selesai',
        )
        .length;
  }

  String get bookingId {
    return activeBooking.id;
  }

  // ==========================================================================
  // VEHICLE SERVICE CONFIGURATION
  // ==========================================================================

  VehicleServiceConfig configFor(String vehicleId) {
    return _configs.putIfAbsent(
      vehicleId,
      () => VehicleServiceConfig(
        vehicleId: vehicleId,
        serviceType: vehicleId == 'nmax-155'
            ? ServiceType.oilChange
            : ServiceType.periodic,
        selectedParts:
            vehicleId == 'vario-160' ? [MockData.parts.first] : const [],
        complaint: vehicleId == 'vario-160'
            ? 'Rem terasa bergetar saat pengereman.'
            : 'Mohon pemeriksaan kondisi rem.',
      ),
    );
  }

  // ==========================================================================
  // VEHICLE SELECTION
  // ==========================================================================

  void toggleVehicle(String id) {
    if (selectedVehicleIds.contains(id)) {
      // Minimal harus ada satu kendaraan.
      if (selectedVehicleIds.length == 1) {
        return;
      }

      selectedVehicleIds.remove(id);
    } else {
      selectedVehicleIds.add(id);
    }

    notifyListeners();
  }

  // ==========================================================================
  // UPDATE CONFIG
  // ==========================================================================

  void updateConfig(
    String vehicleId,
    VehicleServiceConfig config,
  ) {
    _configs[vehicleId] = config;
    notifyListeners();
  }

  // ==========================================================================
  // WORKSHOP & SCHEDULE
  // ==========================================================================

  void chooseWorkshop(String value) {
    workshop = value;
    notifyListeners();
  }

  void chooseDate(String value) {
    dateLabel = value;
    notifyListeners();
  }

  void chooseTime(String value) {
    timeLabel = value;
    notifyListeners();
  }

  // ==========================================================================
  // SUBMIT BOOKING
  // ==========================================================================

  void submitBooking() {
    bookingSubmitted = true;

    final id = activeBooking.id;

    activeBooking = Booking(
      id: id,

      // FIX:
      // selectedVehicles berisi Vehicle,
      // sedangkan configFor membutuhkan vehicle.id (String).
      vehicleConfigs: selectedVehicles
          .map(
            (vehicle) => configFor(vehicle.id),
          )
          .toList(),

      workshopName: workshop,
      dateLabel: dateLabel,
      timeLabel: timeLabel,

      statusByVehicle: statusByVehicle,
    );

    notifyListeners();
  }

  // ==========================================================================
  // VEHICLE STATUS
  // ==========================================================================

  void updateVehicleStatus(
    String vehicleId,
    String status,
  ) {
    statusByVehicle[vehicleId] = status;
    notifyListeners();
  }

  // ==========================================================================
  // RATING
  // ==========================================================================

  void submitRating(
    double value,
    String note,
  ) {
    rating = value;
    ratingNote = note;

    notifyListeners();
  }

  // ==========================================================================
  // RESET BOOKING
  // ==========================================================================

  void resetBooking() {
    selectedVehicleIds
      ..clear()
      ..addAll([
        'vario-160',
        'nmax-155',
      ]);

    _configs.clear();

    workshop = MockData.workshops.first.name;
    dateLabel = MockData.dates.first;
    timeLabel = MockData.times[1];

    rating = null;
    ratingNote = '';

    bookingSubmitted = false;

    notifyListeners();
  }
}
