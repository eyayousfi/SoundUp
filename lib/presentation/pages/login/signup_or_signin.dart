import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sptify/common/helpers/is_dark_mode.dart';
import 'package:sptify/presentation/pages/login/sign_in_page.dart';
import 'package:sptify/presentation/pages/login/signup_page.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.authBG),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                color: Colors.black.withOpacity(0.5), // Darker overlay for better text visibility
              ),
            ),
          ),

          // App bar at the top
          const BasicAppbar(),

          // Positioned SVG patterns
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern, fit: BoxFit.cover),
          ),

          // Bottom-left section with messages and buttons
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(30), // Adjust padding for overall layout
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 150),

                  // Welcome message
                  const Text(
                    'Welcome to Your Music Journey!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.4, // Line height for better readability
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Instructional message
                  const Text(
                    'Please sign in to continue or register if you\'re new to our app.',
                    style: TextStyle(
                      color: AppColors.lightBackground,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Sign-in button
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SigninPage(),
                        ),
                      );
                    },
                    title: 'Sign In',
                    height: 50, // Adjust height as needed
                  ),
                  const SizedBox(height: 20),
                  // Register button
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignupPage(),
                        ),
                      );
                    },
                    title: 'Register',
                    height: 50, // Adjust height as needed
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
