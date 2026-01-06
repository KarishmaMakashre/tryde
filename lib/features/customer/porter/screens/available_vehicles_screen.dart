import 'package:flutter/material.dart';
import 'package:tryde/features/customer/porter/screens/booking_confirmed_screen.dart';
import '../../../../core/constants/color_constants.dart';

class AvailableVehiclesScreen extends StatelessWidget {
  const AvailableVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleImages = [
      "https://cdn-icons-png.flaticon.com/512/743/743131.png", // Truck
      "https://cdn-icons-png.flaticon.com/512/741/741407.png", // Bus
      "https://cdn-icons-png.flaticon.com/512/744/744465.png", // Car
    ];

    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        title: const Text("Available Vehicles"),
        centerTitle: true,
        backgroundColor: AppColors.porterPrimary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: vehicleImages.length,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

              /// 🚗 🚚 🚌 Network Vehicle Image
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  vehicleImages[index],
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 55,
                      height: 55,
                      color: AppColors.porterPrimaryLight,
                      child: Icon(
                        Icons.directions_car,
                        color: AppColors.porterPrimaryDark,
                      ),
                    );
                  },
                ),
              ),

              title: const Text(
                "Eicher 11.10 - 2018",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text("Capacity: 11 Ton\nType: 6 Wheel"),
              ),

              /// 🔘 BOOK Button
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.porterPrimary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingConfirmedScreen(),
                    ),
                  );
                },
                child: const Text("BOOK"),
              ),
            ),
          );
        },
      ),
    );
  }
}
