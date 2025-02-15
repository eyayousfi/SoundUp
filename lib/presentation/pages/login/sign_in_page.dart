import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sptify/common/widgets/appbar/app_bar.dart';
import 'package:sptify/common/widgets/button/basic_app_button.dart';

import '../../../data/models/user/auth/signin_user_req.dart';
import '../../../domain/usecases/auth/signin.dart';
import '../../../service_locator.dart';
import '../home_page/home_page.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signUpText(context),
      appBar: BasicAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signInText(),
              SizedBox(height: 40),
              _fullNameField(context),
              SizedBox(height: 20),
              _passwordField(context),
              SizedBox(height: 20),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SigninUseCase>().call(
                    params: SigninUserReq(
                      email: _email.text.toString(),
                      password: _password.text.toString(),
                    ),
                  );
                  result.fold(
                        (l) {
                      var snackbar = SnackBar(
                        content: Text(l),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                        (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage()),
                            (route) => false,
                      );
                    },
                  );
                },
                title: 'Sign In',
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(hintText: 'Full Name').applyDefaults(
          Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(hintText: 'Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not a Member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}


