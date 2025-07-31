import 'package:voltwheels_mobile/core/assets/assets.dart';

class VoltRentVehicle {
  final String id;
  final String distance;
  final String imagePath;
  final String name;
  final String price;
  final String qty;
  final String speed;
  final String capacity;
  final String rating;
  final String desc;
  final String longDesc;
  final String energy;
  final String location;
  final RentPlace rentPlace;

  const VoltRentVehicle({
    required this.id,
    required this.distance,
    required this.imagePath,
    this.name = "",
    this.price = "1000",
    this.qty = 'jam',
    this.energy = "0.15",
    required this.speed,
    required this.capacity,
    required this.rating,
    required this.desc,
    this.longDesc = "",
    this.location = "Klampis, Surabaya Timur",
    this.rentPlace = const RentPlace(),
  });
}

class RentPlace {
  final String name;
  final String location;

  const RentPlace({
    this.name = "Booth 21 SBY",
    this.location =
        "Jl. Rungkut Madya No.1, Gn. Anyar, Kec. Gn. Anyar, Surabaya, Jawa Timur 60294",
  });
}

List<VoltRentVehicle> generateDummyVehicles() {
  return [
    const VoltRentVehicle(
      id: '1',
      distance: "1.2 km",
      imagePath: Assets.voltRentMotor2,
      name: "PowerStride",
      price: "100",
      speed: "180",
      capacity: "1",
      rating: "5",
      energy: "0.15",
      desc: "A fast and efficient electric scooter perfect for city commutes.",
      longDesc:
          "PowerStride adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
    ),
    const VoltRentVehicle(
      id: '3',
      distance: "1.2 km",
      imagePath: Assets.voltRentMotor3,
      name: "ElektraWave A12",
      price: "40000",
      speed: "96",
      capacity: "1",
      rating: "4.3",
      energy: "0.19",
      desc:
          "An eco-friendly electric bike, ideal for both short and long distances.",
      longDesc:
          "PowerStride adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
    ),
    const VoltRentVehicle(
      id: '2',
      distance: "1.5 km",
      imagePath: Assets.voltRentMotor4,
      name: "Elektrix S24",
      price: "30000",
      speed: "100",
      capacity: "2",
      rating: "4.8",
      energy: "0.2",
      desc: "A modern electric car with a spacious interior and high range.",
      longDesc:
          "PowerStride adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
    ),
    const VoltRentVehicle(
      id: '4',
      distance: "2 km",
      imagePath: Assets.voltRentMotor5,
      name: "ElectraSpeed",
      price: "25000",
      speed: "85",
      capacity: "2",
      rating: "4.7",
      energy: "0.14",
      desc:
          "A versatile electric van suitable for large groups or cargo transport.",
      longDesc:
          "PowerStride adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
    ),
    const VoltRentVehicle(
      id: '5',
      distance: "1.2 km",
      imagePath: Assets.voltRentMotor6,
      name: "ElectraZen ",
      price: "25000",
      speed: "80",
      capacity: "",
      rating: "4.2",
      energy: "0.15",
      desc:
          "A compact and fun electric hoverboard for quick trips around town.",
      longDesc:
          "PowerStride adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
    ),
  ];
}

List<VoltRentVehicle> carouselDummy = [
  const VoltRentVehicle(
    id: '6',
    distance: "1.2 km",
    imagePath: Assets.voltRentCar,
    name: "Electra v-25",
    price: "50000",
    speed: "200",
    capacity: "2",
    rating: "5",
    energy: "0.15",
    desc: "A fast and efficient electric scooter perfect for city commutes.",
    longDesc:
        "Electracar adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
  ),
  const VoltRentVehicle(
    id: '7',
    distance: "1.2 km",
    imagePath: Assets.voltRentMotor3,
    name: "Ecospark x-10",
    price: "40000",
    speed: "100",
    capacity: "1",
    rating: "4.9",
    energy: "0.19",
    desc:
        "An eco-friendly electric bike, ideal for both short and long distances.",
    longDesc:
        "PowerStride adalah motor listrik yang revolusioner, dirancang untuk memberikan pengalaman berkendara yang kuat, nyaman, dan ramah lingkungan",
  ),
];
