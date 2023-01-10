import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../components/animated_button.dart';
import '../../components/animated_shape.dart';
import '../../components/custom_text_input.dart';
import '../../notifier/login_notifier.dart';
import '../../utils/validator.dart';
import '../users/user_list_screen.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with Validator {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late String? emailError;
  late String? passWordError;

  final loginKey = GlobalKey<FormState>();

  BehaviorSubject<String?> emailStream = BehaviorSubject();
  BehaviorSubject<String?> passwordStream = BehaviorSubject();
  BehaviorSubject<bool> showShapeStream = BehaviorSubject();

  bool showShape = true;

  @override
  Widget build(BuildContext context) {
    debugPrint('build ');

    ref.listen(
      loginNotifierProvider,
      (previous, next) {
        // debugPrint('build listen previous: ${previous!.response.token}');
        debugPrint('build listen next: ${next.response.token}');

        if (next.response.token != null && next.response.token!.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const UserListScreen(),
            ),
          );
        }

        if (next.status == LoginStatus.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Something went wrong. Try Again.'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 350, 16, 0),
            child: Form(
              key: loginKey,
              child: Column(
                children: [
                  StreamBuilder<String?>(
                    stream: emailStream,
                    builder: (context, snapshot) {
                      debugPrint(
                          'Email text: ${emailController.text.toString()}');
                      debugPrint('Email Error: ${snapshot.data.toString()}');

                      return CustomTextInput(
                        hintText: 'Email',
                        onChange: (_) {
                          emailError = emailValidator(emailController.text);
                          emailStream.add(emailError);
                        },
                        validator: emailValidator,
                        errorText: snapshot.data,
                        controller: emailController,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<String?>(
                    stream: passwordStream,
                    builder: (context, snapshot) {
                      debugPrint(
                          'Password text: ${emailController.text.toString()}');
                      debugPrint('Password Error: ${snapshot.data.toString()}');

                      return CustomTextInput(
                        hintText: 'Password',
                        onChange: (_) {
                          passWordError =
                              passwordValidator(passwordController.text);
                          passwordStream.add(passWordError);
                        },
                        validator: passwordValidator,
                        obscureText: true,
                        errorText: snapshot.data,
                        controller: passwordController,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  /*Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final response = ref.watch(authNotifierProvider);

                      return response.when(
                        data: (data) {
                          if (data.token != null) {
                            debugPrint('Token: ${data.token}');
                            if (data.token!.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const UserListScreen()));
                                },
                              );
                            }
                          } else {
                            debugPrint('Login response null');
                          }
                          return signInButton(context, ref);
                        },
                        error: (err, stack) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(err.toString()),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            ),
                          );
                          return signInButton(context, ref);
                        },
                        loading: () => const CircularProgressIndicator(),
                      );
                    },
                  ),*/
                  Consumer(
                    builder: (_, WidgetRef ref, __) {
                      LoginData loginData = ref.watch(loginNotifierProvider);
                      debugPrint(
                          'Consumer response.status: ${loginData.status}');

                      if (loginData.status == LoginStatus.initialize) {
                        return signInButton(context, ref);
                      } else if (loginData.status == LoginStatus.loading) {
                        return const CircularProgressIndicator();
                      } else if (loginData.status == LoginStatus.success) {
                        /*if (response.response.token!.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const UserListScreen(),
                            ),
                          );
                        }*/
                        return const CircularProgressIndicator();
                      } else if (loginData.status == LoginStatus.failed) {
                        return signInButton(context, ref);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: showShapeStream,
            builder: (context, snapshot) {
              showShape = snapshot.data ?? showShape;
              return AnimatedShape(
                color: Colors.blue,
                show: showShape,
                title: "Sign In",
              );
            },
          )
        ],
      ),
    );
  }

  Widget signInButton(BuildContext context, WidgetRef ref) {
    return AnimatedButton(
      onTap: () {
        if (emailValidator(emailController.text) == null &&
            passwordValidator(passwordController.text) == null) {
          ref
              .read(loginNotifierProvider.notifier)
              // .login(emailController.text, passwordController.text);
              .login('eve.holt@reqres.in', 'cityslicka');
        } else {
          debugPrint('Fields have error');

          String message = '';

          if (emailController.text.isEmpty && passwordController.text.isEmpty) {
            message = 'Enter Email & Password';
            emailStream.add(emailValidator(emailController.text));
            passwordStream.add(passwordValidator(passwordController.text));
          } else if (emailValidator(emailController.text) != null &&
              passwordValidator(passwordController.text) != null) {
            message = 'Invalid Email & Password';
          } else if (emailValidator(emailController.text) != null) {
            message = 'Invalid email';
          } else if (passwordValidator(passwordController.text) != null) {
            message = 'Invalid Password';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
      color: Colors.blue,
      text: 'Sign In',
    );
  }

  @override
  void dispose() {
    emailStream.close();
    passwordStream.close();
    showShapeStream.close();
    super.dispose();
  }
}
