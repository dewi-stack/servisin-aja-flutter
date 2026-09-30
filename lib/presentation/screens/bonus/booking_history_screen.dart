import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/mock/mock_data.dart';
import '../../../domain/entities/booking.dart';
import '../../../state/booking_controller.dart';
import '../../widgets/app_components.dart';
import 'invoice_screen.dart';
import 'mechanic_tracking_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({
    super.key,
    this.embedded = false,
    this.onBackHome,
  });

  final bool embedded;
  final VoidCallback? onBackHome;

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  String filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();

    final bookings = MockData.bookings;

    final filteredBookings = bookings.where((booking) {
      if (filter == 'Semua') {
        return true;
      }

      if (filter == 'Selesai') {
        return _isCompleted(booking);
      }

      if (filter == 'Dibatalkan') {
        return _isCancelled(booking);
      }

      return true;
    }).toList();

    final content = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        widget.embedded ? 26 : 8,
        24,
        32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // EMBEDDED HOME ACTION
          // ================================================================
          if (widget.embedded && widget.onBackHome != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.onBackHome,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Beranda',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ),

          // ================================================================
          // PAGE HEADER
          // ================================================================
          PageHeader(
            step: 'RIWAYAT',
            title: 'Riwayat booking',
            subtitle: 'Semua transaksi servis Anda.',
            onBack: widget.embedded ? null : () => Navigator.pop(context),
          ),

          const SizedBox(height: 24),

          // ================================================================
          // FILTER
          // ================================================================
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Semua',
              'Selesai',
              'Dibatalkan',
            ].map(
              (value) {
                return ServiceChip(
                  label: value,
                  selected: filter == value,
                  onTap: () {
                    setState(() {
                      filter = value;
                    });
                  },
                );
              },
            ).toList(),
          ),

          const SizedBox(height: 16),

          // ================================================================
          // BOOKING LIST
          // ================================================================
          if (filteredBookings.isEmpty)
            const _EmptyHistory()
          else
            ...filteredBookings.map(
              (booking) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: _BookingHistoryCard(
                  booking: booking,
                  controller: controller,
                ),
              ),
            ),
        ],
      ),
    );

    return widget.embedded
        ? SafeArea(
            bottom: false,
            child: content,
          )
        : Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            body: SafeArea(
              child: content,
            ),
          );
  }

  // =========================================================================
  // FILTER HELPERS
  // =========================================================================

  bool _isCompleted(Booking booking) {
    return booking.statusByVehicle.values.every(
      (status) => status.toLowerCase().contains('selesai'),
    );
  }

  bool _isCancelled(Booking booking) {
    return booking.statusByVehicle.values.any(
      (status) => status.toLowerCase().contains('batal'),
    );
  }
}

// ==========================================================================
// BOOKING HISTORY CARD
// ==========================================================================

class _BookingHistoryCard extends StatelessWidget {
  const _BookingHistoryCard({
    required this.booking,
    required this.controller,
  });

  final Booking booking;
  final BookingController controller;

  @override
  Widget build(BuildContext context) {
    final completed = _isCompleted();

    final total =
        controller.totalEstimate == 0 ? 328000 : controller.totalEstimate;

    return AppCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => completed
                ? const InvoiceScreen()
                : const MechanicTrackingScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // STATUS
          // ================================================================
          StatusBadge(
            status:
                completed ? BookingStatus.completed : BookingStatus.confirmed,
          ),

          const SizedBox(height: 12),

          // ================================================================
          // BOOKING ID
          // ================================================================
          Text(
            booking.id,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202124),
            ),
          ),

          const SizedBox(height: 6),

          // ================================================================
          // VEHICLE + WORKSHOP
          // ================================================================
          Text(
            '${booking.statusByVehicle.length} kendaraan • '
            '${booking.workshopName}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              height: 1.35,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
            ),
          ),

          const SizedBox(height: 6),

          // ================================================================
          // PRICE + DATE
          // ================================================================
          Text(
            '${rupiah(total)} • ${booking.dateLabel}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              height: 1.3,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
            ),
          ),

          const SizedBox(height: 4),

          // ================================================================
          // TIME
          // ================================================================
          Text(
            booking.timeLabel,
            style: const TextStyle(
              fontSize: 11,
              height: 1.25,
              fontWeight: FontWeight.w400,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  bool _isCompleted() {
    return booking.statusByVehicle.values.every(
      (status) => status.toLowerCase().contains('selesai'),
    );
  }
}

// ==========================================================================
// EMPTY HISTORY
// ==========================================================================

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            // ================================================================
            // ICON
            // ================================================================
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.softOrange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.history_rounded,
                size: 28,
                color: AppColors.orange,
              ),
            ),

            const SizedBox(height: 16),

            // ================================================================
            // TITLE
            // ================================================================
            const Text(
              'Belum ada riwayat booking',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.25,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 8),

            // ================================================================
            // DESCRIPTION
            // ================================================================
            const Text(
              'Transaksi servis Anda akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
