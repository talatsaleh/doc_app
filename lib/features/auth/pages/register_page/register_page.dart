import 'package:doc_edit_flutter/features/auth/pages/register_page/register_controller.dart';
import 'package:doc_edit_flutter/features/auth/widgets/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary.withBlue(hashCode),
              Theme.of(context).colorScheme.onPrimary,
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/doc-app-logo.svg',
              semanticsLabel: 'doc-app',
              width: 100,
              height: 100,
            ),
            const CustomContainer(
              child: CustomSignUp(),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSignUp extends StatelessWidget {
  const CustomSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomRegisterFormWidget();
  }
}
