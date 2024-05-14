import 'package:flutter/material.dart';
import 'package:tpm_tugas_4/view/main_menu/triangle/equilateral.dart';
import 'package:tpm_tugas_4/view/main_menu/triangle/right.dart';
import 'package:tpm_tugas_4/view/main_menu/triangle/isosceles.dart';

class TrianglePage extends StatelessWidget {
  const TrianglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Right-Angle"),
              Tab(text: "Equilateral"),
              Tab(text: "Isosceles")
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            overlayColor: MaterialStatePropertyAll(Colors.white12),
          ),
          title: const Text("Triangle"),
        ),
        body: const TabBarView(
          children: [
            RightTrianglePage(),
            EquilateralTrianglePage(),
            IsoscelesTrianglePage()
          ],
        ),
      ),
    );
  }
}
