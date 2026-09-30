import '../entities/booking.dart';
import '../entities/vehicle.dart';

abstract class BookingRepository {
  List<Vehicle> getVehicles();
  Booking getActiveBooking();
}
