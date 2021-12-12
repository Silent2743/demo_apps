// ignore_for_file: avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:demo_apps/Auth/register_screen.dart';
import 'package:demo_apps/Home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //inisialisasi variabel
  String _username = "";
  String _pass = "";
  bool adaUsername = false;

  checkUsername() async {
    //cek apakah ada username dan pass di shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("username");
    prefs.getString("pass");
    print(prefs.getString("username"));
    if (prefs.containsKey("username")) {
      //jika ada maka akan ada proses pengecekan
      adaUsername = true;
    } else {
      adaUsername = false;
    }
  }

  void tryLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (_username == "" || _pass == "") {
      //validasi form kosong
      final snackBar2 = SnackBar(
          backgroundColor: Colors.red, content: Text("Data harus diisi"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    } else if (adaUsername == true) {
      //validasi jika ada username dan pass di shared preferences
      if (_username != prefs.getString("username")) {
        final snackBar2 = SnackBar(
            backgroundColor: Colors.red,
            content: Text("User tidak ditemukan "));
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      } else if (_pass != prefs.getString("pass")) {
        final snackBar2 = SnackBar(
            backgroundColor: Colors.red,
            content: Text("Password tidak sesuai "));
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      } else {
        final snackBar2 = SnackBar(
            backgroundColor: Colors.green, content: Text("Sukses Login"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
    } else if (adaUsername == false) {
      //validasi belum ada user
      final snackBar2 = SnackBar(
          backgroundColor: Colors.red, content: Text("User tidak ada"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  @override
  void initState() {
    super.initState();
    //proses pengecekan pada saat halaman dibuat
    checkUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF999B84),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 70.0,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text("Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 32.0)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Username",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF999B84),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF999B84),
                                      ),
                                    ),
                                    hintText: "Enter your username",
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(105, 108, 121, 0.7),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _username = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 45.0,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF999B84),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF999B84),
                                      ),
                                    ),
                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(105, 108, 121, 0.7),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _pass = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 45.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Belum punya akun? Silahkan "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              InkWell(
                                onTap: () {
                                  tryLogin();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF999B84),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(169, 176, 185, 0.42),
                                        spreadRadius: 0,
                                        blurRadius: 8.0,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
