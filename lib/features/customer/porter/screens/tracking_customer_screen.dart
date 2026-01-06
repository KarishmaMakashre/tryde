import 'package:flutter/material.dart';
import 'package:tryde/core/constants/color_constants.dart';
import 'package:tryde/features/customer/porter/screens/drop_arrived_screen.dart';
import 'package:tryde/features/customer/porter/screens/widgets/action_buttons.dart';


class TrackingCustomerScreen extends StatelessWidget {
  const TrackingCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Tracking")),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/map.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text("Covered Distance • Time • Location"),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:AppColors.porterPrimary,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>DropArrivedScreen()));
                  },
                  child: const Text("Consignment Arrived"),
                ),
                const SizedBox(height: 10),
                const ActionButtons(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
