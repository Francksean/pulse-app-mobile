import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_app_mobile/common/components/custom_button.dart';
import 'package:pulse_app_mobile/common/components/custom_input_field.dart';
import 'package:pulse_app_mobile/common/constants/app_colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const CustomInputField(
            hintText: "Enter Email",
            hintStyle: TextStyle(
                color: AppColors.black, fontWeight: FontWeight.normal),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomInputField(
            obscureText: true,
            hintText: "Enter Password",
            hintStyle: TextStyle(
                color: AppColors.black, fontWeight: FontWeight.normal),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            onPressed: () {
              context.push("/app");
            },
            width: double.infinity,
            text: "Login",
            gradient:
                const LinearGradient(colors: [AppColors.red, AppColors.orange]),
          )
        ],
      ),
    );
  }
}
