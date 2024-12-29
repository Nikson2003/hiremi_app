import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_layout.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveUserDetails() async {
    if (_formKey.currentState!.validate()) {
      bool status = false;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('status', status);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainLayout()),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    // Regular expression for basic email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username cannot be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUserDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
