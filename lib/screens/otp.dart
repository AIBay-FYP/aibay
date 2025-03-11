import 'package:aibay/providers/auth.dart';
import 'package:aibay/screens/home.dart';
import 'package:aibay/theme/app_colors.dart';
import 'package:aibay/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
// Ensure you're using go_router for navigation

class OTPScreen extends ConsumerWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authState = ref.watch(authControllerProvider);

    // Controller to capture OTP input
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        title: SvgPicture.asset(
          'lib/assets/logos/bg_logo.svg',
          height: 40,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            double paddingHorizontal = screenWidth * 0.05;
            double paddingVertical = screenHeight * 0.08;
            double buttonHeight = screenHeight * 0.07;
            double fontSize = screenWidth * 0.05;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: paddingVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Verification",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      fontSize: fontSize,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.primaryTextColorLight
                          : AppTheme.primaryTextColorDark,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Login to your account and discover high-quality demand-based products",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sora',
                      fontSize: fontSize * 0.65,
                      color: AppTheme.secondaryTextColorDark,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      fontSize: fontSize * 0.75,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.primaryTextColorLight
                          : AppTheme.primaryTextColorDark,
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.02),
                  OtpTextField(
                    showCursor: false,
                    borderWidth: 2,
                    numberOfFields: 6,
                    fieldWidth: screenWidth * 0.13,
                    filled: true,
                    fillColor: colorScheme.onSecondary,
                    showFieldAsBox: true,
                    borderColor: colorScheme.onSecondary,
                    enabledBorderColor: colorScheme.onSecondary,
                    focusedBorderColor: colorScheme.primary,
                    
                    onSubmit: (String verificationCode) {
                      otpController.text = verificationCode; // Store OTP
                    },
                  ),
                  
                  SizedBox(height: screenHeight * 0.04),
                  
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: CustomBlueButton(
                      text: "Verify",
                      onPressed: () async {
                        final authController =
                            ref.read(authControllerProvider.notifier);
                        final otp = otpController.text.trim();

                        if (otp.isEmpty || otp.length < 5) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter a valid OTP")),
                          );
                          return;
                        }

                        bool token = await authController.signInWithOtp(otp);

                        if (token) {
                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            HomeScreen()
                          )); // Navigate to home screen on success
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("OTP Verification failed")),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: colorScheme.surface,
    );
  }
}
