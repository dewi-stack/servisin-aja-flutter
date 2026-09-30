import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/vehicle.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(14),
  });

  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: child,
    );

    if (onTap == null) {
      return card;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: card,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.label, required this.onPressed, this.icon});
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext c) => SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
          label: Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.orange,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.border,
              disabledForegroundColor: AppColors.muted,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button)))));
}

class PageHeader extends StatelessWidget {
  const PageHeader(
      {super.key,
      required this.step,
      required this.title,
      required this.subtitle,
      this.onBack});
  final String step, title, subtitle;
  final VoidCallback? onBack;
  @override
  Widget build(BuildContext c) {
    final body =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(step,
          style: const TextStyle(
              fontSize: 11,
              color: AppColors.orange,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 3),
      Text(title,
          style: const TextStyle(
              fontSize: 24, height: 1.15, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text(subtitle,
          style: const TextStyle(fontSize: 12, color: AppColors.muted))
    ]);
    if (onBack == null) return body;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
          onTap: onBack,
          child: const SizedBox(
              width: 26,
              height: 42,
              child: Icon(Icons.chevron_left_rounded, size: 28))),
      const SizedBox(width: 8),
      Expanded(child: body)
    ]);
  }
}

class VehicleCard extends StatelessWidget {
  const VehicleCard(
      {super.key,
      required this.vehicle,
      required this.selected,
      required this.onTap,
      this.showChevron = false});
  final Vehicle vehicle;
  final bool selected;
  final VoidCallback onTap;
  final bool showChevron;
  @override
  Widget build(BuildContext c) => AppCard(
      onTap: onTap,
      child: Row(children: [
        Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: selected ? AppColors.softOrange : AppColors.background,
                borderRadius: BorderRadius.circular(12)),
            child: const Text('🏍️', style: TextStyle(fontSize: 20))),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(vehicle.displayName,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('${vehicle.plate} • ${vehicle.year}',
              style: const TextStyle(fontSize: 11, color: AppColors.muted))
        ])),
        showChevron
            ? const Icon(Icons.chevron_right_rounded, color: AppColors.orange)
            : Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                        color: selected ? AppColors.orange : AppColors.border)),
                child: selected
                    ? const Icon(Icons.check, size: 14, color: AppColors.orange)
                    : null)
      ]));
}

class ServiceChip extends StatelessWidget {
  const ServiceChip(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext c) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
              color: selected ? AppColors.orange : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: selected ? AppColors.orange : AppColors.border)),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.dark))));
}

class PartCard extends StatelessWidget {
  const PartCard(
      {super.key,
      required this.part,
      required this.selected,
      required this.onTap});
  final PartOption part;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext c) => AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: selected ? AppColors.softOrange : AppColors.background,
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
                part.category == 'Oli'
                    ? Icons.opacity_rounded
                    : Icons.settings_rounded,
                color: AppColors.orange,
                size: 21)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(part.name,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('${part.brand} • ${rupiah(part.price)}',
              style: const TextStyle(fontSize: 11, color: AppColors.muted))
        ])),
        Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.orange : Colors.white,
                border: Border.all(
                    color: selected ? AppColors.orange : AppColors.border)),
            child: selected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null)
      ]));
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final BookingStatus status;
  @override
  Widget build(BuildContext c) {
    late Color bg, fg;
    switch (status) {
      case BookingStatus.waiting:
        bg = AppColors.softWarning;
        fg = AppColors.warning;
      case BookingStatus.confirmed:
        bg = AppColors.softOrange;
        fg = AppColors.orange;
      case BookingStatus.working:
        bg = AppColors.orangeDark;
        fg = Colors.white;
      case BookingStatus.completed:
        bg = AppColors.softSuccess;
        fg = AppColors.success;
      case BookingStatus.cancelled:
        bg = const Color(0xFFFFE7E7);
        fg = AppColors.error;
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
        child: Text(status.label,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600, color: fg)));
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.index, required this.onChanged});
  final int index;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext c) => BottomNavigationBar(
          currentIndex: index,
          onTap: onChanged,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.orange,
          unselectedItemColor: AppColors.muted,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded), label: 'Booking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.track_changes_rounded), label: 'Tracking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profil')
          ]);
}
