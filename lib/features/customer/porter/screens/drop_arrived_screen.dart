import 'package:flutter/material.dart';
import 'package:tryde/core/constants/color_constants.dart';
import 'package:tryde/features/customer/porter/screens/porter-dashboard_screen.dart';

class DropArrivedScreen extends StatefulWidget {
  const DropArrivedScreen({super.key});

  @override
  State<DropArrivedScreen> createState() => _DropArrivedScreenState();
}

class _DropArrivedScreenState extends State<DropArrivedScreen> {
  bool unloadingStarted = false;
  bool unloadingCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        title: const Text("Drop Location Arrived"),
        backgroundColor: AppColors.porterPrimary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ☑ Unloading Started
            CheckboxListTile(
              value: unloadingStarted,
              activeColor: AppColors.porterPrimary,
              onChanged: (value) {
                setState(() {
                  unloadingStarted = value!;
                });
              },
              title: const Text("Unloading Started"),
            ),

            /// ☑ Unloading Completed
            CheckboxListTile(
              value: unloadingCompleted,
              activeColor: AppColors.porterPrimary,
              onChanged: (value) {
                setState(() {
                  unloadingCompleted = value!;
                });
              },
              title: const Text("Unloading Completed"),
            ),

            const Spacer(),

            /// 🔘 RECEIVER END Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.porterPrimary,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: unloadingCompleted
                  ? () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PorterDashboardScreen(),
                  ),
                );
              }
                  : null, // ❌ disabled until unloading completed
              child: const Text("RECEIVER END"),
            ),
          ],
        ),
      ),
    );
  }
}
