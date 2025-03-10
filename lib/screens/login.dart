import 'package:aibay/providers/auth.dart';
import 'package:aibay/providers/google_auth.dart';
import 'package:aibay/providers/login.dart';
import 'package:aibay/providers/phoneNumber.dart';
import 'package:aibay/screens/otp.dart';
import 'package:aibay/theme/app_colors.dart';
import 'package:aibay/widgets/blue_button.dart';
import 'package:aibay/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final phoneNumber = ref.watch(phoneNumberProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

            double paddingHorizontal = screenWidth * 0.06;
            double paddingVertical = screenHeight * 0.08;
            double buttonHeight = screenHeight * 0.07; 
            double fontSize = screenWidth * 0.05; 
            double borderRadius = screenWidth * 0.03; 

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
                    "Log in to AI-Bay",
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
                    "Phone Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      fontSize: fontSize * 0.75,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.primaryTextColorLight
                          : AppTheme.primaryTextColorDark,
                    ),
                  ),
                  
                  PhoneNumberField(),
                  
                  SizedBox(height: screenHeight * 0.04),
                  
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: CustomBlueButton(
                      text: "Next", 
                      onPressed: () async {
                        final authController = ref.read(authControllerProvider.notifier);

                        bool isVerified = await authController.verifyPhoneNumber(phoneNumber);

                        if (isVerified) {
                            Navigator.push(context,MaterialPageRoute(
                              builder: (context) => OTPScreen()));
                          } else {
                            // Handle failure (e.g., show an error message)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Verification failed!")),
                            );
                          }
                      }),
                  ),
                  
                  SizedBox(height: screenHeight * 0.03),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorScheme.onSecondary,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colorScheme.onSecondary,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),


                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: ElevatedButton(
                          onPressed: () async {
                             final authController = ref.read(googleAuthControllerProvider.notifier);
                             bool success = await authController.signInWithGoogle();

                            if (success) {
                              print("🎉 Google Sign-In Successful!");
                              // TODO: Navigate to the home screen or update UI
                            } else {
                              print("❌ Google Sign-In Failed");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: colorScheme.surface,
                            backgroundColor: colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/logos/google.svg',  // ✅ Ensure correct asset path
                                height: fontSize, // Adjust icon size
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: fontSize * 0.75, // Adjust text size
                                ),
                              ),
                            ],
                          ),
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
