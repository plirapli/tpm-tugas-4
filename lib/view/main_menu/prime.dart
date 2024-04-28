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
  String number = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Prime Number Check",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
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
        ));
  }

  Widget _inputField() {
    return TextField(
      controller: num,
      onChanged: (value) {
        if (value.isNotEmpty && value.length > 1) {
          // Jika 1st char = 0, maka replace 1st char dengan char yang kita ketik
          if (value.characters.characterAt(0) == Characters("0")) {
            // we need to remove the first char
            num.text = value.substring(1);

            // we need to move the cursor
            num.selection = TextSelection.collapsed(offset: num.text.length);
            // Jika 1st char = 0 dan 2nd char = 0, maka gabole ngetik
          } else if (value.characters.characterAt(0) == Characters("-") &&
              value.characters.characterAt(1) == Characters("0")) {
            num.text = value.substring(2, 2);
          }
        }
      },
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 32),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,12}')),
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        onPressed: () {
          // Not empty & positive
          if (num.text.isNotEmpty && num.text != "-") {
            int? inputNumber = int.parse(num.text);

            setState(() {
              result = isPrime(inputNumber) ? "PRIME" : "NOT PRIME";
            });
          } else {
            setState(() {
              result = "😵";
            });
          }
        },
        child: const Text(
          'Check',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _result() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Result",
            style: TextStyle(fontSize: 18, height: 0.75),
          ),
          Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
