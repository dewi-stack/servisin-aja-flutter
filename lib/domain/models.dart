import 'package:flutter/foundation.dart';

enum ServiceType { routine, repair }

extension ServiceTypeX on ServiceType {
  String get label =>
      this == ServiceType.routine ? 'Servis rutin' : 'Perbaikan';
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

@immutable
class Vehicle {
  const Vehicle(
      {required this.id,
      required this.brand,
      required this.model,
      required this.year,
      required this.plate,
      required this.type});
  final int id;
  final String brand, model, plate, type;
  final int year;
  String get displayName => '$brand $model';
  factory Vehicle.fromJson(Map<String, dynamic> j) => Vehicle(
      id: j['id'],
      brand: j['brand'],
      model: j['model'],
      year: j['year'],
      plate: j['plate'],
      type: j['type']);
}

@immutable
class PartOption {
  const PartOption(
      {required this.id,
      required this.name,
      required this.brand,
      required this.price,
      required this.category,
      required this.description});
  final int id, price;
  final String name, brand, category, description;
  factory PartOption.fromJson(Map<String, dynamic> j) => PartOption(
      id: j['id'],
      name: j['name'],
      brand: j['brand'],
      price: j['price'],
      category: j['category'],
      description: j['description']);
}

@immutable
class Workshop {
  const Workshop(
      {required this.id,
      required this.name,
      required this.distance,
      required this.hours,
      required this.rating,
      required this.reviewCount,
      required this.address,
      required this.services});
  final int id, reviewCount;
  final String name, distance, hours, address;
  final double rating;
  final List<String> services;
  factory Workshop.fromJson(Map<String, dynamic> j) => Workshop(
      id: j['id'],
      name: j['name'],
      distance: j['distance'],
      hours: j['hours'],
      rating: (j['rating'] as num).toDouble(),
      reviewCount: j['reviewCount'],
      address: j['address'],
      services: List<String>.from(j['services']));
}

@immutable
class VehicleServiceConfig {
  const VehicleServiceConfig(
      {this.serviceType = ServiceType.routine,
      this.selectedParts = const [],
      this.complaint = ''});
  final ServiceType serviceType;
  final List<PartOption> selectedParts;
  final String complaint;
  int get estimate =>
      (serviceType == ServiceType.routine ? 75000 : 120000) +
      selectedParts.fold(0, (s, p) => s + p.price);
  int get durationMinutes => serviceType == ServiceType.routine ? 60 : 90;
  VehicleServiceConfig copyWith(
          {ServiceType? serviceType,
          List<PartOption>? selectedParts,
          String? complaint}) =>
      VehicleServiceConfig(
          serviceType: serviceType ?? this.serviceType,
          selectedParts: selectedParts ?? this.selectedParts,
          complaint: complaint ?? this.complaint);
}
