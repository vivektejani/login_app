import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/helper/firebase_auth_helper.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper3(),
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                    ClipPath(
                      clipper: MyClipper2(),
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    ClipPath(
                      clipper: MyClipper1(),
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 75,
                            ),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val == null) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (val) {
                    if (val == null) {
                      return "Enter valid Password";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                    labelText: 'Password',
                    hintText: 'Enter Your password',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      User? user = await FirebaseAuthHelper.firebaseAuthHelper
                          .signIn(email: email, password: password);

                      log(user.toString(), name: "User");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "SignIn Success",
                          ),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, "/");
                    } on FirebaseException catch (e) {
                      log("$e", name: "Error");
                      switch (e.code) {
                        case "invalid-email":
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blue,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  "Invalid Email",
                                ),
                              ),
                            );
                          }
                          break;
                        case "wrong-password":
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.blue,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  "Incorrect Password",
                                ),
                              ),
                            );
                          }
                          break;
                      }
                    }
                  }
                },
                borderRadius: BorderRadius.circular(40),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "FORGET PASSWORD ?",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuthHelper.firebaseAuthHelper
                      .signInWithGoogle();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "Login Success with Google",
                      ),
                    ),
                  );

                  Navigator.pushReplacementNamed(context, "/");
                },
                child: Image.asset(
                  "assets/images/google.png",
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "sign_up");
                },
                child: const Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Don't Have an Account ? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                        text: "Sign Up.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ))
                  ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.58,
        size.width * 0.6, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.80, size.height * 0.85, size.width, size.height * 0.72);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.58,
        size.width * 0.6, size.height * 0.80);
    path.quadraticBezierTo(
        size.width * 0.80, size.height * 0.90, size.width, size.height * 0.82);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.72);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.70, size.height * 0.88);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
