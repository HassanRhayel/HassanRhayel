import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showError = false;
  String? emailErrorText;

  bool _validateEmail(String value) {

    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool _validatePassword(String value) {
    // Password: 8 characters, including 1 uppercase letter and 1 number
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(value);
  }

  Future<void> _signUp() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (!_validateEmail(email) || !_validatePassword(password)) {

      return;
    }

     const String apiUrl = 'https://guesstheflaggame.000webhostapp.com/signup.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {

          print('Signup successful, navigating back to login page.');
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {

          setState(() {
            if (data['message'] == 'User Exists') {
              emailErrorText = 'User Exists';
            } else {
              emailErrorText = data['message'];
            }
          });
        }
      } else {

        print('Failed to connect to the server. Status code: ${response.statusCode}');
      }
    } catch (error) {

      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                'Create an Account',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildSignUpForm(context),
              const SizedBox(height: 40.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInPage()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                errorText: emailErrorText,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                errorText: showError && passwordController.text.isNotEmpty
                    ? (!_validatePassword(passwordController.text)
                    ? 'Password must be at least 8 characters, including 1 uppercase letter and 1 number'
                    : null)
                    : null,
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showError = true;
                emailErrorText = _validateEmail(emailController.text) ? null : 'Email Format Is Invalid!';
              });

              if (_validateEmail(emailController.text) &&
                  passwordController.text.isNotEmpty &&
                  _validatePassword(passwordController.text)) {
                _signUp();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}





