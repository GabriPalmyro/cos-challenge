import 'package:cos_challenge/app/common/router/router.dart';
import 'package:cos_challenge/app/core/validators/password_validator.dart';
import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/design/tokens/cos_images.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.cubit,
    super.key,
  });

  final LoginCubit cubit;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with NavigationStateDelegate {
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _nameFocusNode;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      widget.cubit.login(
        _emailController.text,
        _nameController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                CosImages.logo,
                height: 120,
              ),
              const SizedBox(height: CosSpacing.xxl),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_nameFocusNode);
                },
                validator: EmailValidator.validate,
              ),
              const SizedBox(height: CosSpacing.md),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: const InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  _login();
                },
              ),
              const SizedBox(height: CosSpacing.xl),
              BlocConsumer<LoginCubit, LoginState>(
                bloc: widget.cubit,
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    replaceWith(context, Routes.home);
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return CosButton(
                    label: 'Login',
                    size: CosButtonSize.large,
                    isLoading: state is LoginLoading,
                    onPressed: () {
                      _login();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
