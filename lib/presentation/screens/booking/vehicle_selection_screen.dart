import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';
import 'vehicle_service_screen.dart';

class VehicleSelectionScreen extends StatelessWidget {
  const VehicleSelectionScreen({
    super.key,
    this.onBack,
  });

  // Callback untuk kembali ke Home jika screen digunakan
  // sebagai salah satu tab di HomeScreen.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

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
                step: '1 / 4',
                title: 'Pilih kendaraan',
                subtitle: 'Bisa pilih lebih dari satu kendaraan.',
                onBack: onBack ??
                    () {
                      Navigator.of(context).maybePop();
                    },
              ),

              const SizedBox(height: 20),

              // ============================================================
              // VEHICLE LIST
              // ============================================================
              ...c.vehicles.map(
                (v) {
                  final selected = c.selectedVehicleIds.contains(v.id);

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: VehicleCard(
                      vehicle: v,
                      selected: selected,
                      onTap: () {
                        c.toggleVehicle(v.id);
                      },
                    ),
                  );
                },
              ),

              // ============================================================
              // SELECTED SUMMARY
              // ============================================================
              AppCard(
                backgroundColor: AppColors.softOrange,
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.orange,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${c.selectedVehicles.length} kendaraan dipilih',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Setiap kendaraan punya konfigurasi servis sendiri.',
                            style: TextStyle(
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

              const SizedBox(height: 16),

              // ============================================================
              // CONTINUE
              // ============================================================
              PrimaryButton(
                label: 'Lanjutkan konfigurasi',
                onPressed: c.selectedVehicles.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VehicleServiceScreen(),
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
