import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/mock/mock_data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = MockData.notifications;

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
                      onPressed: () {
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
                        // ------------------------------------------------
                        // EYEBROW
                        // ------------------------------------------------
                        Text(
                          'NOTIFIKASI',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.2,
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),

                        SizedBox(height: 4),

                        // ------------------------------------------------
                        // PAGE TITLE
                        // ------------------------------------------------
                        Text(
                          'Notifikasi',
                          style: TextStyle(
                            fontSize: 24,
                            height: 1.15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202124),
                          ),
                        ),

                        SizedBox(height: 6),

                        // ------------------------------------------------
                        // DESCRIPTION
                        // ------------------------------------------------
                        Text(
                          'Update penting tentang booking Anda.',
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
              // NOTIFICATION LIST
              // ============================================================
              ...data.map(
                (notification) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: _NotificationCard(
                      title: notification.title,
                      message: notification.message,
                      time: notification.time,
                      icon: notification.icon,
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
// NOTIFICATION CARD
// ==========================================================================

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // ICON
          // ================================================================
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.softOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.orange,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          // ================================================================
          // CONTENT
          // ================================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----------------------------------------------------------
                // TITLE
                // ----------------------------------------------------------
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),

                const SizedBox(height: 6),

                // ----------------------------------------------------------
                // MESSAGE
                // ----------------------------------------------------------
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.muted,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                // ----------------------------------------------------------
                // TIME
                // ----------------------------------------------------------
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
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
    );
  }
}
