import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: TextStyle(fontSize: 24)),
            TextField(controller: emailC, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passC, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final ok = await auth.login(emailC.text, passC.text);

                if (ok) {
                  Navigator.pushReplacementNamed(context, "/home");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Email atau password salah")),
                  );
                }
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/register"),
              child: Text("Belum punya akun? Register"),
            )
          ],
        ),
      ),
    );
  }
}
