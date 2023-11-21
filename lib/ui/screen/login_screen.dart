import 'package:flutter/material.dart';
import 'package:module12/data.network_caller/models/user_model.dart';
import 'package:module12/data.network_caller/network_caller.dart';
import 'package:module12/data.network_caller/network_response.dart';
import 'package:module12/ui/controllers/auth_controller.dart';
import 'package:module12/ui/screen/main_bottom_nav_screen.dart';
import 'package:module12/ui/screen/sing_up_screen.dart';
import 'package:module12/ui/widget/body_background.dart';
import 'package:module12/ui/widget/snack_bar.dart';
import '../../data.network_caller/Utility/urls.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _loginInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: _logIn,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()));
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SingUpScreen()));
                          },
                          child: const Text(
                            'Sing Up',
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _logIn() async {
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }

    if (_formKey.currentState!.validate()) {
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.login, body: {
        "email": _emailTEController.text.trim(),
        "password": _passwordTEController.text.trim(),
      });
      _loginInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        await AuthController.saveUserInformation(response.jsonResponse['token'],
            UserModel.fromJson(response.jsonResponse['data']));

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
          );
        }
      } else {
        if (response.statusCode == 400) {
          if (mounted) {
            showSnackMessage(context, 'please check your email or password');
          } else {
            if (mounted) {
              showSnackMessage(context, 'login failed!try again');
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
