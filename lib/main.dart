import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/mock/mock_data.dart';
import 'domain/entities/booking.dart';
import 'domain/entities/vehicle.dart';
import 'domain/repositories/booking_repository.dart';
import 'state/booking_controller.dart';
import 'presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = MockBookingRepository();

  final controller = BookingController(
    repository: repository,
  );

  runApp(
    ChangeNotifierProvider<BookingController>.value(
      value: controller,
      child: const ServisinAjaApp(),
    ),
  );
}

// ============================================================================
// MOCK BOOKING REPOSITORY
// ============================================================================

class MockBookingRepository implements BookingRepository {
  @override
  List<Vehicle> getVehicles() {
    return MockData.vehicles;
  }

  @override
  Booking getActiveBooking() {
    return MockData.sampleBooking();
  }
}

// ============================================================================
// APP
// ============================================================================

class ServisinAjaApp extends StatelessWidget {
  const ServisinAjaApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Servisin Aja',
      theme: AppTheme.light(),
      home: HomeScreen(
        controller: context.read<BookingController>(),
      ),
    );
  }
}
