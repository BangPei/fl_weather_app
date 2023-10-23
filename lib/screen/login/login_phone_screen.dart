import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/form_validator.dart';
import 'package:weather_app/screen/login/bloc/login_bloc.dart';
import 'package:weather_app/screen/login/login_template.dart';
import 'package:weather_app/widget/button_logo.dart';
import 'package:weather_app/widget/text_decoration.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});
  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LoginTemplate(
      title: "Enter Your Phone Number to Sign In",
      buttonLogo: ButtonLogo(
        imagePath: 'lib/images/email.jpg',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      children: [
        TextFormField(
          controller: phone,
          validator: ValidForm.emptyValue,
          keyboardType: TextInputType.phone,
          decoration: DecorationText.box(hintText: "Phone"),
        ),
        const SizedBox(height: 10),
      ],
      onSignin: () {
        context.read<LoginBloc>().add(OnLoginPhoneNumber(phone.text));
      },
    );
  }
}
