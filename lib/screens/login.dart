import 'package:chat_app/shard/widget/snak_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isActive = true;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset(height: 150, 'assets/images/login.png')),
            const Text(
              'Login Now',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onChanged: (data) {
                  email = data;
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
                validator: (value) {
                  if (value!.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  return null;
                },
                onChanged: (data) {
                  password = data;
                },
                obscureText: isActive,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: togglePassword,
                      child: isActive
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
                    Navigator.pushNamed(context, 'Register');
                  },
                  child: const Text(
                    'Register Now',
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
                    loginUser();
                    showSnakBar(context,
                        title: 'sign in success', bgColor: Colors.green);
                        Navigator.popAndPushNamed(context, 'Home');
                    try {} on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnakBar(context,
                            title: 'no user found for that email',
                            bgColor: Colors.redAccent);
                      } else if (e.code == 'wrong-password') {
                        showSnakBar(context,
                            title: 'wrong password provided for that user',
                            bgColor: Colors.redAccent);
                      }
                    }
                  }
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }

  void togglePassword() {
    isActive = !isActive;
    setState(() {});
  }

  loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
