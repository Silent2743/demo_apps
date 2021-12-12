// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:demo_apps/Model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //inisialisasi variabel
  Dio dio = Dio();
  var listMeal = <MealElement>[];
  final formatCurrency =
      NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp. ');

  Future<void> fetchMenu() async {
    //get menu dari api
    try {
      Response response = await dio
          .get("https://www.themealdb.com/api/json/v1/1/filter.php?a=American");
      print(response.data);
      setState(() {
        listMeal = (response.data["meals"] as List)
            .map((child) => MealElement.fromJson(child))
            .toList();
      });
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Dashboard")),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List Menu",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listMeal.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              listMeal[index].strMealThumb,
                              width: 100,
                              height: 100,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF999B84)),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listMeal[index].strMeal),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(formatCurrency.format(
                                        int.parse(listMeal[index].idMeal))),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
