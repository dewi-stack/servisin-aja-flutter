import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/booking.dart';
import '../../state/booking_controller.dart';
import '../widgets/app_components.dart';
import 'bonus/booking_history_screen.dart';
import 'bonus/invoice_screen.dart';
import 'bonus/service_catalog_screen.dart';
import 'bonus/vehicle_detail_screen.dart';
import 'bonus/workshop_detail_screen.dart';
import 'booking/tracking_screen.dart';
import 'booking/vehicle_selection_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.controller,
  });

  final BookingController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeContent(
        controller: widget.controller,
        onStartBooking: _startBooking,
      ),
      VehicleSelectionScreen(onBack: () {
        setState(() {
          tab = 0;
        });
      }),
      TrackingScreen(
        onBack: () {
          setState(() {
            tab = 0;
          });
        },
      ),
      ProfileScreen(
        onBack: () {
          setState(() {
            tab = 0;
          });
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: BottomNav(
        index: tab,
        onChanged: (index) {
          setState(() {
            tab = index;
          });
        },
      ),
    );
  }

  void _startBooking() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const VehicleSelectionScreen(),
      ),
    );
  }
}

// ============================================================================
// HOME CONTENT
// ============================================================================

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.controller,
    required this.onStartBooking,
  });

  final BookingController controller;
  final VoidCallback onStartBooking;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          24,
          22,
          24,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==============================================================
            // HEADER
            // ==============================================================
            Row(
              children: [
                const Text(
                  'Servisin Aja',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              'Halo, Budi 👋',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.muted,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Servis kendaraan jadi lebih mudah.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 19),

            // ==============================================================
            // HERO BOOKING
            // ==============================================================
            GestureDetector(
              onTap: onStartBooking,
              child: Container(
                width: double.infinity,
                height: 118,
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SERVICE MADE SIMPLE',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Butuh servis hari ini?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Booking satu atau beberapa kendaraan.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ==============================================================
            // KENDARAAN SAYA
            // ==============================================================
            const SectionTitle(
              title: 'Kendaraan saya',
            ),

            const SizedBox(height: 14),

            ...c.vehicles.take(2).map(
              (vehicle) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: VehicleCard(
                    vehicle: vehicle,
                    selected: c.selectedVehicleIds.contains(
                      vehicle.id,
                    ),
                    showChevron: true,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => VehicleDetailScreen(
                            vehicle: vehicle,
                            controller: controller,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            AppCard(
              padding: EdgeInsets.zero,
              onTap: onStartBooking,
              child: const SizedBox(
                height: 52,
                child: Center(
                  child: Text(
                    '+ Tambah kendaraan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ==============================================================
            // EKSPLORASI LAYANAN
            // ==============================================================
            const SectionTitle(
              title: 'Eksplorasi layanan',
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AppCard(
                    onTap: () {
                      if (c.vehicles.isEmpty) {
                        return;
                      }

                      final vehicle = c.selectedVehicles.isNotEmpty
                          ? c.selectedVehicles.first
                          : c.vehicles.first;

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ServiceCatalogScreen(
                            vehicle: vehicle,
                          ),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(14),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.build_circle_outlined,
                          color: AppColors.orange,
                          size: 24,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Layanan & part',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppCard(
                    onTap: () {
                      if (c.workshops.isEmpty) {
                        return;
                      }

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WorkshopDetailScreen(
                            workshop: c.workshops.first,
                          ),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(14),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.storefront_outlined,
                          color: AppColors.orange,
                          size: 24,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Bengkel favorit',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ==============================================================
            // BOOKING AKTIF
            // ==============================================================
            const SectionTitle(
              title: 'Booking aktif',
            ),

            const SizedBox(height: 12),

            AppCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TrackingScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.bookingId,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                      const StatusBadge(
                        status: BookingStatus.working,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${c.selectedVehicles.length} kendaraan • '
                    '${c.workshop}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${c.dateLabel} • ${c.timeLabel}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ========================================================
                  // TOTAL ESTIMATE - formatter digunakan di sini
                  // ========================================================
                  Text(
                    'Total estimasi: ${rupiah(c.totalEstimate)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ==============================================================
            // INVOICE & RIWAYAT
            // ==============================================================
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const InvoiceScreen(),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(14),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          color: AppColors.orange,
                          size: 21,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Invoice',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BookingHistoryScreen(),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(14),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.history_rounded,
                          color: AppColors.orange,
                          size: 21,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Riwayat',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
