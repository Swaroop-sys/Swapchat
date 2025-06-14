import 'package:chatapp/core/common/custome_text_field.dart';
import 'package:chatapp/core/common/cutome_button.dart';
import 'package:chatapp/data/repository/auth_repository.dart';
import 'package:chatapp/data/services/service_locator.dart';
import 'package:chatapp/logic/cubit/auth/auth_cubit.dart';
import 'package:chatapp/presentation/screens/auth/loginscreen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _ispasswordvisible = false;
  final _namefocus = FocusNode();
  final _usernamefocus = FocusNode();
  final _emailfocus = FocusNode();
  final _passwordfocus = FocusNode();
  final _phonefocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    _emailfocus.dispose();
    _namefocus.dispose();
    _usernamefocus.dispose();
    _passwordfocus.dispose();
    _phonefocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Name";
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Userame";
    }
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Password";
    } else if (value.length < 8) {
      return "Password Must Be 8 Characters Long";
    }
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }

    // Ensure it is exactly 10 digits and all numeric
    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!phoneRegex.hasMatch(value)) {
      return "Phone number is invalid";
    }

    return null; // Valid phone number
  }

  Future<void> handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState?.validate() ?? false) {
      try {
        getIt<AuthCubit>().signUp(
          fullname: nameController.text,
          username: usernameController.text,
          email: emailController.text,
          phonenumber: phoneController.text,
          password: passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Please Fill The Details To Continue",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                CustomeTextField(
                  controller: nameController,
                  focusNode: _namefocus,
                  validator: _validateName,
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  controller: usernameController,
                  hintText: "Username",
                  focusNode: _usernamefocus,
                  validator: _validateName,
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  controller: emailController,
                  focusNode: _emailfocus,
                  validator: _validateEmail,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  controller: phoneController,
                  focusNode: _phonefocus,
                  validator: _validatePhone,
                  hintText: "Phone",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),

                SizedBox(height: 16),
                CustomeTextField(
                  controller: passwordController,
                  focusNode: _passwordfocus,
                  validator: _validatePassword,
                  obsecureText: !_ispasswordvisible,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
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
                SizedBox(height: 16),
                CustomButton(onPressed: handleSignUp, text: "Create Account"),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account?",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 7),

                    InkWell(
                      child: Text(
                        "Login ",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
