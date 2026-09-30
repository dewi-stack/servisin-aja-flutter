import '../../domain/entities/booking.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/booking_repository.dart';
import 'mock_data.dart';

class MockBookingRepository implements BookingRepository {
  @override
  List<Vehicle> getVehicles() => MockData.vehicles;

  @override
  Booking getActiveBooking() => MockData.sampleBooking();
}
