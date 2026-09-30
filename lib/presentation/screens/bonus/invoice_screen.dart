import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/formatters.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../state/booking_controller.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                // ==========================================================
                // PAGE PADDING
                // ==========================================================

                padding: const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  24,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ======================================================
                    // HEADER
                    // ======================================================

                    const _InvoiceHeader(
                      invoiceNumber: 'SVA-20260928-0182',
                    ),

                    const SizedBox(height: 22),

                    // ======================================================
                    // WORKSHOP
                    // ======================================================

                    Text(
                      controller.workshop,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '28 Sep 2026 • 09.00 WIB',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF858585),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ======================================================
                    // VEHICLE INVOICES
                    // ======================================================

                    ...controller.selectedVehicles.map(
                      (vehicle) {
                        final config = controller.configFor(vehicle.id);

                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          child: _VehicleInvoiceCard(
                            vehicle: vehicle,
                            config: config,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 0),

                    // ======================================================
                    // TOTAL
                    // ======================================================

                    _TotalEstimate(
                      total: controller.totalEstimate,
                    ),

                    const SizedBox(height: 16),

                    // ======================================================
                    // DOWNLOAD / SHARE
                    // ======================================================

                    _InvoiceButton(
                      label: 'Download / Bagikan invoice',
                      icon: Icons.share_rounded,
                      onPressed: () {
                        // TODO:
                        // Tambahkan fungsi download / share invoice.
                      },
                    ),

                    const SizedBox(height: 8),
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

// ============================================================================
// HEADER
// ============================================================================

class _InvoiceHeader extends StatelessWidget {
  final String invoiceNumber;

  const _InvoiceHeader({
    required this.invoiceNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------------------------
        // BACK BUTTON
        // --------------------------------------------------------------------

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
              color: Color(0xFF252525),
            ),
          ),
        ),

        const SizedBox(width: 4),

        // --------------------------------------------------------------------
        // HEADER CONTENT
        // --------------------------------------------------------------------

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // INVOICE NUMBER

              Text(
                invoiceNumber,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1,
                  color: Color(0xFFFF5B16),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 5),

              // TITLE

              const Text(
                'Detail invoice',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 5),

              // SUBTITLE

              const Text(
                'Rincian estimasi biaya servis.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF858585),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// VEHICLE INVOICE CARD
// ============================================================================

class _VehicleInvoiceCard extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleServiceConfig config;

  const _VehicleInvoiceCard({
    required this.vehicle,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ====================================================================
        // VEHICLE NAME
        // ====================================================================

        Text(
          vehicle.displayName,
          style: const TextStyle(
            fontSize: 16,
            height: 1.15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF202124),
          ),
        ),

        const SizedBox(height: 8),

        // ====================================================================
        // CARD INVOICE
        // ====================================================================

        Container(
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
            children: [
              // ==============================================================
              // SERVICE TYPE
              // ==============================================================

              _InvoiceRow(
                label: config.serviceType.label,
                amount: rupiah(config.basePrice),
              ),

              // ==============================================================
              // SELECTED PARTS
              // ==============================================================

              for (final part in config.selectedParts)
                _InvoiceRow(
                  label: part.name,
                  amount: rupiah(part.price),
                ),

              const SizedBox(height: 3),

              // ==============================================================
              // DIVIDER
              // ==============================================================

              const Divider(
                height: 1,
                thickness: 0.7,
                color: Color(0xFFE6E6E6),
              ),

              const SizedBox(height: 10),

              // ==============================================================
              // SUBTOTAL
              // ==============================================================

              _InvoiceRow(
                label: 'Subtotal',
                amount: rupiah(config.estimate),
                strong: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// INVOICE ROW
// ============================================================================

class _InvoiceRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool strong;

  const _InvoiceRow({
    required this.label,
    required this.amount,
    this.strong = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ------------------------------------------------------------------
          // LABEL
          // ------------------------------------------------------------------

          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: strong ? 12 : 12,
                height: 1.2,
                color:
                    strong ? const Color(0xFF202124) : const Color(0xFF858585),
                fontWeight: strong ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ------------------------------------------------------------------
          // AMOUNT
          // ------------------------------------------------------------------

          Text(
            amount,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: strong ? 12 : 12,
              height: 1.2,
              color: const Color(0xFF202124),
              fontWeight: strong ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// TOTAL ESTIMATE
// ============================================================================

class _TotalEstimate extends StatelessWidget {
  final int total;

  const _TotalEstimate({
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBDD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ------------------------------------------------------------------
          // LABEL
          // ------------------------------------------------------------------

          const Expanded(
            child: Text(
              'Total estimasi',
              style: TextStyle(
                fontSize: 11,
                height: 1.2,
                color: Color(0xFF858585),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ------------------------------------------------------------------
          // TOTAL
          // ------------------------------------------------------------------

          Text(
            rupiah(total),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 18,
              height: 1.1,
              color: Color(0xFF202124),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// INVOICE BUTTON
// ============================================================================

class _InvoiceButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _InvoiceButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5B16),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TEXT

            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                height: 1,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 8),

            // ICON

            Icon(
              icon,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}
