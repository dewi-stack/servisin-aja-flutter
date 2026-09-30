import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../state/booking_controller.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  // ============================================================
  // STATE
  // ============================================================

  int rating = 0;

  final TextEditingController review = TextEditingController();

  final Set<String> aspects = {'Pelayanan'};

  static const List<String> availableAspects = [
    'Pelayanan',
    'Kecepatan',
    'Kebersihan',
  ];

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    review.dispose();
    super.dispose();
  }

  // ============================================================
  // SUBMIT RATING
  // ============================================================

  void _submitRating(BuildContext context) {
    if (rating == 0) return;

    final controller = context.read<BookingController>();

    controller.submitRating(
      rating.toDouble(),
      review.text.trim(),
    );

    Navigator.of(context).pop();
  }

  // ============================================================
  // TOGGLE ASPECT
  // ============================================================

  void _toggleAspect(String aspect) {
    setState(() {
      if (aspects.contains(aspect)) {
        aspects.remove(aspect);
      } else {
        aspects.add(aspect);
      }
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final c = context.watch<BookingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            24,
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
                  // --------------------------------------------------------
                  // BACK BUTTON
                  // --------------------------------------------------------

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
                        Icons.chevron_left_rounded,
                        size: 22,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  // --------------------------------------------------------
                  // HEADER TEXT
                  // --------------------------------------------------------

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // STATUS
                        Text(
                          'SELESAI',
                          style: TextStyle(
                            fontSize: 9,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: AppColors.orange,
                          ),
                        ),

                        SizedBox(height: 5),

                        // TITLE
                        Text(
                          'Beri rating bengkel',
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202124),
                          ),
                        ),

                        SizedBox(height: 5),

                        // SUBTITLE
                        Text(
                          'Bantu pengguna lain memilih bengkel.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ============================================================
              // MAIN QUESTION
              // ============================================================

              const Center(
                child: Text(
                  'Bagaimana pengalaman Anda?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // ============================================================
              // WORKSHOP NAME
              // ============================================================

              Center(
                child: Text(
                  c.workshop,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: AppColors.muted,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ============================================================
              // STAR RATING
              // ============================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) {
                    final selected = index < rating;

                    return SizedBox(
                      width: 38,
                      height: 42,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        tooltip: '${index + 1} bintang',
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                        icon: Icon(
                          selected
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 30,
                          color: AppColors.orange,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 2),

              // ============================================================
              // RATING VALUE
              // ============================================================

              Center(
                child: Text(
                  '$rating dari 5',
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.1,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF202124),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ============================================================
              // ASPECT TITLE
              // ============================================================

              const Text(
                'Pilih aspek layanan',
                style: TextStyle(
                  fontSize: 11,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 9),

              // ============================================================
              // ASPECT CHIPS
              // ============================================================

              Row(
                children: availableAspects.map(
                  (aspect) {
                    final selected = aspects.contains(aspect);

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: aspect != availableAspects.last ? 8 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () => _toggleAspect(aspect),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: 34,
                            decoration: BoxDecoration(
                              color: selected ? AppColors.orange : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected
                                    ? AppColors.orange
                                    : const Color(0xFFDCDCDC),
                                width: 0.8,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              aspect,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                height: 1,
                                fontWeight: FontWeight.w500,
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF202124),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),

              const SizedBox(height: 18),

              // ============================================================
              // REVIEW FIELD
              // ============================================================

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFDCDCDC),
                    width: 0.8,
                  ),
                ),
                child: TextField(
                  controller: review,
                  maxLines: 4,
                  maxLength: 250,
                  textInputAction: TextInputAction.newline,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF202124),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Tulis ulasan',
                    hintStyle: TextStyle(
                      fontSize: 11,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                      color: AppColors.muted,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                      12,
                      12,
                      12,
                      12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SUBMIT BUTTON
              // ============================================================

              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: rating == 0 ? null : () => _submitRating(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,

                    // Tetap menggunakan orange ketika disabled
                    // agar sesuai dengan screenshot / design.
                    disabledBackgroundColor: AppColors.orange,

                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white,

                    elevation: 0,

                    padding: EdgeInsets.zero,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kirim rating',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
