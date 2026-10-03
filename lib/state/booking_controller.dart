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

    _selectedVehicleIds.addAll([
      'vario-160',
      'nmax-155',
    ]);
  }

  // ==========================================================================
  // STATE
  // ==========================================================================

  late final List<Vehicle> vehicles;

  late Booking activeBooking;

  final List<String> _selectedVehicleIds = [];

  final Map<String, VehicleServiceConfig> _configs = {};

  final Map<String, String> _statusByVehicle = {
    ...MockData.sampleBooking().statusByVehicle,
  };

  String _workshop = MockData.workshops.first.name;
  String _dateLabel = MockData.dates.first;
  String _timeLabel = MockData.times[1];

  double? _rating;
  String _ratingNote = '';

  bool _bookingSubmitted = true;

  // ==========================================================================
  // VEHICLES
  // ==========================================================================

  List<String> get selectedVehicleIds {
    return List.unmodifiable(_selectedVehicleIds);
  }

  List<Vehicle> get selectedVehicles {
    return vehicles
        .where(
          (vehicle) => _selectedVehicleIds.contains(vehicle.id),
        )
        .toList();
  }

  // ==========================================================================
  // MASTER DATA
  // ==========================================================================

  List<Workshop> get workshops => MockData.workshops;

  List<ServiceOption> get services => MockData.services;

  List<PartOption> get parts => MockData.parts;

  List<String> get dates => MockData.dates;

  List<String> get times => MockData.times;

  // ==========================================================================
  // BOOKING
  // ==========================================================================

  String get workshop => _workshop;

  String get dateLabel => _dateLabel;

  String get timeLabel => _timeLabel;

  Map<String, String> get statusByVehicle {
    return Map.unmodifiable(_statusByVehicle);
  }

  bool get bookingSubmitted => _bookingSubmitted;

  String get bookingId => activeBooking.id;

  bool get canReview {
    return selectedVehicles.isNotEmpty &&
        _workshop.trim().isNotEmpty &&
        _dateLabel.trim().isNotEmpty &&
        _timeLabel.trim().isNotEmpty;
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
    return _statusByVehicle.values
        .where(
          (value) => value == 'Selesai',
        )
        .length;
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
    if (_selectedVehicleIds.contains(id)) {
      // Minimal satu kendaraan harus tetap dipilih.
      if (_selectedVehicleIds.length == 1) {
        return;
      }

      _selectedVehicleIds.remove(id);
    } else {
      _selectedVehicleIds.add(id);
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
    _workshop = value;
    notifyListeners();
  }

  void chooseDate(String value) {
    _dateLabel = value;

    // Reset jam ketika tanggal diganti.
    _timeLabel = '';

    notifyListeners();
  }

  void chooseTime(String value) {
    _timeLabel = value;
    notifyListeners();
  }

  // ==========================================================================
  // SUBMIT BOOKING
  // ==========================================================================

  void submitBooking() {
    _bookingSubmitted = true;

    final id = activeBooking.id;

    activeBooking = Booking(
      id: id,
      vehicleConfigs: selectedVehicles
          .map(
            (vehicle) => configFor(vehicle.id),
          )
          .toList(),
      workshopName: _workshop,
      dateLabel: _dateLabel,
      timeLabel: _timeLabel,
      statusByVehicle: Map<String, String>.from(
        _statusByVehicle,
      ),
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
    _statusByVehicle[vehicleId] = status;
    notifyListeners();
  }

  // ==========================================================================
  // RATING
  // ==========================================================================

  double? get rating => _rating;

  String get ratingNote => _ratingNote;

  void submitRating(
    double value,
    String note,
  ) {
    _rating = value;
    _ratingNote = note;

    notifyListeners();
  }

  // ==========================================================================
  // RESET BOOKING
  // ==========================================================================

  void resetBooking() {
    _selectedVehicleIds
      ..clear()
      ..addAll([
        'vario-160',
        'nmax-155',
      ]);

    _configs.clear();

    _workshop = MockData.workshops.first.name;
    _dateLabel = MockData.dates.first;
    _timeLabel = MockData.times[1];

    _rating = null;
    _ratingNote = '';

    _bookingSubmitted = false;

    notifyListeners();
  }
}
