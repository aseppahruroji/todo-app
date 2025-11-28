import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
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
            Text("Register", style: TextStyle(fontSize: 24)),
            TextField(controller: emailC, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passC, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final ok = await auth.register(emailC.text, passC.text);

                if (ok) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User sudah terdaftar")),
                  );
                }
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
