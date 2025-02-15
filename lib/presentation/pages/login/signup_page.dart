import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sptify/common/widgets/appbar/app_bar.dart';
import 'package:sptify/common/widgets/button/basic_app_button.dart';
import 'package:sptify/data/models/user/auth/create_user.dart';
import 'package:sptify/domain/usecases/auth/auth.dart';

import '../../../service_locator.dart';
import '../home_page/home_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context) ,
      appBar: BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50 ,
          horizontal: 30 ,
        ),
        child: Column(


          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            _regsterText() ,
            SizedBox(height: 40,) ,
            _fullNameField(context) ,
            SizedBox(height: 20,) ,
            _emailField(context) ,
            SizedBox(height: 20,) ,
            _passwordField(context),
            SizedBox(height: 20,) ,
            BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignupUseCase>().call(
                      params: CreateUserReq(
                         fullName: _fullName.text.toString() ,
                          email: _email.text.toString(),
                          password: _password.text.toString(),
                      )
                  );
                  result.fold(
                          (l){
                        var snackbar = SnackBar(content: Text(l),behavior: SnackBarBehavior.floating,);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                          (r){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                (route) => false
                        );
                      }
                  );
                },
                title: 'Create Account'
            ),
            SizedBox(height: 10,) ,


          ],
        ),
      ),
    );
  }



  Widget _regsterText(){

    return const Text('Register' ,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25
    ),

    textAlign: TextAlign.center,) ;
  }

Widget _fullNameField(BuildContext context) {
  return TextField(
    controller: _fullName ,
    decoration:InputDecoration(
      hintText: 'Full Name'
    ).applyDefaults(
    Theme.of(context).inputDecorationTheme   ) ,

  );
}
    Widget _emailField(BuildContext context){
      return  TextField(
        controller: _email,

        decoration: InputDecoration(
          hintText: 'Email'
        ).applyDefaults(Theme.of(context).inputDecorationTheme),


      ) ;


}

  Widget _passwordField(BuildContext context){
    return  TextField(
      controller: _password ,

      decoration: InputDecoration(
          hintText: 'Password'
      ).applyDefaults(Theme.of(context).inputDecorationTheme),


    ) ;

  }

  Widget _signInText(BuildContext context ){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row (
   mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Do you have an Account?', style: TextStyle(
            fontWeight:  FontWeight.w500,
            fontSize: 14,

          ),

          ) ,
          
          TextButton(onPressed: (){


          }, child: Text(
            'Sign In'
          ))
        ],

      ),
    ) ;
  }

}
