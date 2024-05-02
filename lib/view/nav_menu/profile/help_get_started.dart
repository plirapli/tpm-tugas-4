import 'package:flutter/material.dart';

class GetStartedContent extends StatelessWidget {
  const GetStartedContent({super.key});

  static const List<String> textList = [
    "Ketika pengguna pertama kali membuka aplikasi, maka penggunaa akan diarahkan ke halaman login.",
    "Jika pengguna sudah mempunyai akun, pengguna bisa langsung melakukan login dengan cara memasukkan username dan password yang terdaftar, lalu tekan tombol login. Namun, jika pengguna belum memiliki akun, pengguna bisa menekan tombol register yang terdapat di bawah tombol login.",
    "Pada halaman register, pengguna bisa mendaftarkan akun dengan mengisi bagian Nama, Username, dan Password. Jika sudah, tekan tombol register untuk mendaftarkan akun.",
    "Setelah melakukan pendaftaran akun, pengguna akan diarahkan ke halaman login untuk melakukan login.",
    "Setelah berhasil login, pengguna akan dibawa ke halaman utama. Pada halaman ini, terdapat 3 menu utama, yaitu Menu Utama, Menu Stopwatch, dan Menu Profile",
    "Pada Menu Utama, terdapat 5 menu yang menjadi fitur utama dari aplikasi ini, yaitu menu Prime Numbers, Triangle, Premiere League Clubs, Favorite, dan About Me.",
    "Pada Menu Stopwatch, terdapat aplikasi stopwatch yang dapat digunakan untuk mengukur waktu.",
    "Pada Menu Profile, terdapat informasi dari akun yang kita miliki. Di bawahnya juga terdapat 2 tombol, yaitu tombol Help untuk bantuan cara menggunakan aplikasi dan tombol Logout untuk keluar dari akun yang dimiliki user.",
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
