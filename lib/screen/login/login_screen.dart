import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/common/form_validator.dart';
import 'package:weather_app/screen/login/bloc/login_bloc.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
              color: Color.fromARGB(255, 52, 5, 223),
            ),
            const Center(
              child: Text(
                'Weather App',
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 5, 223),
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Enter Your Email to Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            actions: [MyButton(onTap: () {}, title: "Send")],
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
                                      decoration:
                                          DecorationText.box(hintText: "Email"),
                                      onChanged: (val) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            MyButton(
              onTap: () {
                context.read<LoginBloc>().add(const OnLoginPhoneNumber());
              },
              title: 'Sign In',
            ),
            const SizedBox(height: 50),
            Row(
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
                  onTap: () {
                    context.pushNamed("register");
                  },
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
    );
  }
}
