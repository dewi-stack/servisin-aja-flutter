import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servisin_aja/presentation/screens/ui_states_screen.dart';

import '../../core/theme/app_theme.dart';
import '../../state/booking_controller.dart';
import 'bonus/vehicle_detail_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BookingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            32,
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
                    width: 32,
                    height: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 20,
                      onPressed: onBack ??
                          () {
                            Navigator.of(context).maybePop();
                          },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 17,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // EYEBROW
                        Text(
                          'AKUN',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.2,
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),

                        SizedBox(height: 4),

                        // PAGE TITLE
                        Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 24,
                            height: 1.15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202124),
                          ),
                        ),

                        SizedBox(height: 6),

                        // PAGE DESCRIPTION
                        Text(
                          'Kelola akun dan kendaraan Anda.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: AppColors.muted,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ============================================================
              // PROFILE CARD
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                    // AVATAR
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFEBDD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF5F7890),
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // USER INFORMATION
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Budi Santoso',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF202124),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'budi@email.com',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.25,
                              color: AppColors.muted,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ============================================================
              // KENDARAAN SAYA
              // ============================================================
              const Text(
                'Kendaraan saya',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 12),

              // ============================================================
              // VEHICLES
              // ============================================================
              ...controller.vehicles.map(
                (vehicle) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: _VehicleCard(
                      vehicleName: vehicle.displayName,
                      plate: vehicle.plate,
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

              const SizedBox(height: 16),

              // ============================================================
              // PENGATURAN
              // ============================================================
              const Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 12),

              // ============================================================
              // NOTIFIKASI
              // ============================================================
              _SettingCard(
                label: 'Notifikasi',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 8),

              // ============================================================
              // BANTUAN & FAQ
              // ============================================================
              _SettingCard(
                label: 'Bantuan & FAQ',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const UiStatesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================================
// VEHICLE CARD
// ==========================================================================

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.vehicleName,
    required this.plate,
    required this.onTap,
  });

  final String vehicleName;
  final String plate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 64,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
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
            // VEHICLE ICON
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBDD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.directions_car_rounded,
                size: 19,
                color: AppColors.orange,
              ),
            ),

            const SizedBox(width: 12),

            // VEHICLE INFORMATION
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202124),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plate,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.2,
                      color: AppColors.muted,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================================
// SETTING CARD
// ==========================================================================

class _SettingCard extends StatelessWidget {
  const _SettingCard({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 52,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
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
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}
