import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/service.dart';
import '../../../state/booking_controller.dart';
import '../bonus/mechanic_tracking_screen.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({
    super.key,
    this.onBack,
  });

  // Callback untuk kembali ke tab Home.
  // Digunakan ketika TrackingScreen berada di dalam IndexedStack.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // HEADER
              // ============================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --------------------------------------------------------
                  // BACK BUTTON
                  // --------------------------------------------------------

                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 18,
                      onPressed: onBack ??
                          () {
                            Navigator.of(context).maybePop();
                          },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 15,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  // --------------------------------------------------------
                  // HEADER TEXT
                  // --------------------------------------------------------

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BOOKING ID
                        Text(
                          'BOOKING SVA-20260928-0182',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1,
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 5),

                        // PAGE TITLE
                        Text(
                          'Status servis',
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202124),
                          ),
                        ),

                        SizedBox(height: 5),

                        // SUBTITLE
                        Text(
                          'Pantau progres setiap kendaraan.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ============================================================
              // VEHICLE STATUS
              // ============================================================

              ...c.selectedVehicles.map(
                (v) {
                  final cfg = c.configFor(v.id);

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: _VehicleStatusCard(
                      vehicleName: v.displayName,
                      service: '${cfg.serviceType.label} • ${c.workshop}',
                    ),
                  );
                },
              ),

              const SizedBox(height: 6),

              // ============================================================
              // ESTIMASI SELESAI
              // ============================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  16,
                  13,
                  16,
                  14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECDD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LABEL
                    Text(
                      'Estimasi selesai',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.2,
                        fontWeight: FontWeight.w400,
                        color: AppColors.muted,
                      ),
                    ),

                    SizedBox(height: 5),

                    // VALUE
                    Text(
                      '10.30–11.00 WIB',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ============================================================
              // CARD PELACAKAN MONTIR
              // ============================================================

              _MechanicTrackingCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MechanicTrackingScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              // ============================================================
              // KEMBALI KE BERANDA
              // ============================================================

              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: onBack ??
                      () {
                        Navigator.of(context).maybePop();
                      },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke beranda',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================================
// VEHICLE STATUS CARD
// ==========================================================================

class _VehicleStatusCard extends StatelessWidget {
  const _VehicleStatusCard({
    required this.vehicleName,
    required this.service,
  });

  final String vehicleName;
  final String service;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------------------------------------------------
          // VEHICLE NAME
          // ---------------------------------------------------------------

          Text(
            vehicleName,
            style: const TextStyle(
              fontSize: 16,
              height: 1.15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202124),
            ),
          ),

          const SizedBox(height: 5),

          // ---------------------------------------------------------------
          // SERVICE + WORKSHOP
          // ---------------------------------------------------------------

          Text(
            service,
            style: const TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
            ),
          ),

          const SizedBox(height: 12),

          // ---------------------------------------------------------------
          // STATUS STEPS
          // ---------------------------------------------------------------

          const _StatusStep(
            label: 'Diterima',
            state: _StatusState.done,
          ),

          const _StatusStep(
            label: 'Pemeriksaan',
            state: _StatusState.done,
          ),

          const _StatusStep(
            label: 'Pengerjaan',
            state: _StatusState.active,
          ),

          const _StatusStep(
            label: 'Selesai',
            state: _StatusState.pending,
          ),
        ],
      ),
    );
  }
}

// ==========================================================================
// STATUS STEP
// ==========================================================================

enum _StatusState {
  done,
  active,
  pending,
}

class _StatusStep extends StatelessWidget {
  const _StatusStep({
    required this.label,
    required this.state,
  });

  final String label;
  final _StatusState state;

  @override
  Widget build(BuildContext context) {
    final Color circleColor;
    final IconData? icon;

    switch (state) {
      case _StatusState.done:
        circleColor = AppColors.success;
        icon = Icons.check;
        break;

      case _StatusState.active:
        circleColor = AppColors.orange;
        icon = null;
        break;

      case _StatusState.pending:
        circleColor = const Color(0xFFD9DEE4);
        icon = null;
        break;
    }

    return SizedBox(
      height: 24,
      child: Row(
        children: [
          // ---------------------------------------------------------------
          // CIRCLE
          // ---------------------------------------------------------------

          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: icon != null
                ? Icon(
                    icon,
                    size: 9,
                    color: Colors.white,
                  )
                : null,
          ),

          const SizedBox(width: 8),

          // ---------------------------------------------------------------
          // LABEL
          // ---------------------------------------------------------------

          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              height: 1.1,
              color: state == _StatusState.active
                  ? const Color(0xFF202124)
                  : state == _StatusState.pending
                      ? AppColors.muted
                      : const Color(0xFF5F6368),
              fontWeight: state == _StatusState.active
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================================
// MECHANIC TRACKING CARD
// ==========================================================================

class _MechanicTrackingCard extends StatelessWidget {
  const _MechanicTrackingCard({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            16,
            14,
            12,
            14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // -----------------------------------------------------------
              // ICON
              // -----------------------------------------------------------

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECDD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.engineering_rounded,
                  size: 21,
                  color: AppColors.orange,
                ),
              ),

              const SizedBox(width: 12),

              // -----------------------------------------------------------
              // TEXT
              // -----------------------------------------------------------

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pelacakan montir',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Lihat progres pengerjaan kendaraan.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: FontWeight.w400,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),

              // -----------------------------------------------------------
              // ARROW
              // -----------------------------------------------------------

              const Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: AppColors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
