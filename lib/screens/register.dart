// ignore_for_file: avoid_print

import 'package:chat_app/shard/widget/snak_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  bool isActive = true;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(height: 150, 'assets/images/login.png')),
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
                  obscureText: widget.isActive,
                  onChanged: (data) {
                    password = data;
                  },
                  validator: (value) {
                    if (value!.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: togglePassword,
                        child: widget.isActive
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      hintText: 'Enter Your Password',
                      label: const Text('password'),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: const OutlineInputBorder(
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
                      textStyle: MaterialStatePropertyAll(
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40))),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        await authEmailAndPass();
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(context, 'Home',(route) => false,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context,
                              title: 'The password provided is too weak.',
                              bgColor: Colors.amber);
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context,
                              title:
                                  'The account already exists for that email.',
                              bgColor: Colors.redAccent);
                        }
                        print(e.toString());
                      } catch (e) {
                        print(e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  child: const Text('Register'))
            ],
          ),
        ),
      ),
    );
  }

  void togglePassword() {
    widget.isActive = !widget.isActive;
    setState(() {});
  }

  authEmailAndPass() async {
     await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    // ignore: use_build_context_synchronously
    showSnakBar(context, title: 'Email create Success', bgColor: Colors.green);
  }
}


