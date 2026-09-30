class Workshop {
  const Workshop({
    required this.id,
    required this.name,
    required this.distance,
    required this.hours,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.facilities,
  });

  final String id;
  final String name;
  final String distance;
  final String hours;
  final double rating;
  final int reviewCount;
  final String address;
  final List<String> facilities;
}

class Mechanic {
  const Mechanic({
    required this.id,
    required this.name,
    required this.role,
    required this.rating,
    required this.completedJobs,
  });

  final String id;
  final String name;
  final String role;
  final double rating;
  final int completedJobs;
}
