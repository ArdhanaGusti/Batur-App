import 'package:capstone_design/presentation/screens/forgot_password.dart';
import 'package:capstone_design/presentation/screens/login_screen.dart';
import 'package:capstone_design/presentation/screens/on_boarding_screen.dart';
import 'package:capstone_design/presentation/screens/registration_screen.dart';
import 'package:capstone_design/presentation/screens/registration_setting_screen.dart';
import 'package:capstone_design/presentation/screens/reset_password_screen.dart';
import 'package:capstone_design/presentation/screens/verification_screen.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Favorite Screen"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationScreen(),
                ),
              );
            },
            child: const Text("Regis"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnBoardingScreen(),
                ),
              );
            },
            child: const Text("On Boarding"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerificationScreen(),
                ),
              );
            },
            child: const Text("Verifikasi"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationSettingScreen(),
                ),
              );
            },
            child: const Text("Setting"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                ),
              );
            },
            child: const Text("Lupa Password"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              );
            },
            child: const Text("Reset Password"),
          ),
        ],
      ),
    );
  }
}
