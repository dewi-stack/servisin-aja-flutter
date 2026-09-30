import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/service.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';
import '../bonus/rating_screen.dart';
import 'booking_success_screen.dart';

class ReviewBookingScreen extends StatelessWidget {
  const ReviewBookingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    // Booking dapat dikonfirmasi jika minimal ada satu kendaraan.
    final canReview = c.selectedVehicles.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // HEADER
              // ============================================================
              PageHeader(
                step: '4 / 4',
                title: 'Review booking',
                subtitle: 'Pastikan detail kendaraan dan jadwal sudah benar.',
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // VEHICLES
              // ============================================================
              const SectionTitle(
                title: 'Kendaraan',
              ),

              const SizedBox(height: 10),

              ...c.selectedVehicles.map(
                (v) {
                  final cfg = c.configFor(v.id);

                  final partsLabel = cfg.selectedParts.isEmpty
                      ? 'Tanpa part tambahan'
                      : cfg.selectedParts.map((p) => p.name).join(', ');

                  final complaintLabel = cfg.complaint.isEmpty
                      ? 'Keluhan: tidak ada catatan'
                      : 'Keluhan: ${cfg.complaint}';

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==================================================
                          // VEHICLE NAME
                          // ==================================================
                          Text(
                            v.displayName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // ==================================================
                          // SERVICE + PARTS
                          // ==================================================
                          Text(
                            '${cfg.serviceType.label} • $partsLabel',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                            ),
                          ),

                          const SizedBox(height: 3),

                          // ==================================================
                          // COMPLAINT
                          // ==================================================
                          Text(
                            complaintLabel,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.muted,
                            ),
                          ),

                          const SizedBox(height: 6),

                          // ==================================================
                          // ESTIMATE
                          // ==================================================
                          Text(
                            'Estimasi: ${rupiah(cfg.estimate)}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 6),

              // ============================================================
              // WORKSHOP & SCHEDULE
              // ============================================================
              const SectionTitle(
                title: 'Bengkel & jadwal',
              ),

              const SizedBox(height: 10),

              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.workshop,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${c.dateLabel} • ${c.timeLabel}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              //============================================================
              // RATING BENGKEL
              // ============================================================
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RatingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.star_outline_rounded,
                    size: 20,
                  ),
                  label: const Text(
                    'Beri rating bengkel',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.orange,
                    side: const BorderSide(
                      color: AppColors.orange,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ============================================================
              // TOTAL
              // ============================================================
              const SectionTitle(
                title: 'Total estimasi',
              ),

              const SizedBox(height: 10),

              AppCard(
                backgroundColor: AppColors.softOrange,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total biaya',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                    Text(
                      rupiah(c.totalEstimate),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Estimasi durasi • ${c.totalDurationMinutes} menit',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.muted,
                ),
              ),

              const SizedBox(height: 18),

              // ============================================================
              // CONFIRM BOOKING
              // ============================================================
              PrimaryButton(
                label: 'Konfirmasi booking',
                onPressed: canReview
                    ? () {
                        c.submitBooking();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookingSuccessScreen(),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // RATING DIALOG
  // ============================================================
}
