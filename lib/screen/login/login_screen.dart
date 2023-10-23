import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/form_validator.dart';
import 'package:weather_app/screen/login/bloc/login_bloc.dart';
import 'package:weather_app/screen/login/login_phone_screen.dart';
import 'package:weather_app/screen/login/login_template.dart';
import 'package:weather_app/widget/text_decoration.dart';
import 'package:weather_app/widget/my_button.dart';
import 'package:weather_app/widget/button_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return LoginTemplate(
      onSignin: () {
        context.read<LoginBloc>().add(const OnLogin());
      },
      title: "Enter Your Email Address to Sign In",
      buttonLogo: ButtonLogo(
        imagePath: 'lib/images/phone.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPhoneScreen(),
            ),
          );
        },
      ),
      children: [
        TextFormField(
          validator: ValidForm.emptyValue,
          decoration: DecorationText.box(hintText: "Email"),
          onChanged: (val) {
            context.read<LoginBloc>().add(OnChangedEmailOrPhone(val));
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: true,
          validator: ValidForm.emptyValue,
          decoration: DecorationText.box(hintText: "Password"),
          onChanged: (val) {
            context.read<LoginBloc>().add(OnChangedPassword(val));
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: dialogResetEmail,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  dialogResetEmail() async {
    TextEditingController emailController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: [
            MyButton(
              onTap: () {
                context
                    .read<LoginBloc>()
                    .add(OnForgotPassword(emailController.text));
              },
              title: "Send",
            ),
          ],
          content: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Enter Your email",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextFormField(
                    validator: ValidForm.emptyValue,
                    decoration: DecorationText.box(hintText: "Email"),
                    controller: emailController,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
