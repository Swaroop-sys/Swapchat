import 'package:chatapp/core/common/custome_text_field.dart';
import 'package:chatapp/core/common/cutome_button.dart';
import 'package:chatapp/presentation/screens/auth/loginscreen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
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
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  controller: usernameController,
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  controller: phoneController,
                  hintText: "Phone",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),

                SizedBox(height: 16),
                CustomeTextField(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password_outlined),
                  suffixIcon: Icon(Icons.visibility),
                ),
                SizedBox(height: 16),
                CustomButton(onPressed: () {}, text: "Create Account"),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginscreen(),
                          ),
                        );
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
