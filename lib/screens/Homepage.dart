import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/helper/firebase_auth_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome To Home Page",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuthHelper.firebaseAuthHelper.signOut();
                Navigator.of(context).pushReplacementNamed("sign_in");
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Color(0xffFF3E56),

                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
