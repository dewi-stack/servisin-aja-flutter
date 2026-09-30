import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';

class ServiceCatalogScreen extends StatefulWidget {
  const ServiceCatalogScreen({
    super.key,
    required this.vehicle,
  });

  final Vehicle vehicle;

  @override
  State<ServiceCatalogScreen> createState() => _ServiceCatalogScreenState();
}

class _ServiceCatalogScreenState extends State<ServiceCatalogScreen> {
  String category = 'Semua';

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();
    final cfg = c.configFor(widget.vehicle.id);

    final parts = category == 'Semua'
        ? c.parts
        : c.parts.where((p) => p.category == category).toList();

    final total = cfg.selectedParts.fold<int>(
      0,
      (sum, part) => sum + part.price,
    );

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
                step: '2 / 4',
                title: 'Suku cadang & oli',
                subtitle:
                    'Pilih kebutuhan untuk ${widget.vehicle.displayName}.',
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),

              // ============================================================
              // CATEGORY
              // ============================================================
              const SectionTitle(
                title: 'Kategori',
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Semua',
                  'Oli',
                  'Filter',
                  'Rem',
                ].map(
                  (x) {
                    return ServiceChip(
                      label: x,
                      selected: category == x,
                      onTap: () {
                        setState(() {
                          category = x;
                        });
                      },
                    );
                  },
                ).toList(),
              ),

              const SizedBox(height: 18),

              // ============================================================
              // PARTS
              // ============================================================
              ...parts.map(
                (p) {
                  final isSelected = cfg.selectedParts.any(
                    (x) => x.id == p.id,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: AppCard(
                      onTap: () {
                        final next = [...cfg.selectedParts];

                        if (isSelected) {
                          next.removeWhere(
                            (x) => x.id == p.id,
                          );
                        } else {
                          next.add(p);
                        }

                        c.updateConfig(
                          widget.vehicle.id,
                          cfg.copyWith(
                            selectedParts: next,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==================================================
                          // NAME + CHECK
                          // ==================================================
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  p.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.orange,
                                ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          // ==================================================
                          // CATEGORY + BRAND
                          // ==================================================
                          Text(
                            '${p.category} • ${p.brand}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // ==================================================
                          // PRICE
                          // ==================================================
                          Text(
                            rupiah(p.price),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
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
                    Expanded(
                      child: Text(
                        '${cfg.selectedParts.length} item dipilih',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                    Text(
                      rupiah(total),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ============================================================
              // BUTTON
              // ============================================================
              PrimaryButton(
                label: 'Gunakan untuk kendaraan',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
