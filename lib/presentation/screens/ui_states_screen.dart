import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/booking.dart';
import '../widgets/app_components.dart';

class UiStatesScreen extends StatelessWidget {
  const UiStatesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageHeader(
                          step: 'UI STATES',
                          title: 'State & feedback',
                          subtitle: 'Komponen untuk kondisi nyata aplikasi.',
                          onBack: () => Navigator.pop(context)),
                      const SizedBox(height: 20),
                      const SectionTitle(title: 'Booking state'),
                      const SizedBox(height: 10),
                      const Wrap(spacing: 8, runSpacing: 8, children: [
                        StatusBadge(status: BookingStatus.waiting),
                        StatusBadge(status: BookingStatus.confirmed),
                        StatusBadge(status: BookingStatus.working),
                        StatusBadge(status: BookingStatus.completed),
                        StatusBadge(status: BookingStatus.cancelled)
                      ]),
                      const SizedBox(height: 24),
                      const SectionTitle(title: 'Feedback state'),
                      const SizedBox(height: 10),
                      const AppCard(
                          backgroundColor: AppColors.softOrange,
                          child: Text('✓ Booking berhasil disimpan.',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600))),
                      const SizedBox(height: 10),
                      const AppCard(
                          backgroundColor: AppColors.softWarning,
                          child: Text('! Jadwal ini hampir penuh.',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600))),
                      const SizedBox(height: 10),
                      const AppCard(
                          child: Text('Tidak ada slot tersedia.',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(height: 24),
                      const SectionTitle(title: 'Loading / disabled'),
                      const SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(14)),
                          child: const Text('Memuat jadwal...',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.muted,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(height: 10),
                      PrimaryButton(label: 'Coba lagi', onPressed: () {})
                    ]))));
  }
}
