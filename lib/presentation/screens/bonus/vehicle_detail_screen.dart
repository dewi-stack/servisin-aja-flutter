import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../state/booking_controller.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({
    super.key,
    required this.vehicle,
    required this.controller,
  });

  final Vehicle vehicle;
  final BookingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F7),

      // ==============================================================
      // APP BAR
      // ==============================================================
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F7),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 42,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.only(left: 16),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: Color(0xFF222222),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            22,
            0,
            22,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================================
              // TITLE
              // ==========================================================
              const Text(
                'Detail kendaraan',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================================
              // VEHICLE SUMMARY CARD
              // ==========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  12,
                  12,
                  12,
                  12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE4E4E4),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ----------------------------------------------------
                    // VEHICLE ICON
                    // ----------------------------------------------------
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.softOrange,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.two_wheeler_rounded,
                        color: AppColors.orange,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // ----------------------------------------------------
                    // VEHICLE NAME + PLATE + STATUS
                    // ----------------------------------------------------
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF222222),
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            vehicle.plate,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.muted,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1C9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Aktif',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFE7A800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // INFORMATION TITLE
              // ==========================================================
              const Text(
                'Informasi kendaraan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 10),

              // ==========================================================
              // INFORMATION
              // ==========================================================

              _InfoCard(
                label: 'Merek',
                value: vehicle.brand,
              ),

              const SizedBox(height: 8),

              _InfoCard(
                label: 'Model',
                value: vehicle.model,
              ),

              const SizedBox(height: 8),

              _InfoCard(
                label: 'Tahun',
                value: '${vehicle.year}',
              ),

              const SizedBox(height: 8),

              _InfoCard(
                label: 'Nomor plat',
                value: vehicle.plate,
              ),

              const SizedBox(height: 8),

              _InfoCard(
                label: 'Warna',
                value: vehicle.color,
              ),

              const SizedBox(height: 8),

              _InfoCard(
                label: 'Servis terakhir',
                value: vehicle.lastService ?? '-',
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// INFORMATION CARD
// ============================================================================

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
