import 'package:aibay/screens/otp.dart';
import 'package:aibay/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:aibay/providers/theme_provider.dart';
import 'package:aibay/screens/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: theme,
    //   home: OTPScreen(),
    // );

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: theme,
      home: LoginScreen(),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: theme,
    //   home: ChatScreen(),
    // );
  }
}
