import 'package:chatapp/core/common/custome_text_field.dart';
import 'package:chatapp/data/services/service_locator.dart';
import 'package:chatapp/logic/cubit/auth/auth_state.dart';
import 'package:chatapp/presentation/home/home_screen.dart';
import 'package:chatapp/presentation/screens/auth/signup_screen.dart';
import 'package:chatapp/router/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/cutome_button.dart';
import '../../../logic/cubit/auth/auth_cubit.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _emailfocus = FocusNode();
  final _passwordfocus = FocusNode();
  bool _ispasswordvisible = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailfocus.dispose();
    _passwordfocus.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }

    // Email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address";
    }

    return null; // Valid email
  }

  Future<void> handleLogin() async {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState?.validate() ?? false) {
      try {
        getIt<AuthCubit>().signIn(
          email: emailController.text,

          password: passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Password";
    } else if (value.length < 8) {
      return "Password Must Be 8 Characters Long";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listenWhen: (previous, current) {
        return previous.status != current.status ||
            previous.error != current.error;
      },
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          getIt<AppRouter>().pushAndRemoveUntil(HomeScreen());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sign In To Continue",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomeTextField(
                    controller: emailController,
                    focusNode: _emailfocus,
                    validator: _validateEmail,
                    hintText: "Email",
                    prefixIcon: Icon(Icons.mail),
                  ),
                  SizedBox(height: 18),
                  CustomeTextField(
                    controller: passwordController,
                    hintText: "Password",
                    focusNode: _passwordfocus,

                    validator: _validatePassword,
                    obsecureText: !_ispasswordvisible,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _ispasswordvisible = !_ispasswordvisible;
                        });
                      },
                      icon: Icon(
                        _ispasswordvisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(onPressed: handleLogin, text: 'login'),
                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have Account?",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 7),

                      InkWell(
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        onTap: () {
                          getIt<AppRouter>().push(SignupScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
