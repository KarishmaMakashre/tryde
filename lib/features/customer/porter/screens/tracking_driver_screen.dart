import 'package:flutter/material.dart';
import 'package:tryde/core/constants/color_constants.dart';
import 'package:tryde/features/customer/porter/screens/widgets/action_buttons.dart';

class TrackingDriverScreen extends StatelessWidget {
  const TrackingDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Started")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: const Center(child: Text("Driver Map")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:AppColors.porterPrimary,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {},
                  child: const Text("Arrived Drop Location"),
                ),
                const ActionButtons(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
