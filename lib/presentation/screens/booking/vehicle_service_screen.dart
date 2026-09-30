import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';
import '../bonus/service_catalog_screen.dart';
import 'workshop_schedule_screen.dart';

class VehicleServiceScreen extends StatefulWidget {
  const VehicleServiceScreen({super.key});

  @override
  State<VehicleServiceScreen> createState() => _VehicleServiceScreenState();
}

class _VehicleServiceScreenState extends State<VehicleServiceScreen> {
  int index = 0;

  late final TextEditingController complaint;

  @override
  void initState() {
    super.initState();
    complaint = TextEditingController();
  }

  @override
  void dispose() {
    complaint.dispose();
    super.dispose();
  }

  void sync(BookingController c) {
    if (c.selectedVehicles.isEmpty) return;

    // Pastikan index tidak melebihi jumlah kendaraan
    if (index >= c.selectedVehicles.length) {
      index = 0;
    }

    final vehicle = c.selectedVehicles[index];
    final text = c.configFor(vehicle.id).complaint;

    if (complaint.text != text) {
      complaint.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    // ============================================================
    // TIDAK ADA KENDARAAN
    // ============================================================

    if (c.selectedVehicles.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Konfigurasi servis'),
        ),
        body: const Center(
          child: Text(
            'Belum ada kendaraan yang dipilih.',
          ),
        ),
      );
    }

    // Sinkronisasi complaint dengan kendaraan aktif
    sync(c);

    final vehicle = c.selectedVehicles[index];
    final cfg = c.configFor(vehicle.id);

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
              // ==========================================================
              // HEADER
              // ==========================================================

              PageHeader(
                step: '2 / 4',
                title: vehicle.displayName,
                subtitle: '${vehicle.plate} • konfigurasi spesifik unit',
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // PILIH KENDARAAN
              // ==========================================================

              if (c.selectedVehicles.length > 1) ...[
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      for (var i = 0; i < c.selectedVehicles.length; i++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: i == c.selectedVehicles.length - 1 ? 0 : 8,
                            ),
                            child: ServiceChip(
                              label: c.selectedVehicles[i].model,
                              selected: i == index,
                              onTap: () {
                                setState(() {
                                  index = i;
                                });

                                sync(c);
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // ==========================================================
              // JENIS SERVIS
              // ==========================================================

              const SectionTitle(
                title: 'Jenis servis',
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: c.services.map((service) {
                  return ServiceChip(
                    label: service.name,
                    selected: cfg.serviceType == service.type,
                    onTap: () {
                      c.updateConfig(
                        vehicle.id,
                        cfg.copyWith(
                          serviceType: service.type,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // ==========================================================
              // SUKU CADANG / OLI
              // ==========================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      'Suku cadang / oli',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceCatalogScreen(
                            vehicle: vehicle,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Lihat katalog',
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // ==========================================================
              // PARTS
              // ==========================================================

              ...c.parts.map(
                (part) {
                  final selected = cfg.selectedParts.any(
                    (x) => x.id == part.id,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: PartCard(
                      part: part,
                      selected: selected,
                      onTap: () {
                        final next = [
                          ...cfg.selectedParts,
                        ];

                        final alreadySelected = next.any(
                          (x) => x.id == part.id,
                        );

                        if (alreadySelected) {
                          next.removeWhere(
                            (x) => x.id == part.id,
                          );
                        } else {
                          next.add(part);
                        }

                        c.updateConfig(
                          vehicle.id,
                          cfg.copyWith(
                            selectedParts: next,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 4),

              // ==========================================================
              // KELUHAN
              // ==========================================================

              const SectionTitle(
                title: 'Keluhan / catatan',
              ),

              const SizedBox(height: 10),

              TextField(
                controller: complaint,
                maxLines: 4,
                maxLength: 250,
                onChanged: (text) {
                  c.updateConfig(
                    vehicle.id,
                    cfg.copyWith(
                      complaint: text,
                    ),
                  );
                },
                decoration: const InputDecoration(
                  hintText: 'Contoh: rem terasa bergetar saat pengereman.',
                ),
              ),

              const SizedBox(height: 12),

              // ==========================================================
              // ESTIMASI
              // ==========================================================

              AppCard(
                backgroundColor: AppColors.softOrange,
                child: Row(
                  children: [
                    const Icon(
                      Icons.payments_outlined,
                      color: AppColors.orange,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${rupiah(cfg.estimate)} • '
                        '± ${cfg.durationMinutes} menit',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================================
              // NEXT BUTTON
              // ==========================================================

              PrimaryButton(
                label: index < c.selectedVehicles.length - 1
                    ? 'Simpan & kendaraan berikutnya'
                    : 'Lanjut ke bengkel & jadwal',
                onPressed: () {
                  // Simpan complaint terbaru
                  c.updateConfig(
                    vehicle.id,
                    cfg.copyWith(
                      complaint: complaint.text.trim(),
                    ),
                  );

                  // Masih ada kendaraan berikutnya
                  if (index < c.selectedVehicles.length - 1) {
                    setState(() {
                      index++;
                    });

                    sync(c);
                    return;
                  }

                  // Semua kendaraan selesai
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkshopScheduleScreen(),
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
