import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpm_tugas_4/utils/is_prime.dart';
import 'package:tpm_tugas_4/view/components/heading.dart';

class PrimePage extends StatefulWidget {
  const PrimePage({super.key});

  @override
  State<PrimePage> createState() => _PrimePageState();
}

class _PrimePageState extends State<PrimePage> {
  TextEditingController num = TextEditingController();
  String result = "-";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Prime Number")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: ListView(scrollDirection: Axis.vertical, children: [
            const SizedBox(height: 20),
            const Heading(
                text: "Prime Number",
                subtext:
                    "Identify whether a number is prime or not between 0-1 trillion."),
            _main(),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _main() {
    return Container(
      margin: const EdgeInsets.only(top: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_inputField(), _calcButton(context), _result()],
      ),
    );
  }

  Widget _inputField() {
    return TextField(
      controller: num,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 32),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^[1-9]{0,12}')),
      ],
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _calcButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () {
          String input = num.text;
          setState(() => result = (input.isEmpty)
              ? "😵"
              : isPrime(int.parse(input))
                  ? "PRIME"
                  : "NOT PRIME");
        },
        child: const Text('Check'),
      ),
    );
  }

  Widget _result() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Result"),
          Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
