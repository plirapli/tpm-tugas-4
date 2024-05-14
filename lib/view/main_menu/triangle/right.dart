import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RightTrianglePage extends StatefulWidget {
  const RightTrianglePage({super.key});

  @override
  State<RightTrianglePage> createState() => _RightTrianglePageState();
}

class _RightTrianglePageState extends State<RightTrianglePage> {
  TextEditingController alas = TextEditingController();
  TextEditingController tinggi = TextEditingController();
  String luas = "-";
  String keliling = "-";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color.fromARGB(255, 249, 249, 249),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            "assets/siku_triangle.png",
            height: 240,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 20),
          const Text("Enter the base and height of the triangle."),
          _inputField("Base (cm)", alas),
          _inputField("Height (cm)", tinggi),
          _calcButton(context),
          _result(),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController input) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextField(
        controller: input,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,6}(\.[0-9]*)?')),
        ],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _calcButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: TextButton(
        onPressed: () => calcHandler(),
        child: const Text('Calculate'),
      ),
    );
  }

  void calcHandler() {
    String inputAlas = alas.text;
    String inputTinggi = tinggi.text;

    if (inputAlas.isNotEmpty && inputTinggi.isNotEmpty) {
      double a = double.parse(inputAlas);
      double t = double.parse(inputTinggi);
      double miring = sqrt(a * a + t * t);
      setState(() {
        keliling = "${a + miring + t} cm";
        luas = "${(a * t) / 2} cm²";
      });
    } else {
      setState(() {
        keliling = "😵";
        luas = "😵";
      });
    }
  }

  Widget _result() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Perimeter"),
          Text(
            keliling,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text("Area"),
          Text(
            luas,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
