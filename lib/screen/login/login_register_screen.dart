import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/form_validator.dart';
import 'package:weather_app/screen/login/bloc/login_bloc.dart';
import 'package:weather_app/widget/text_decoration.dart';
import 'package:weather_app/widget/my_button.dart';
import 'package:weather_app/widget/button_logo.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.lock,
                size: 100,
                color: Color.fromARGB(255, 52, 5, 223),
              ),
              const Text(
                'Weather App',
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 5, 223),
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  validator: ValidForm.emptyValue,
                  decoration: DecorationText.box(hintText: "Email"),
                  onChanged: (val) {
                    context.read<LoginBloc>().add(OnChangedEmailOrPhone(val));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  obscureText: true,
                  validator: ValidForm.emptyValue,
                  decoration: DecorationText.box(hintText: "Password"),
                  onChanged: (val) {
                    context.read<LoginBloc>().add(OnChangedPassword(val));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: () {
                  context.read<LoginBloc>().add(const OnLogin());
                },
                title: 'Sign In',
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonLogo(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 25),
                  ButtonLogo(imagePath: 'lib/images/phone.png')
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
