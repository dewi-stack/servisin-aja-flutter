import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';
import '../bonus/workshop_detail_screen.dart';
import 'review_booking_screen.dart';

class WorkshopScheduleScreen extends StatelessWidget {
  const WorkshopScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageHeader(
                          step: '3 / 4',
                          title: 'Pilih bengkel & jadwal',
                          subtitle: 'Satu jadwal untuk seluruh kendaraan.',
                          onBack: () => Navigator.pop(context)),
                      const SizedBox(height: 20),
                      const SectionTitle(title: 'Bengkel'),
                      const SizedBox(height: 10),
                      ...c.workshops.map((w) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: AppCard(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          WorkshopDetailScreen(workshop: w))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Expanded(
                                          child: Text(w.name,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                      const Icon(Icons.chevron_right_rounded,
                                          color: AppColors.orange)
                                    ]),
                                    const SizedBox(height: 7),
                                    Text('${w.distance} • ${w.hours}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.muted)),
                                    const SizedBox(height: 8),
                                    Row(children: [
                                      const Icon(Icons.star_rounded,
                                          color: AppColors.warning, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                          '${w.rating.toStringAsFixed(1)} (${w.reviewCount})',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                      const Spacer(),
                                      if (c.workshop == w.name)
                                        const Icon(Icons.check_circle_rounded,
                                            color: AppColors.orange, size: 20)
                                    ])
                                  ])))),
                      const SizedBox(height: 10),
                      const SectionTitle(title: 'Tanggal'),
                      const SizedBox(height: 10),
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: c.dates
                              .map((d) => ServiceChip(
                                  label: d,
                                  selected: c.dateLabel == d,
                                  onTap: () => c.chooseDate(d)))
                              .toList()),
                      const SizedBox(height: 20),
                      const SectionTitle(title: 'Jam kedatangan'),
                      const SizedBox(height: 10),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: c.times.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3.5),
                          itemBuilder: (ctx, i) => ServiceChip(
                              label: c.times[i],
                              selected: c.timeLabel == c.times[i],
                              onTap: () => c.chooseTime(c.times[i]))),
                      const SizedBox(height: 18),
                      AppCard(
                          backgroundColor: AppColors.softOrange,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(title: 'Ringkasan estimasi'),
                                const SizedBox(height: 8),
                                Text(
                                    '${rupiah(c.totalEstimate)} • ± ${c.totalDurationMinutes} menit',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(height: 3),
                                const Text(
                                    'Estimasi final dapat berubah setelah pemeriksaan bengkel.',
                                    style: TextStyle(
                                        fontSize: 11, color: AppColors.muted))
                              ])),
                      const SizedBox(height: 18),
                      PrimaryButton(
                          label: 'Lanjutkan review',
                          onPressed: c.canReview
                              ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ReviewBookingScreen()))
                              : null)
                    ]))));
  }
}
