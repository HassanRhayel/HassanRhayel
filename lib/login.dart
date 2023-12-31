import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'play.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailErrorText;
  bool showError = false;
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red,
              Colors.red,
              Colors.white,
              Colors.white,
              Colors.red,
              Colors.red,
            ],
            stops: [0.0, 0.3, 0.3, 0.7, 0.7, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildLogInForm(context),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogInForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
              fillColor: Colors.white,
              errorText: emailErrorText,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Colors.white,
              errorText: showError && passwordController.text.isNotEmpty
                  ? (!_validatePassword(passwordController.text)
                  ? 'Password must be at least 8 characters, including 1 uppercase letter and 1 number'
                  : null)
                  : null,
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showError = true;
                emailErrorText = _validateEmail(emailController.text) ? null : 'Email Format Is Invalid!';
              });

              if (_validateEmail(emailController.text) && passwordController.text.isNotEmpty) {
                _logIn();
              } else {
                print('Invalid email or password');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            ),
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }

  bool _validateEmail(String value) {
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool _validatePassword(String value) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(value);
  }

  Future<void> _logIn() async {
    email = emailController.text.trim();

    if (!_validateEmail(email) || passwordController.text.isEmpty) {
      return;
    }

    const String apiUrl = 'https://guesstheflaggame.000webhostapp.com/login.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': email, 'password': passwordController.text.trim()}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          print('Login successful');
        } else {
          setState(() {
            if (data['message'] == 'User not found') {
              emailErrorText = 'User not found';
            } else {
              emailErrorText = null;
            }
          });
          print(data['message']);
        }
      } else {
        print('Failed to connect to the server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}


