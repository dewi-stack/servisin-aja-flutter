import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:servisin_aja/data/mock/mock_data.dart';
import 'package:servisin_aja/domain/entities/booking.dart';
import 'package:servisin_aja/domain/entities/vehicle.dart';
import 'package:servisin_aja/domain/repositories/booking_repository.dart';
import 'package:servisin_aja/presentation/screens/home_screen.dart';
import 'package:servisin_aja/state/booking_controller.dart';

void main() {
  testWidgets('home renders', (tester) async {
    final repository = TestBookingRepository();

    final controller = BookingController(
      repository: repository,
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<BookingController>.value(
        value: controller,
        child: MaterialApp(
          home: HomeScreen(
            controller: controller,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Servisin Aja'),
      findsOneWidget,
    );

    expect(
      find.text('Butuh servis hari ini?'),
      findsOneWidget,
    );
  });
}

// ============================================================================
// TEST REPOSITORY
// ============================================================================

class TestBookingRepository implements BookingRepository {
  @override
  List<Vehicle> getVehicles() {
    return MockData.vehicles;
  }

  @override
  Booking getActiveBooking() {
    return MockData.sampleBooking();
  }
}
