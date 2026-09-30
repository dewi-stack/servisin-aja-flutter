class Vehicle {
  const Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.plate,
    required this.year,
    required this.color,
    this.lastService,
  });

  final String id;
  final String brand;
  final String model;
  final String plate;
  final int year;
  final String color;
  final String? lastService;

  String get displayName => '$brand $model';
}
