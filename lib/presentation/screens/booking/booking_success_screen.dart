import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/booking.dart';
import '../../../domain/entities/service.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';
import 'tracking_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            children: [
              // ============================================================
              // HEADER SUCCESS
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  24,
                  12,
                  24,
                  30,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(26),
                  ),
                ),
                child: Column(
                  children: [
                    // ======================================================
                    // BACK BUTTON
                    // ======================================================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ======================================================
                    // TITLE
                    // ======================================================
                    const Text(
                      'Booking berhasil!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Nomor booking',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'SVA-20260928-0182',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ======================================================
                    // BOOKING INFO CARD
                    // ======================================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${c.workshop} • '
                            '${c.dateLabel} '
                            '${c.timeLabel}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${c.selectedVehicles.length} kendaraan '
                            'dalam satu booking',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ============================================================
              // STATUS KENDARAAN
              // ============================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      title: 'Status kendaraan',
                    ),

                    const SizedBox(height: 10),

                    ...c.selectedVehicles.map(
                      (v) {
                        final cfg = c.configFor(v.id);

                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: AppCard(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        v.displayName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${cfg.serviceType.label} • '
                                        '${rupiah(cfg.estimate)}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // =================================================
                                // STATUS BADGE
                                // =================================================
                                StatusBadge(
                                  status: BookingStatus.waiting,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    const Center(
                      child: Text(
                        'Anda dapat melacak status masing-masing kendaraan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ========================================================
                    // DETAIL BOOKING BUTTON
                    // ========================================================
                    PrimaryButton(
                      label: 'Lihat detail booking',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TrackingScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
