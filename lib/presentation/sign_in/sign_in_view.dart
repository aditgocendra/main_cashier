import 'package:flutter/material.dart';
import 'package:main_cashier/color_app.dart';
import 'package:provider/provider.dart';
import '../../auth_state.dart';
import '../../core/constant/values_constant.dart';
import '../../core/utils/decoration_utils.dart';
import '../../core/utils/dialog_utils.dart';
import 'sign_in_controller.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final TextEditingController tecUsername = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInController>();
    final authState = context.read<AuthState>();
    final colorApp = context.watch<ColorApp>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: Container(
          width: 600,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: colorApp.canvas,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorApp.border,
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
                      obscureText: controller.isObscurePass,
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        hintText: "*******",
                        label: const Text("Password"),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isObscurePass
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            color: controller.isObscurePass
                                ? colorApp.primaryLight
                                : colorApp.primary,
                          ),
                          onPressed: () {
                            controller.toogleObscurePass();
                          },
                        ),
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
                            primary: colorApp.primary,
                            callbackConfirmation: () => navigator.pop(),
                          );
                        },
                      );
                    },
                  );
                },
                style: DecorationUtils.buttonDialogStyle(colorApp.primary),
                child: const Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
