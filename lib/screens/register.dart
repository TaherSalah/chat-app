// ignore_for_file: avoid_print

import 'package:chat_app/screens/auth_bloc/auth_bloc.dart';
import 'package:chat_app/shard/widget/snak_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool isActive = true;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: BlocConsumer<AuthBloc,AuthState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              isLoading = true;
            } else if (state is RegisterSuccess) {
              Navigator.pushNamed(context, 'Home', arguments: email);
            } else if (state is RegisterFailure) {
              Center(
                child: Text(state.errorMsg),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child:
                          Image.asset(height: 150, 'assets/images/login.png')),
                  const Text(
                    'Register Now',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      validator: (value) {
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: 'Enter Your Email',
                          label: Text('Email'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: isActive,
                      onChanged: (data) {
                        password = data;
                      },
                      validator: (value) {
                        if (value!.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          // suffixIcon: InkWell(
                          //   onTap: togglePassword,
                          //   child: widget.isActive
                          //       ? const Icon(Icons.visibility_off)
                          //       : const Icon(Icons.visibility),
                          // ),
                          prefixIcon: Icon(Icons.lock_open_outlined),
                          hintText: 'Enter Your Password',
                          label: Text('password'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Are You Have Account ? '),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'Login');
                        },
                        child: const Text(
                          'Login Now',
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.deepPurple),
                          elevation: MaterialStatePropertyAll(10),
                          textStyle: MaterialStatePropertyAll(TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40))),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                              email: email!, password: password!));
                        }
                      },
                      child: const Text('Register'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

// void togglePassword() {
//   widget.isActive = !widget.isActive;
//   setState(() {});
// }
}
