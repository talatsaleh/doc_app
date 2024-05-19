import 'package:doc_edit_flutter/core/navigation/routes.dart';
import 'package:doc_edit_flutter/features/auth/pages/login_page/login_controller.dart';
import 'package:doc_edit_flutter/features/auth/pages/register_page/register_controller.dart';
import 'package:doc_edit_flutter/features/widgets/custom_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../main.dart';

class CustomLoginFormWidget extends ConsumerStatefulWidget {
  const CustomLoginFormWidget({super.key});

  @override
  ConsumerState<CustomLoginFormWidget> createState() =>
      _CustomLoginFormWidgetState();
}

class _CustomLoginFormWidgetState extends ConsumerState<CustomLoginFormWidget> {
  Future<void> onSaved() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(LoginController.notifier).createSession(
            email: email.text,
            password: password.text,
          );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isAuthLoading);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormWidget(
                icon: Icons.email,
                label: 'Email',
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email can\'t be empty';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Not a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                icon: Icons.key,
                label: 'Password',
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonWidget(
                  onPressed: onSaved, child: const Text('Login')),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'don\'t have an account?',
                  children: [
                    TextSpan(
                      text: ' Join Now',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Routemaster.of(context).push(AppRoutes.register),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class CustomRegisterFormWidget extends ConsumerStatefulWidget {
  const CustomRegisterFormWidget({super.key});

  @override
  ConsumerState<CustomRegisterFormWidget> createState() =>
      _CustomRegisterFormWidgetState();
}

class _CustomRegisterFormWidgetState
    extends ConsumerState<CustomRegisterFormWidget> {
  Future<void> onSaved() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(RegisterController.notifier).create(
          email: email.text, password: password.text, name: userName.text);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    userName.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController userName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isAuthLoading);
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormWidget(
                icon: Icons.person,
                label: 'User Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'User Name can\'t be empty';
                  }
                  return null;
                },
                controller: userName,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                icon: Icons.email,
                label: 'Email',
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email can\'t be empty';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Not a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                icon: Icons.key,
                label: 'Password',
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter valid password';
                  } else if (value != confirmPassword.text) {
                    return 'password not match..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                icon: Icons.key_rounded,
                label: 'Confirm password',
                controller: confirmPassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter valid password';
                  } else if (value != password.text) {
                    return 'password not match..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonWidget(
                  onPressed: onSaved, child: const Text('Register')),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Have account?',
                  children: [
                    TextSpan(
                      text: ' Login Now',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Routemaster.of(context).push(AppRoutes.login),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class TextFormWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const TextFormWidget({
    super.key,
    required this.label,
    required this.icon,
    this.validator,
    required this.controller,
    this.obscureText = false,
  });

  final String label;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: Icon(icon),
        label: Text(label),
      ),
      validator: validator,
      controller: controller,
      obscureText: obscureText,
    );
  }
}
