import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesurvey/authentication/data/repositories/users_repo.dart';
import 'package:thesurvey/authentication/presentation/pages/signup.dart';
import 'package:thesurvey/constants/colors.dart';
import 'package:thesurvey/pages/home_page.dart';
import 'package:thesurvey/utils/methods.dart';
import '../../../constants/values.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/snackbar.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool keepSigned = true;

  bool _obscureText = true;
  bool _passwordVisible = true;

  String? _validateInput(String? input, int index) {
    if (input != null) {
      input = input.trim();
    }

    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      default:
        return null;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                    child: Image.asset(
                  logoPath,
                  height: 60,
                )),
                const SizedBox(
                  height: 30,
                ),
                Text('Login',
                    style: MainFonts.pageTitleText(color: thirdColor)),
                const SizedBox(
                  height: 20,
                ),
                Text('Welcome back to the app',
                    style: MainFonts.hintFieldText(),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: ((value) {
                            return _validateInput(value, 0);
                          }),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: ((value) {
                            return _validateInput(value, 1);
                          }),
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: _obscureText,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: Text('Forgot Password?',
                                  style: AuthFonts.authMsgText(
                                      color: fourthColor)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: thirdColor,
                                value: keepSigned,
                                onChanged: (value) {
                                  setState(() {
                                    value = keepSigned;
                                  });
                                }),
                            Text('Keep me signed in',
                                style: MainFonts.hintFieldText()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () async {
                                bool isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  int result = await login(emailController.text,
                                      passwordController.text);
                                  if (result == 1) {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  } else if (result == 0) {
                                  } else {
                                    mySnackBarShow(
                                        context, 'Invalid Cridentials');
                                  }
                                }
                              },
                              child: Text('Login',
                                  style: AuthFonts.authButtonText(
                                      color: primaryColor))),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: Text(
                        'Create an account',
                        textAlign: TextAlign.center,
                        style: MainFonts.lableText(color: secondaryColor),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
