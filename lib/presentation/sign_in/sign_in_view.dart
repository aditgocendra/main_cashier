import 'package:flutter/material.dart';
import 'package:main_cashier/auth_state.dart';
import 'package:main_cashier/core/constant/color_constant.dart';
import 'package:main_cashier/core/constant/values_constant.dart';
import 'package:main_cashier/core/utils/decoration_utils.dart';
import 'package:main_cashier/core/utils/dialog_utils.dart';
import 'package:main_cashier/presentation/sign_in/sign_in_controller.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController tecUsername = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInController>();
    final authState = context.read<AuthState>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: Container(
          width: 600,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: tecUsername,
                      decoration: DecorationUtils.textFieldDecoration(
                        hint: "Example : Administrator",
                        label: "Username",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return fieldRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: tecPassword,
                      obscureText: true,
                      decoration: DecorationUtils.textFieldDecoration(
                        hint: "Example : ********",
                        label: "Password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return fieldRequired;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  controller.signIn(
                    username: tecUsername.text,
                    pass: tecPassword.text,
                    callbackSuccess: () {
                      authState.setUserLoggedIn();
                    },
                    callbackFail: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogUtils.dialogInformation(
                            title: "Sign In Fail",
                            message: "Something wrong",
                            callbackConfirmation: () => navigator.pop(),
                          );
                        },
                      );
                    },
                  );
                },
                style: DecorationUtils.buttonDialogStyle(),
                child: const Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
