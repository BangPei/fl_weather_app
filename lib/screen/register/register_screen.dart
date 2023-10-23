import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/common/form_validator.dart';
import 'package:weather_app/screen/register/bloc/register_bloc.dart';
import 'package:weather_app/widget/my_button.dart';
import 'package:weather_app/widget/text_decoration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController passCont = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Register Form',
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 5, 223),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                validator: ValidForm.emptyValue,
                decoration: DecorationText.box(
                  hintText: "Email",
                ),
                onChanged: (val) {
                  context.read<RegisterBloc>().add(OnChangedEmail(val));
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: ValidForm.emptyValue,
                keyboardType: TextInputType.phone,
                decoration: DecorationText.box(
                  hintText: "Phone",
                ),
                onChanged: (val) {
                  context.read<RegisterBloc>().add(OnChangedPhone(val));
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: ValidForm.emptyValue,
                decoration: DecorationText.box(hintText: "Full Name"),
                onChanged: (val) {
                  context.read<RegisterBloc>().add(OnChangedFullName(val));
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passCont,
                obscureText: true,
                validator: ValidForm.emptyValue,
                decoration: DecorationText.box(hintText: "Password"),
                onChanged: (val) {
                  context.read<RegisterBloc>().add(OnChangedPassword(val));
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return TextFormField(
                    obscureText: true,
                    validator: (value) {
                      return ValidForm.matchValue(
                          value, passCont.text, "Password");
                    },
                    decoration:
                        DecorationText.box(hintText: "Confirm Password"),
                    onChanged: (val) {},
                  );
                },
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<RegisterBloc>()
                        .add(const OnRegisterFireStore());
                  }
                },
                title: 'Sign Up',
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account ?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      'Sign In',
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
