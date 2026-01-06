import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde/core/constants/app_constants.dart';
import 'package:tryde/core/constants/color_constants.dart';
import 'package:tryde/l10n/app_localizations.dart';

class PorterDashboardScreen extends StatefulWidget {
  const PorterDashboardScreen({super.key});

  @override
  State<PorterDashboardScreen> createState() => _PorterDashboardScreenState();
}

class _PorterDashboardScreenState extends State<PorterDashboardScreen> {
  final String _currentAddress =
      "Delhi Apollo Premises, Vijay Nagar, 16 Rithala Lok Colony...";

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    final double paddingH = size.width * 0.04;
    final double iconSize = size.width * 0.07;
    final double titleSize = size.width * 0.045;
    final double subtitleSize = size.width * 0.035;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),

                /// Pickup Card
                Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.porterPrimaryLight.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.porterPrimary,
                        size: iconSize,
                      ),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pick up from",
                              style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              _currentAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: subtitleSize,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                /// Vehicle Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    vehicleOption(Icons.local_shipping, "Truck", size),
                    vehicleOption(Icons.two_wheeler, "Bike", size),
                    vehicleOption(Icons.directions_car, "Car", size),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                /// Rewards
                Container(
                  padding: EdgeInsets.all(size.width * 0.05),
                  decoration: BoxDecoration(
                    color: AppColors.porterPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellow,
                        size: iconSize,
                      ),
                      SizedBox(width: size.width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Porter Rewards",
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Earn 2 coins for every ₹100 spent",
                            style: TextStyle(
                              fontSize: subtitleSize,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                /// Announcements
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Announcements",
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: AppColors.porterPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.015),

                Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      Icon(
                        Icons.campaign,
                        color: AppColors.porterPrimary,
                        size: size.width * 0.1, // responsive icon
                      ),
                      SizedBox(width: size.width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Introducing Porter Enterprise",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.038, // responsive text
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            // Add more details if needed
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: TextStyle(
                            color: AppColors.porterPrimary,
                            fontSize:
                                size.width * 0.034, // responsive button text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                /// Orders
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      TabBar(
                        labelColor: AppColors.porterPrimary,
                        unselectedLabelColor: AppColors.textLight,
                        indicatorColor: AppColors.porterPrimary,
                        labelStyle: TextStyle(fontSize: subtitleSize),
                        tabs: const [
                          Tab(text: "Active"),
                          Tab(text: "Complete"),
                          Tab(text: "Inbox"),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.42,
                        child: TabBarView(
                          children: [
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                orderOptionCard(
                                  size: size,
                                  title: "Deliver Now",
                                  subtitle:
                                      "We will assign a nearby 2-Wheeler to pick up and deliver as soon as possible",
                                  icon: Icons.access_time_filled,
                                  color: AppColors.porterPrimaryLight,
                                ),
                                SizedBox(height: size.height * 0.02),
                                orderOptionCard(
                                  size: size,
                                  title: "By End of the day",
                                  subtitle:
                                      "Place your order by 4 PM and get it picked up to 6 PM and delivered by 9 PM. Save 40%",
                                  icon: Icons.calendar_today,
                                  color: AppColors.porterPrimaryLight,
                                  badge: "Save 40%",
                                ),
                              ],
                            ),
                            const Center(child: Text("No completed orders")),
                            const Center(child: Text("No inbox items")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vehicleOption(IconData icon, String label, Size size) {
    final routeVehicle = label.toLowerCase();

    return GestureDetector(
      onTap: () {
        context.push('${AppConstants.routePorterSearch}/$routeVehicle');
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.045),
            decoration: BoxDecoration(
              color: AppColors.porterPrimary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: size.width * 0.08,
              color: AppColors.porterPrimary,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderOptionCard({
    required Size size,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    String? badge,
  }) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: size.width * 0.1, color: color),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badge != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.006,
                    ),
                    margin: EdgeInsets.only(bottom: size.height * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: size.width * 0.033,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
