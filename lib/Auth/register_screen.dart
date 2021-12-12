// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison

import 'package:demo_apps/Auth/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //inisialisasi variabel
  String _regisUsername = "";
  String _regisPassword = "";
  bool _loadingBtn = false; //untuk loading
  Dio dio = Dio();

//proses hit API
  void postHTTP() async {
    setState(() {
      _loadingBtn = true;
    });
    if (_regisPassword == "" || _regisUsername == "") {
      //proses validasi jika form masih kosong
      final snackBar2 = SnackBar(
          backgroundColor: Colors.red, content: Text("Data harus diisi"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      setState(() {
        _loadingBtn = false;
      });
    } else {
      try {
        //proses hit API
        String url = "https://fakerestapi.azurewebsites.net/api/v1/Users";
        Map data = {"userName": _regisUsername, "password": _regisPassword};
        Response response = await dio.post(url, data: data);
        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          //jika berhasil hit API, maka ambil username dan passeord
          var resUsername = response.data['userName'];
          var resPass = response.data['password'];

          final prefs = await SharedPreferences.getInstance();
          //menyimpan username dan passwoord ke shared preferences untuk di cek saat login
          prefs.setString('username', resUsername);
          prefs.setString('pass', resPass);
          final snackBar2 = SnackBar(
              backgroundColor: Colors.green, content: Text("Sukses daftar"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar2);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } on DioError catch (e) {
        //menampilkan pesan error pada saat hit API
        final snackBar2 =
            SnackBar(backgroundColor: Colors.red, content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
        setState(() {
          _loadingBtn = false;
        });
      }
    }
    setState(() {
      _loadingBtn = false;
    });
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
                              child: Text("Daftar",
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
                                    hintText: "Create your username",
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(105, 108, 121, 0.7),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _regisUsername = value;
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
                                    hintText: "Create your password",
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(105, 108, 121, 0.7),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _regisPassword = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 45.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sudah punya akun? Silahkan "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  postHTTP();
                                },
                                child: _loadingBtn == true
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF999B84),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  169, 176, 185, 0.42),
                                              spreadRadius: 0,
                                              blurRadius: 8.0,
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Daftar",
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
//Perngrq ol : Nevse2743 (n=13)