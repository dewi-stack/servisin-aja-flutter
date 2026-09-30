import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/workshop.dart';
import '../../../state/booking_controller.dart';

class WorkshopDetailScreen extends StatelessWidget {
  const WorkshopDetailScreen({
    super.key,
    required this.workshop,
  });

  final Workshop workshop;

  @override
  Widget build(BuildContext context) {
    final c = context.read<BookingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            // WORKSHOP HEADER
            // ============================================================
            Container(
              width: double.infinity,
              color: AppColors.orange,
              padding: const EdgeInsets.fromLTRB(
                24,
                8,
                24,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------------
                  // BACK BUTTON
                  // ------------------------------------------------------
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 20,
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ------------------------------------------------------
                  // WORKSHOP NAME
                  // ------------------------------------------------------
                  Text(
                    workshop.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      height: 1.15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ------------------------------------------------------
                  // DESCRIPTION
                  // ------------------------------------------------------
                  const Text(
                    'Bengkel resmi & servis lengkap',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ------------------------------------------------------
                  // RATING / REVIEW / DISTANCE
                  // ------------------------------------------------------
                  Wrap(
                    spacing: 16,
                    runSpacing: 6,
                    children: [
                      _HeaderMeta(
                        icon: Icons.star_rounded,
                        text: workshop.rating.toStringAsFixed(1),
                      ),
                      _HeaderMeta(
                        icon: Icons.rate_review_outlined,
                        text: '${workshop.reviewCount} ulasan',
                      ),
                      _HeaderMeta(
                        icon: Icons.location_on_outlined,
                        text: workshop.distance,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ============================================================
            // CONTENT
            // ============================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  24,
                  24,
                  32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ======================================================
                    // ABOUT
                    // ======================================================
                    const _SectionTitle(
                      title: 'Tentang bengkel',
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Melayani servis rutin, perbaikan ringan, oli, rem, '
                      'dan pemeriksaan kendaraan di ${workshop.address}.',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: AppColors.muted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ======================================================
                    // SERVICES
                    // ======================================================
                    const _SectionTitle(
                      title: 'Layanan tersedia',
                    ),

                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: c.services.asMap().entries.map((entry) {
                          final index = entry.key;
                          final service = entry.value;

                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == c.services.length - 1 ? 0 : 8,
                            ),
                            child: _ServicePill(
                              label: service.name,
                              selected: service == c.services.first,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ======================================================
                    // OPENING HOURS
                    // ======================================================
                    const _SectionTitle(
                      title: 'Jam operasional',
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
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
                          const Text(
                            'Senin–Sabtu',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.25,
                              color: AppColors.muted,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            workshop.hours,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.25,
                              color: Color(0xFF202124),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ======================================================
                    // FACILITIES
                    // ======================================================
                    const _SectionTitle(
                      title: 'Fasilitas',
                    ),

                    const SizedBox(height: 12),

                    if (workshop.facilities.isEmpty)
                      const Text(
                        'Belum ada informasi fasilitas.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    else
                      Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        children: workshop.facilities
                            .map(
                              (facility) => _FacilityItem(
                                label: facility,
                              ),
                            )
                            .toList(),
                      ),

                    const SizedBox(height: 32),

                    // ======================================================
                    // SELECT WORKSHOP
                    // ======================================================
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          c.chooseWorkshop(workshop.name);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Pilih bengkel',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================================
// HEADER META
// ==========================================================================

class _HeaderMeta extends StatelessWidget {
  const _HeaderMeta({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 15,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            height: 1.25,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ==========================================================================
// SECTION TITLE
// ==========================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        height: 1.25,
        color: Color(0xFF202124),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ==========================================================================
// SERVICE PILL
// ==========================================================================

class _ServicePill extends StatelessWidget {
  const _ServicePill({
    required this.label,
    required this.selected,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 36,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.orange : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? AppColors.orange : const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          height: 1.2,
          color: selected ? Colors.white : const Color(0xFF202124),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ==========================================================================
// FACILITY
// ==========================================================================

class _FacilityItem extends StatelessWidget {
  const _FacilityItem({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.softOrange,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 13,
            color: AppColors.orange,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            height: 1.25,
            color: AppColors.muted,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
