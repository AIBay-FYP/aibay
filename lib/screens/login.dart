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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneNumberProvider);
    final loginState = ref.watch(loginProvider); // Watch the login state
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log in to AI-Bay",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sora',
                  fontSize: size.width * 0.06,
                  color: theme.brightness == Brightness.light
                      ? AppTheme.primaryTextColorLight
                      : AppTheme.primaryTextColorDark,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Login to your account and discover high-quality demand-based products",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Sora',
                  fontSize: size.width * 0.04,
                  color: AppTheme.secondaryTextColorDark,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sora',
                  fontSize: size.width * 0.045,
                  color: theme.brightness == Brightness.light
                      ? AppTheme.primaryTextColorLight
                      : AppTheme.primaryTextColorDark,
                ),
              ),
              PhoneNumberField(),
              SizedBox(height: size.height * 0.04),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.07,
                child: loginState.status == LoginStatus.loading
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      ) // Show loading indicator when status is loading
                    : CustomBlueButton(
                        text: "Next",
                        onPressed: () async {
                          final authController = ref.read(authControllerProvider.notifier);
                          ref.read(loginProvider.notifier).login(usernameController.text, passwordController.text); // Trigger login
                          final isVerified = await authController.verifyPhoneNumber(phoneNumber);
                          if (isVerified) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => OTPScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Verification failed!")),
                            );
                          }
                        },
                      ),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Expanded(child: Divider(color: colorScheme.onSecondary)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: colorScheme.onSecondary)),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.07,
                child: loginState.status == LoginStatus.loading
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      ) // Show loading indicator for Google sign-in
                    : ElevatedButton(
                        onPressed: () async {
                          final authController = ref.read(googleAuthControllerProvider.notifier);
                          bool success = await authController.signInWithGoogle();
                          if (success) {
                            print("🎉 Google Sign-In Successful!");
                          } else {
                            print("❌ Google Sign-In Failed");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: colorScheme.surface,
                          backgroundColor: colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(size.width * 0.03),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('lib/assets/logos/google_logo.png', height: size.width * 0.06),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.045,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
      backgroundColor: colorScheme.surface,
    );
  }
}
