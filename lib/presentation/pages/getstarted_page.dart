import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/button/basic_app_button.dart';
import '../../core/configs/assets/app_images.dart';
import '../../core/configs/theme/app_colors.dart';
import 'login/signup_or_signin.dart';
import 'mode/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.getStarted),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.black.withOpacity(0.2), // Optional color overlay
              ),
            ),
          ),

          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          // Text and button aligned to the bottom-left of the page
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(

              padding: const EdgeInsets.only(top:500), // Adjust padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find Your Rhythm and Enjoy \nthe Music!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.4, // Line height for better readability
                    ),
                  ),
                  const Text(
                    'Enjoy to hear the best music with us',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20), // Space between text and button
                  BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => const SignupOrSigninPage()
                            )
                        );
                      },
                      title: 'Continue'
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
