import 'package:flutter/material.dart';

import '../../domain/entities/booking.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/entities/workshop.dart';

class MockData {
  static const vehicles = <Vehicle>[
    Vehicle(
      id: 'vario-160',
      brand: 'Honda',
      model: 'Vario 160',
      plate: 'B 1234 KAA',
      year: 2023,
      color: 'Matte Black',
      lastService: '3 bulan lalu',
    ),
    Vehicle(
      id: 'nmax-155',
      brand: 'Yamaha',
      model: 'NMAX 155',
      plate: 'B 5678 XYZ',
      year: 2022,
      color: 'Metallic Grey',
      lastService: '2 bulan lalu',
    ),
    Vehicle(
      id: 'beat',
      brand: 'Honda',
      model: 'Beat',
      plate: 'B 9012 QWE',
      year: 2021,
      color: 'White',
      lastService: '5 bulan lalu',
    ),
  ];

  static const services = <ServiceOption>[
    ServiceOption(
      id: 'periodic',
      name: 'Servis berkala',
      description: 'Pemeriksaan rutin, tune-up ringan, dan pengecekan umum.',
      basePrice: 115000,
      durationMinutes: 90,
      type: ServiceType.periodic,
    ),
    ServiceOption(
      id: 'oil',
      name: 'Ganti oli',
      description: 'Penggantian oli mesin + pemeriksaan singkat.',
      basePrice: 95000,
      durationMinutes: 45,
      type: ServiceType.oilChange,
    ),
    ServiceOption(
      id: 'repair',
      name: 'Perbaikan',
      description: 'Diagnosa dan pengerjaan perbaikan sesuai keluhan.',
      basePrice: 120000,
      durationMinutes: 120,
      type: ServiceType.repair,
    ),
    ServiceOption(
      id: 'brake',
      name: 'Service rem',
      description: 'Pemeriksaan sistem pengereman dan komponen terkait.',
      basePrice: 85000,
      durationMinutes: 60,
      type: ServiceType.brakeInspection,
    ),
  ];

  static const parts = <PartOption>[
    PartOption(
      id: 'mpx2',
      name: 'Oli mesin',
      brand: 'AHM MPX2',
      price: 65000,
      category: 'Oli',
    ),
    PartOption(
      id: 'gear-oil',
      name: 'Oli gardan',
      brand: 'AHM MPX Gear Oil',
      price: 24000,
      category: 'Oli',
    ),
    PartOption(
      id: 'filter',
      name: 'Filter udara',
      brand: 'Honda Genuine',
      price: 48000,
      category: 'Filter',
    ),
    PartOption(
      id: 'pad',
      name: 'Kampas rem depan',
      brand: 'Honda Genuine',
      price: 165000,
      category: 'Rem',
    ),
    PartOption(
      id: 'plug',
      name: 'Busi',
      brand: 'NGK',
      price: 42000,
      category: 'Spare part',
    ),
  ];

  static const workshops = <Workshop>[
    Workshop(
      id: 'kediri-kota',
      name: 'Servisin Aja — Kediri Kota',
      distance: '1.8 km',
      hours: 'Buka sampai 21:00',
      rating: 4.8,
      reviewCount: 186,
      address: 'Jl. Panglima Sudirman, Kediri',
      facilities: [
        'Waiting area',
        'Wi-Fi',
        'Pembayaran digital',
        'Garansi servis',
      ],
    ),
    Workshop(
      id: 'mojoroto',
      name: 'Servisin Aja — Mojoroto',
      distance: '3.4 km',
      hours: 'Buka sampai 20:00',
      rating: 4.7,
      reviewCount: 128,
      address: 'Jl. Veteran, Mojoroto, Kediri',
      facilities: [
        'Waiting area',
        'Coffee corner',
        'Pembayaran digital',
      ],
    ),
  ];

  static const mechanic = Mechanic(
    id: 'm1',
    name: 'Rizky Pratama',
    role: 'Lead Mechanic',
    rating: 4.9,
    completedJobs: 1240,
  );

  static const dates = [
    '26 Sep',
    '27 Sep',
    '28 Sep',
    '29 Sep',
  ];

  static const times = [
    '09:00',
    '10:30',
    '13:00',
    '15:30',
  ];

  static const notifications = [
    (
      title: 'Booking dikonfirmasi',
      message: 'Servisin Aja menerima booking Anda.',
      time: '5 menit lalu',
      icon: Icons.check_rounded,
    ),
    (
      title: 'Servis sedang dikerjakan',
      message: 'Honda Vario 160 masuk Bay 03.',
      time: '1 jam lalu',
      icon: Icons.build_rounded,
    ),
    (
      title: 'Beri rating bengkel',
      message: 'Servis Honda Vario 160 telah selesai.',
      time: 'Kemarin',
      icon: Icons.star_rounded,
    ),
  ];

  // =========================
  // MOCK BOOKING HISTORY
  // =========================

  static final List<Booking> bookings = [
    Booking(
      id: 'SVA-20260920-0091',
      vehicleConfigs: const [],
      workshopName: workshops[0].name,
      dateLabel: '20 Sep 2026',
      timeLabel: '10:30',
      statusByVehicle: const {
        'vario-160': 'Selesai',
        'nmax-155': 'Selesai',
      },
    ),
    Booking(
      id: 'SVA-20260928-0182',
      vehicleConfigs: const [],
      workshopName: workshops[0].name,
      dateLabel: '28 Sep 2026',
      timeLabel: '13:00',
      statusByVehicle: const {
        'vario-160': 'Sedang dikerjakan',
        'nmax-155': 'Menunggu pemeriksaan',
      },
    ),
  ];

  static Booking sampleBooking() {
    return Booking(
      id: '#SA-260926-001',
      vehicleConfigs: const [],
      workshopName: workshops.first.name,
      dateLabel: dates.first,
      timeLabel: times[1],
      statusByVehicle: const {
        'vario-160': 'Sedang dikerjakan',
        'nmax-155': 'Menunggu pemeriksaan',
      },
    );
  }
}
