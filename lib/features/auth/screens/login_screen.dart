// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/utils/validators.dart';
// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/color_constants.dart'; // Assuming AppColors is in color_constants.dart

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = TextEditingController();
//   bool _rememberMe = false;
//   String? _phoneError; // To store error for custom display

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

// void _onSendOtp() {
//   setState(() => _phoneError = Validators.validatePhone(_phoneController.text));
//   if (_phoneError == null) {
//     context.push(AppConstants.routeOtp); // Changed from go() to push() for stack navigation
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const SizedBox(height: 60),

//               SizedBox(
//                 height: 200,
//                 child: Image.asset(AppConstants.loginBannerPath),
//               ),

//               const SizedBox(height: 20),
//               Text(
//                 "Welcome to ${AppConstants.appName}",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),

//               const SizedBox(height: 10),
//               Text(
//                 "Log in or sign up",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textLight,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // PHONE FIELD Container (no error inside)
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.grey300),
//                 ),
//                 child: Row(
//                   children: [
//                     Text("+91", style: TextStyle(fontSize: 16, color: AppColors.textPrimary)),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: TextFormField(
//                         controller: _phoneController,
//                         keyboardType: TextInputType.number,
//                         maxLength: 10, // Prevent more than 10 digits
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only numbers
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Enter Phone Number",
//                           counterText: '', // Hide counter
//                         ),
//                         // No validator here; handled manually for custom error display
//                         style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Custom Error Display Outside Border
//               if (_phoneError != null)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       _phoneError!,
//                       style: TextStyle(
//                         color: AppColors.error,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 10),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Checkbox(
//                     value: _rememberMe,
//                     onChanged: (value) {
//                       setState(() => _rememberMe = value ?? false);
//                     },
//                     activeColor: AppColors.primary,
//                   ),
//                   Flexible(
//                     child: Text(
//                       "Remember my login for faster sign-in",
//                       style: TextStyle(color: AppColors.textSecondary),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20), // Space before button

//               // SEND OTP BUTTON
//               Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: _onSendOtp,
//                   child: const Text("Send OTP", style: TextStyle(fontSize: 16, color: Colors.white)),
//                 ),
//               ),

//               const SizedBox(height: 40), // Bottom padding
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/color_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  String? _phoneError;

  late final AnimationController _floatController;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -12, end: 12).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    final phone = _phoneController.text.trim();
    setState(() {
      _phoneError = Validators.validatePhone(phone);
    });
    if (_phoneError == null) {
      // push with extra (phone)
      context.push(AppConstants.routeOtp, extra: phone);
    }
  }

  Widget _floatingCircle({
    required double size,
    required Color color,
    required double dx,
    required double dy,
  }) {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(dx + _floatAnim.value, dy - _floatAnim.value / 2),
          child: child,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // For keyboard-aware button placement
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Floating background shapes
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  left: -40,
                  top: 40,
                  child: _floatingCircle(
                    size: 140,
                    color: Colors.blue.shade100.withOpacity(0.22),
                    dx: 0,
                    dy: 0,
                  ),
                ),
                Positioned(
                  right: -30,
                  top: 140,
                  child: _floatingCircle(
                    size: 100,
                    color: Colors.purple.shade100.withOpacity(0.22),
                    dx: 0,
                    dy: 0,
                  ),
                ),
                Positioned(
                  left: 40,
                  bottom: 200,
                  child: _floatingCircle(
                    size: 110,
                    color: Colors.teal.shade100.withOpacity(0.14),
                    dx: 0,
                    dy: 0,
                  ),
                ),
              ],
            ),
          ),

          // Main content (scrollable)
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: 160,
              ), // leave room for floating button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top small back button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        color: Colors.white.withOpacity(0.9),
                        shape: const CircleBorder(),
                        elevation: 4,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 18),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ),
                  ),

                  // Banner Image (rounded bottom corners)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        AppConstants.loginBannerPath,
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 260,
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image,
                            size: 64,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Heading
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Enter your phone number",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Subtext (light)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "We'll send a one-time password (OTP) to verify your number.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Phone input card (glass-ish)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "+91",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 10,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                counterText: '',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              onChanged: (_) {
                                if (_phoneError != null) {
                                  setState(() {
                                    _phoneError = null;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Error message (if any)
                  if (_phoneError != null) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _phoneError!,
                        style: TextStyle(color: AppColors.error, fontSize: 12),
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // Small helper / OTP hint
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Make sure your number is correct. OTP will be valid for 5 minutes.",
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Optional: small legal text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: RichText(
                      text: TextSpan(
                        text: "By continuing, you accept the ",
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      child: ElevatedButton(
                        onPressed: _onSendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 6,
                        ),
                        child: const Text(
                          "Send OTP",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // space so content can scroll above button
                ],
              ),
            ),
          ),

          // Bottom Send OTP Button — keyboard aware
        ],
      ),
    );
  }
}
