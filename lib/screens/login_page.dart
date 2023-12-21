import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumex/functions/function.dart';
import 'package:resumex/providers/auth_provider.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-page';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  bool signIn = false;
  bool isLoading = false;
  bool verifyPhone = false;
  bool otp = false;
  bool forgetPassword = false;
  bool forgetPasswordOtp = false;

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.of(context).size.width;
    final authInstance = Provider.of<Authentication>(context);

    void loading(bool load) {
      setState(() {
        isLoading = load;
      });
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset('assets/images/login_background.png').image,
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: availableWidth * 7.5 / 10,
              child: Form(
                key: _formKey,
                child: signIn
                    ? forgetPassword
                        ? forgetPasswordOtp
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            forgetPasswordOtp = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      const AppHeading(),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    endIndent: 40,
                                    indent: 40,
                                  ),
                                  const HeadingText(
                                    color: Colors.black,
                                    text: 'Create new password',
                                  ),
                                  InputBox(
                                    controller: otpController,
                                    hintText: 'e.g. 123456',
                                    infoText: 'OTP',
                                    validation: (value) {
                                      if (value!.length != 6) {
                                        return 'Please enter a correct OTP';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  InputBox(
                                    controller: passwordController,
                                    hintText: 'Enter your new password',
                                    infoText: 'New Password',
                                    inputType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    validation: (value) {
                                      if (value!.length < 8) {
                                        return 'Password must be 8 characters';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  isLoading
                                      ? const LoadingSpinner()
                                      : ChipButton(
                                          color: Colors.black,
                                          text: 'Next',
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              loading(true);
                                              await authInstance
                                                  .createNewPassword(
                                                otpController.text,
                                                passwordController.text,
                                              )
                                                  .then((value) {
                                                loading(false);
                                                if (value != null) {
                                                  snackbar(context, value);
                                                }
                                              });
                                            }
                                          },
                                        )
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            forgetPassword = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      const AppHeading(),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    endIndent: 40,
                                    indent: 40,
                                  ),
                                  const HeadingText(
                                    color: Colors.black,
                                    text: 'Forgot password',
                                  ),
                                  InputBox(
                                    controller: emailController,
                                    hintText: 'Your email',
                                    infoText: 'Email',
                                    validation: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a valid email';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  InputBox(
                                    controller: phoneController,
                                    hintText: 'Registered phone number',
                                    infoText: 'Phone Number',
                                    inputType: TextInputType.visiblePassword,
                                    obscureText: false,
                                    validation: (value) {
                                      if (value!.length < 10) {
                                        return 'Please enter a valid phone number';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  isLoading
                                      ? const LoadingSpinner()
                                      : ChipButton(
                                          color: Colors.black,
                                          text: 'Next',
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              loading(true);
                                              await authInstance
                                                  .forgetPassword(
                                                emailController.text,
                                                '+91${phoneController.text}',
                                              )
                                                  .then((value) {
                                                loading(false);
                                                if (value != null) {
                                                  snackbar(context, value);
                                                }
                                              });
                                              setState(() {
                                                forgetPasswordOtp = true;
                                              });
                                            }
                                          },
                                        )
                                ],
                              )
                        : Column(
                            children: <Widget>[
                              const AppHeading(),
                              const Divider(
                                color: Colors.black,
                                endIndent: 40,
                                indent: 40,
                              ),
                              InputBox(
                                controller: emailController,
                                hintText: 'someone@domain.com',
                                infoText: 'Email',
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              InputBox(
                                controller: passwordController,
                                hintText: 'Your password',
                                infoText: 'Password',
                                inputType: TextInputType.visiblePassword,
                                obscureText: true,
                                validation: (value) {
                                  if (value!.length < 8) {
                                    return 'Please enter a valid password';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              isLoading
                                  ? const LoadingSpinner()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        ChipButton(
                                          color: Colors.black,
                                          text: 'Sign In',
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              authInstance
                                                  .signIn(
                                                emailController.text,
                                                passwordController.text,
                                              )
                                                  .then((value) {
                                                if (value != null) {
                                                  snackbar(
                                                      context, value, 2000);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                }
                                              });
                                            }
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              signIn = false;
                                            });
                                          },
                                          child: const Text(
                                            'Register instead',
                                            style: TextStyle(
                                              //fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    forgetPassword = true;
                                  });
                                },
                                child: const Text(
                                  'Forgot password',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 29, 44, 52),
                                  ),
                                ),
                              ),
                            ],
                          )
                    : authInstance.currentAuthState == AuthState.verifyPhone
                        ? Column(
                            children: <Widget>[
                              const AppHeading(),
                              const Divider(
                                color: Colors.black,
                                indent: 40,
                                endIndent: 40,
                              ),
                              otp
                                  ? InputBox(
                                      controller: otpController,
                                      hintText: 'e.g. 123456',
                                      infoText: 'OTP',
                                      inputType: TextInputType.number,
                                      validation: (value) {
                                        if (value!.length != 6) {
                                          return 'Please enter a correct OTP';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )
                                  : InputBox(
                                      controller: phoneController,
                                      hintText: 'e.g. 9876543210',
                                      infoText: 'Phone Number',
                                      inputType: TextInputType.phone,
                                      validation: (value) {
                                        if (value!.length != 10) {
                                          return 'Please enter a correct number';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                              isLoading
                                  ? const LoadingSpinner()
                                  : ChipButton(
                                      color: Colors.black,
                                      text: otp ? 'Verify' : 'Next',
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          loading(true);
                                          if (otp) {
                                            dprint('Calling link phone number');
                                            await authInstance
                                                .linkNumber(otpController.text)
                                                .then((value) {
                                              loading(false);
                                              if (value == null) {
                                                snackbar(
                                                    context, 'Account Created');
                                              } else {
                                                snackbar(context, value);
                                              }
                                            });
                                          } else {
                                            dprint('Calling verify phone');
                                            await authInstance
                                                .verifyPhoneNumber(
                                              '+91${phoneController.text}',
                                            )
                                                .then((value) {
                                              loading(false);
                                              if (value != null) {
                                                snackbar(context, value);
                                              }
                                            });
                                            setState(() {
                                              otp = true;
                                            });
                                          }
                                        }
                                      },
                                    )
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              const AppHeading(),
                              const Divider(
                                color: Colors.black,
                                indent: 40,
                                endIndent: 40,
                              ),
                              const HeadingText(
                                color: Colors.black,
                                text: 'Create a new account',
                              ),
                              InputBox(
                                controller: nameController,
                                hintText: 'Your name',
                                infoText: 'Name',
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              InputBox(
                                controller: emailController,
                                hintText: 'Your e-mail address',
                                infoText: 'Email',
                                inputType: TextInputType.emailAddress,
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              InputBox(
                                controller: passwordController,
                                hintText: 'Enter a password',
                                infoText: 'Password',
                                validation: (value) {
                                  if (value!.length < 8) {
                                    return 'Password must be 8 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              isLoading
                                  ? const LoadingSpinner()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        ChipButton(
                                          color: Colors.black,
                                          text: 'Register',
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              loading(true);
                                              authInstance
                                                  .createAccount(
                                                emailController.text,
                                                passwordController.text,
                                                nameController.text,
                                              )
                                                  .then((value) {
                                                loading(false);
                                                if (value != null) {
                                                  snackbar(
                                                      context, value, 2000);
                                                }
                                              });
                                            }
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              signIn = !signIn;
                                            });
                                          },
                                          child: const Text(
                                            'Sign-In instead',
                                            style: TextStyle(
                                              //fontSize: 10,
                                              color: Color.fromARGB(
                                                255,
                                                42,
                                                82,
                                                102,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.black,
      strokeWidth: 8.0,
    );
  }
}
