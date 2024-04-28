import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tpm_tugas_4/view/auth/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isError = false;

  Future<void> registerUser() async {
    const url = "http://localhost:3002/v1/users/register";
    String msg = "";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': _fullNameController.text,
          'username': _usernameController.text,
          'password': _passwordController.text
        }),
      );
      msg = jsonDecode(response.body)["message"];

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), duration: Durations.long2));

      if (response.statusCode != 201) {
        setState(() {
          isError = true;
        });
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Can't connect to server."),
          duration: Durations.long2));

      setState(() {
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(scrollDirection: Axis.vertical, children: [
            const SizedBox(height: 20),
            _heading(),
            _nameField(),
            _usernameField(),
            _passwordField(),
            _registerButton(context),
            const Divider(),
            _loginButton(context),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _heading() {
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1, bottom: 4),
        alignment: Alignment.centerLeft,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Register Page",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please enter your credentials.",
              // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget _nameField() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        enabled: true,
        controller: _fullNameController,
        onChanged: (value) {
          setState(() {
            if (isError == true) isError = false;
          });
        },
        decoration: InputDecoration(
            hintText: 'Enter your full name',
            prefixIcon: Icon(
              Icons.assignment_ind_rounded,
              color: (!isError)
                  ? Colors.black87
                  : Theme.of(context).colorScheme.error,
            ),
            filled: true,
            fillColor: (isError)
                ? Theme.of(context).colorScheme.errorContainer
                : const Color.fromARGB(255, 229, 229, 229),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (!isError)
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.error)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (!isError)
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.error))),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        enabled: true,
        controller: _usernameController,
        onChanged: (value) {
          setState(() {
            if (isError == true) isError = false;
          });
        },
        decoration: InputDecoration(
            hintText: 'Enter your username',
            prefixIcon: Icon(
              Icons.person,
              color: (!isError)
                  ? Colors.black87
                  : Theme.of(context).colorScheme.error,
            ),
            filled: true,
            fillColor: (isError)
                ? Theme.of(context).colorScheme.errorContainer
                : const Color.fromARGB(255, 229, 229, 229),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (!isError)
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.error)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (!isError)
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.error))),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        enabled: true,
        controller: _passwordController,
        onChanged: (value) {
          setState(() {
            if (isError == true) isError = false;
          });
        },
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          prefixIcon: Icon(
            Icons.key,
            color: (!isError)
                ? Colors.black87
                : Theme.of(context).colorScheme.error,
          ),
          filled: true,
          fillColor: (isError)
              ? Theme.of(context).colorScheme.errorContainer
              : const Color.fromARGB(255, 229, 229, 229),
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (!isError)
                      ? Colors.transparent
                      : Theme.of(context).colorScheme.error)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (!isError)
                      ? Colors.transparent
                      : Theme.of(context).colorScheme.error)),
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor:
                Theme.of(context).colorScheme.onPrimary, // foreground
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        onPressed: registerUser,
        child: const Text('Register'),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Already have an account?",
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                            color: Color.fromARGB(84, 0, 0, 0), width: 1.5))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Login'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
