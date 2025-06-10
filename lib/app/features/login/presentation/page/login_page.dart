import 'package:cos_challenge/app/core/validators/email_validator.dart';
import 'package:cos_challenge/app/core/validators/password_validator.dart';
import 'package:cos_challenge/app/design/design.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                validator: EmailValidator.validate,
              ),
              const SizedBox(height: CosSpacing.md),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: PasswordValidator.validate,
                onFieldSubmitted: (_) {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle login logic here
                  }
                },
              ),
              const SizedBox(height: CosSpacing.xl),
              CosButton(
                label: 'Login',
                size: CosButtonSize.large,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle login logic here
                  }
                },
              ),
              const SizedBox(height: CosSpacing.md),
              CosButton(
                label: 'Create Account',
                type: CosButtonType.secondary,
                size: CosButtonSize.large,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
