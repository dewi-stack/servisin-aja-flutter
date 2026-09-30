enum ServiceType { periodic, oilChange, repair, brakeInspection }

extension ServiceTypeLabel on ServiceType {
  String get label => switch (this) {
        ServiceType.periodic => 'Servis berkala',
        ServiceType.oilChange => 'Ganti oli',
        ServiceType.repair => 'Perbaikan',
        ServiceType.brakeInspection => 'Service rem',
      };
}

extension ServiceTypeIcon on ServiceType {
  String get helper => switch (this) {
        ServiceType.periodic => 'Pemeriksaan rutin & tune-up ringan',
        ServiceType.oilChange => 'Ganti oli + pemeriksaan singkat',
        ServiceType.repair => 'Diagnosa dan perbaikan sesuai keluhan',
        ServiceType.brakeInspection => 'Pemeriksaan sistem pengereman',
      };
}

class ServiceOption {
  const ServiceOption({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.durationMinutes,
    required this.type,
  });

  final String id;
  final String name;
  final String description;
  final int basePrice;
  final int durationMinutes;
  final ServiceType type;
}

class PartOption {
  const PartOption({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.category,
  });

  final String id;
  final String name;
  final String brand;
  final int price;
  final String category;
}

class VehicleServiceConfig {
  VehicleServiceConfig({
    required this.vehicleId,
    this.serviceType = ServiceType.periodic,
    this.selectedParts = const <PartOption>[],
    this.complaint = '',
  });

  final String vehicleId;
  ServiceType serviceType;
  List<PartOption> selectedParts;
  String complaint;

  int get basePrice => switch (serviceType) {
        ServiceType.periodic => 115000,
        ServiceType.oilChange => 95000,
        ServiceType.repair => 120000,
        ServiceType.brakeInspection => 85000,
      };

  int get durationMinutes => switch (serviceType) {
        ServiceType.periodic => 90,
        ServiceType.oilChange => 45,
        ServiceType.repair => 120,
        ServiceType.brakeInspection => 60,
      };

  int get estimate => basePrice + selectedParts.fold<int>(0, (sum, item) => sum + item.price);

  VehicleServiceConfig copyWith({
    ServiceType? serviceType,
    List<PartOption>? selectedParts,
    String? complaint,
  }) {
    return VehicleServiceConfig(
      vehicleId: vehicleId,
      serviceType: serviceType ?? this.serviceType,
      selectedParts: selectedParts ?? this.selectedParts,
      complaint: complaint ?? this.complaint,
    );
  }
}
