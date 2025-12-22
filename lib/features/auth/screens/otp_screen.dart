// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/utils/validators.dart';
// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/color_constants.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
//   final List<String> _otpDigits = List.generate(6, (_) => ''); // Individual digits
//   String _fullOtp = ''; // Combined for validation
//   String? _otpError;
//   bool _isComplete = false; // For button enable

//   @override
//   void initState() {
//     super.initState();
//     // Auto-focus first field on load
//     WidgetsBinding.instance.addPostFrameCallback((_) => _focusNodes[0].requestFocus());
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   void _onDigitChanged(int index, String value) {
//     if (value.length == 1 && int.tryParse(value) != null) {
//       // Valid digit entered
//       _otpDigits[index] = value;
//       _controllers[index].text = value;
//       _fullOtp = _otpDigits.join();
//       _updateCompletionStatus();

//       // Move to next field
//       if (index < 5) {
//         _focusNodes[index + 1].requestFocus();
//       } else {
//         // Last digit, auto-validate if complete
//         _validateOtp(auto: true);
//       }
//     } else if (value.isEmpty) {
//       // Backspace pressed: clear current and move previous
//       _otpDigits[index] = '';
//       _controllers[index].clear();
//       _fullOtp = _otpDigits.join();
//       _updateCompletionStatus();

//       if (index > 0) {
//         _focusNodes[index - 1].requestFocus();
//       }
//     } else {
//       // Invalid input: ignore or clear
//       _controllers[index].clear();
//     }
//   }

//   void _updateCompletionStatus() {
//     setState(() {
//       _isComplete = _otpDigits.every((digit) => digit.isNotEmpty);
//     });
//   }

//   void _validateOtp({bool auto = false}) {
//     final otpString = _fullOtp.replaceAll(' ', '');
//     setState(() => _otpError = Validators.validateOtp(otpString));
//     if (_otpError == null && (auto || !auto)) {
//       // Proceed to next screen (e.g., home/dashboard)
//       context.push(AppConstants.routeHome); // Or wherever
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar( // Added AppBar for proper back navigation
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
//           onPressed: () => context.pop(), // Go back to previous screen (login)
//         ),
//         backgroundColor: AppColors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10), // Adjusted for AppBar

//             SizedBox(
//               height: 260,
//               child: Image.asset(AppConstants.otpBannerPath),
//             ),

//             const SizedBox(height: 10),
//             Text(
//               "Welcome to ${AppConstants.appName}",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),

//             const SizedBox(height: 10),
//             Text(
//               "Enter the OTP",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textLight,
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 6 OTP Boxes Row (Smaller width to prevent overflow, responsive)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(6, (index) {
//                 return Container(
//                   height: 50,
//                   width: 45, // Reduced to 50 to avoid overflow
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.grey300),
//                   ),
//                   child: TextField(
//                     controller: _controllers[index],
//                     focusNode: _focusNodes[index],
//                     keyboardType: TextInputType.number,
//                     maxLength: 1,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     decoration: const InputDecoration(
//                       counterText: '',
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (value) => _onDigitChanged(index, value),
//                     onSubmitted: (_) => index < 5 ? _focusNodes[index + 1].requestFocus() : _validateOtp(),
//                   ),
//                 );
//               }),
//             ),

//             // Custom OTP Error Display (below boxes)
//             if (_otpError != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 child: Text(
//                   _otpError!,
//                   style: TextStyle(color: AppColors.error, fontSize: 12),
//                   textAlign: TextAlign.center,
//                 ),
//               ),

//             const SizedBox(height: 30),

//             // CONTINUE BUTTON (Enabled only if complete)
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isComplete ? AppColors.primary : AppColors.grey300,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: _isComplete ? () => _validateOtp(auto: false) : null,
//                 child: Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/color_constants.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<String> _otpDigits = List.generate(6, (_) => '');
  String _fullOtp = '';
  String? _otpError;
  bool _isComplete = false;

  late final AnimationController _floatController;
  late final Animation<double> _floatAnim;

  Timer? _resendTimer;
  int _secondsLeft = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();

    // auto focus first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });

    // floating animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // start resend timer
    _startResendCountdown();
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    setState(() {
      _secondsLeft = 30;
      _canResend = false;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) {
          _canResend = true;
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    _resendTimer?.cancel();
    _floatController.dispose();
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && int.tryParse(value) != null) {
      _otpDigits[index] = value;
      _controllers[index].text = value;
      _fullOtp = _otpDigits.join();
      _updateCompletionStatus();
      if (index < 5)
        _focusNodes[index + 1].requestFocus();
      else
        _validateOtp(auto: true);
    } else if (value.isEmpty) {
      _otpDigits[index] = '';
      _controllers[index].clear();
      _fullOtp = _otpDigits.join();
      _updateCompletionStatus();
      if (index > 0) _focusNodes[index - 1].requestFocus();
    } else {
      // ignore other input
      _controllers[index].clear();
    }
  }

  void _updateCompletionStatus() {
    setState(() {
      _isComplete = _otpDigits.every((d) => d.isNotEmpty);
    });
  }

  void _validateOtp({bool auto = false}) {
    final otpString = _fullOtp.replaceAll(' ', '');
    setState(() => _otpError = Validators.validateOtp(otpString));
    if (_otpError == null) {
      // success — navigate to home
      context.go(AppConstants.routeHome);
    }
  }

  void _resendOtp() {
    if (!_canResend) return;
    // call your resend API here
    _startResendCountdown();
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
              blurRadius: 14,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    return Container(
      width: 42,
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
        border: Border.all(color: AppColors.grey300),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (v) => _onDigitChanged(index, v),
          onSubmitted: (_) {
            if (index < 5)
              _focusNodes[index + 1].requestFocus();
            else
              _validateOtp();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // floating background
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  left: -30,
                  top: 40,
                  child: _floatingCircle(
                    size: 120,
                    color: Colors.purple.shade100.withOpacity(0.18),
                    dx: 0,
                    dy: 0,
                  ),
                ),
                Positioned(
                  right: -20,
                  top: 160,
                  child: _floatingCircle(
                    size: 90,
                    color: Colors.blue.shade100.withOpacity(0.18),
                    dx: 0,
                    dy: 0,
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 160),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Material(
                          color: Colors.white.withOpacity(0.9),
                          shape: const CircleBorder(),
                          elevation: 4,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios, size: 18),
                            onPressed: () => context.pop(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Enter OTP",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "OTP sent to +91 ${widget.phone}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // image (optional small banner)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Image.asset(
                      AppConstants.otpBannerPath,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // OTP boxes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (i) => _otpBox(i)),
                    ),
                  ),

                  if (_otpError != null) ...[
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _otpError!,
                        style: TextStyle(color: AppColors.error, fontSize: 12),
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // Resend / timer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code? ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        GestureDetector(
                          onTap: _canResend ? _resendOtp : null,
                          child: Text(
                            _canResend ? "Resend" : "Resend in $_secondsLeft s",
                            style: TextStyle(
                              color: _canResend
                                  ? AppColors.primary
                                  : Colors.black38,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: _isComplete
                          ? () => _validateOtp(auto: false)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isComplete
                            ? AppColors.primary
                            : AppColors.grey300,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Verify button positioned above keyboard
        ],
      ),
    );
  }
}
