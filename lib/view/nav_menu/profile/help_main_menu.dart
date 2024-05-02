import 'package:flutter/material.dart';

class PrimeNumberContent extends StatelessWidget {
  const PrimeNumberContent({super.key});

  static const List<String> textList = [
    "Prime Numbers merupakan salah satu fitur dalam aplikasi ini yang berfungsi untuk mengecek apakah suatu bilangan termasuk ke dalam bilangan prima atau bukan.",
    "Pengguna bisa mengakses fitur ini dengan masuk ke menu utama, lalu memilih menu \"Prime Numbers\".",
    "Pengguna akan diminta untuk memasukkan angka di antara 0 sampai dengan 1.000.000.000.000 (1 Triliun).",
    "Setelah pengguna memasukkan angka, pengguna bisa menekan tombol, \"Check\" untuk mengecek apakah angka yang dimasukkan termasuk ke dalam bilangan prima atau bukan.",
    "Jika angka tersebut termasuk bilangan prima, maka akan muncul tulisan \"PRIME\" pada bagian result.",
    "Namun, jika angka tersebut tidak termasuk bilangan prima, maka akan muncul tulisan \"NOT PRIME\".",
    "Jika pengguna tidak memasukkan angka apapun dan langsung menekan tombol \"Check\", maka akan tampil simbol \"😵\"."
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: textList.map((text) => _text(text)).toList(),
    );
  }

  Widget _text(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

class TriangleContent extends StatelessWidget {
  const TriangleContent({super.key});

  static const List<String> textList = [
    "Triangle merupakan salah satu fitur dalam aplikasi ini yang berfungsi untuk menghitung luas dan keliling dari bangun segitiga siku-siku.",
    "Pengguna bisa mengakses fitur ini dengan masuk ke menu utama, lalu memilih menu \"Triangle\".",
    "Pengguna akan diminta untuk memasukkan alas dan tinggi pada form yang tersedia.",
    "Setelah pengguna memasukkan alas dan tinggi, pengguna bisa menekan tombol, \"Calculate\" untuk melihat hasil perhitungan keliling dan luas dari segitiga siku-siku.",
    "Jika pengguna tidak memasukkan alas atau tinggi dan langsung menekan tombol \"Calculate\", maka akan tampil simbol \"😵\"."
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: textList.map((text) => _text(text)).toList(),
    );
  }

  Widget _text(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
