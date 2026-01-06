import 'package:flutter/material.dart';
import 'package:tryde/core/constants/color_constants.dart';
import 'package:tryde/features/customer/porter/screens/tracking_customer_screen.dart';

class BookingConfirmedScreen extends StatefulWidget {
  const BookingConfirmedScreen({super.key});

  @override
  State<BookingConfirmedScreen> createState() =>
      _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState extends State<BookingConfirmedScreen> {
  bool loadingStarted = false;
  bool loadingCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        title: const Text("Booking Confirmed"),
        backgroundColor: AppColors.porterPrimary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// 🗺️ Network Map Image
          Expanded(
            child: Image.asset(
              'assets/images/map.jpg',
              fit: BoxFit.cover,
            ),
          ),

          /// ⬇ Bottom Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ARRIVED Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.porterPrimary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {},
                  child: const Text("ARRIVED"),
                ),

                const SizedBox(height: 8),

                /// ☑ Loading Started
                CheckboxListTile(
                  value: loadingStarted,
                  activeColor: AppColors.porterPrimary,
                  onChanged: (value) {
                    setState(() {
                      loadingStarted = value!;
                    });
                  },
                  title: const Text("Loading Started"),
                ),

                /// ☑ Loading Completed
                CheckboxListTile(
                  value: loadingCompleted,
                  activeColor: AppColors.porterPrimary,
                  onChanged: (value) {
                    setState(() {
                      loadingCompleted = value!;
                    });
                  },
                  title: const Text("Loading Completed"),
                ),

                const SizedBox(height: 8),

                /// START RIDE Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.porterPrimaryDark,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: loadingCompleted
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const TrackingCustomerScreen(),
                      ),
                    );
                  }
                      : null, // ❌ disabled until loading completed
                  child: const Text("START RIDE"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
