import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/booking.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';

class MechanicTrackingScreen extends StatelessWidget {
  const MechanicTrackingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
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
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 18,
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 15,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BOOKING SVA-20260928-0182',
                          style: TextStyle(
                            fontSize: 8,
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Pelacakan montir',
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202124),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lihat progres pengerjaan kendaraan.',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ============================================================
              // VEHICLE CARDS
              // ============================================================
              ...c.selectedVehicles.map(
                (v) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: _VehicleTrackingCard(
                    vehicleName: v.displayName,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // ============================================================
              // HUBUNGI BENGKEL
              // ============================================================
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone_rounded,
                    size: 16,
                  ),
                  label: const Text(
                    'Hubungi bengkel',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
// VEHICLE TRACKING CARD
// ==========================================================================

class _VehicleTrackingCard extends StatelessWidget {
  const _VehicleTrackingCard({
    required this.vehicleName,
  });

  final String vehicleName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // VEHICLE HEADER
          // ================================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  vehicleName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),
              ),
              const StatusBadge(
                status: BookingStatus.working,
              ),
            ],
          ),

          const SizedBox(height: 4),

          // ================================================================
          // MECHANIC
          // ================================================================
          const Text(
            'Montir: Andi • Bay 03',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.muted,
            ),
          ),

          const SizedBox(height: 21),

          // ================================================================
          // PROGRESS TITLE
          // ================================================================
          const Text(
            'Progress pengerjaan',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202124),
            ),
          ),

          const SizedBox(height: 8),

          // ================================================================
          // PROGRESS BAR
          // ================================================================
          const ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: LinearProgressIndicator(
              minHeight: 7,
              value: .63,
              backgroundColor: Color(0xFFDDE0E3),
              color: AppColors.orange,
            ),
          ),

          const SizedBox(height: 9),

          // ================================================================
          // PERCENTAGE + ESTIMATION
          // ================================================================
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '63%',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 28),
              Text(
                'Estimasi selesai 10.30 WIB',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ================================================================
          // WORK STEPS
          // ================================================================
          const _MechanicStep(
            label: 'Pemeriksaan selesai',
            state: _MechanicStepState.done,
          ),

          const _MechanicStep(
            label: 'Ganti oli',
            state: _MechanicStepState.done,
          ),

          const _MechanicStep(
            label: 'Pengecekan rem',
            state: _MechanicStepState.active,
          ),

          const _MechanicStep(
            label: 'Final check',
            state: _MechanicStepState.pending,
          ),
        ],
      ),
    );
  }
}

// ==========================================================================
// MECHANIC STEP
// ==========================================================================

enum _MechanicStepState {
  done,
  active,
  pending,
}

class _MechanicStep extends StatelessWidget {
  const _MechanicStep({
    required this.label,
    required this.state,
  });

  final String label;
  final _MechanicStepState state;

  @override
  Widget build(BuildContext context) {
    final Color circleColor;
    final IconData? icon;

    switch (state) {
      case _MechanicStepState.done:
        circleColor = AppColors.success;
        icon = Icons.check;
        break;

      case _MechanicStepState.active:
        circleColor = AppColors.orange;
        icon = null;
        break;

      case _MechanicStepState.pending:
        circleColor = const Color(0xFFD9DEE4);
        icon = null;
        break;
    }

    return SizedBox(
      height: 37,
      child: Row(
        children: [
          // ================================================================
          // STATUS CIRCLE
          // ================================================================
          Container(
            width: 19,
            height: 19,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: icon != null
                ? Icon(
                    icon,
                    size: 11,
                    color: Colors.white,
                  )
                : null,
          ),

          const SizedBox(width: 11),

          // ================================================================
          // STATUS TEXT
          // ================================================================
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: state == _MechanicStepState.active
                  ? const Color(0xFF202124)
                  : state == _MechanicStepState.pending
                      ? AppColors.muted
                      : const Color(0xFF5F6368),
              fontWeight: state == _MechanicStepState.active
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
