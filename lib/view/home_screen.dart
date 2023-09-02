//import 'dart:async';
//import 'dart:js_interop';
import 'package:age_calculator/helper/util.dart';
import 'package:age_calculator/provider/calculator_provider.dart';
import 'package:age_calculator/view/fav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  TextEditingController currentDate = TextEditingController();
  TextEditingController name = TextEditingController();
  int days = 0;
  int months = 0;
  int years = 0;
  int nextBirthMonth = 0;
  int nextBirthDays = 0;
  DateTime? selectDate;
  Map<String, dynamic>? totalAge;
  Map<String, dynamic>? nextBirthDate;
  Map<String, dynamic>? totalLife;

  List<Map> persons = [{}];

  DateTime? selectdate;
  getCurrentDate() {
    DateTime currentDate = DateTime.now();

    this.currentDate.text = DateFormat('dd-MM-yyyy').format(currentDate);
    setState(() {});
  }

  @override
  void initState() {
    getCurrentDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Age Calculator"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 91, 72, 177),
        actions: [
          SizedBox(
              width: 40,
              child: GestureDetector(
                child: const Icon(Icons.favorite),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavScreen(
                              userlist: CalculatorProvider.userlist)));
                },
              )),
          const SizedBox(width: 30, child: Icon(Icons.share))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 91, 72, 177),
              child: Column(
                children: [
                  const Text(
                    "Date of today",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: currentDate,
                      readOnly: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 45, maxHeight: 45),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                                child: const Icon(
                                  Icons.calendar_month,
                                  size: 28,
                                  color: Colors.white,
                                )),
                          ),
                          iconColor: const Color.fromARGB(255, 91, 72, 177),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      "Date of Birth",
                      style: TextStyle(
                          color: Color.fromARGB(255, 91, 72, 177),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      readOnly: true,
                      cursorColor: const Color.fromARGB(255, 91, 72, 177),
                      decoration: InputDecoration(
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 45, maxHeight: 45),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1976),
                                  lastDate: DateTime.now());
                              selectdate = picked;
                              if (picked != null && selectdate != null) {
                                controller.text =
                                    DateFormat('dd-MM-yyyy').format(picked);
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Icon(
                                  Icons.calendar_month,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 91, 72, 177)),
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          if (selectdate != null) {
                            totalAge = CalculatorProvider.calculateAgeDetails(
                                selectdate!);
                            nextBirthDate =
                                CalculatorProvider.calculateNextBirth(
                                    selectdate!);
                            totalLife = CalculatorProvider.calculateAgeDetails(
                                selectdate!);
                          }
                          setState(() {});
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: const Text("Calculate"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () async {
                          if (controller.text.isEmpty) {
                            EasyLoading.showError("status");
                          } else {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (name.text.isEmpty) {
                                          EasyLoading.showError("Enter Name");
                                        } else {
                                          CalculatorProvider.createUserList({
                                            "name": name.text,
                                            "birthdate": controller.text
                                          });
                                        }
                                        setState(() {
                                          name.clear();
                                        });
                                        Navigator.pop(context);
                                        //print(persons);
                                      },
                                      child: const Text("Save"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        name.clear();
                                      },
                                      child: const Text("Clear"),
                                    ),
                                  ],
                                  title: const Text("Enter your name"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: name,
                                        decoration: InputDecoration(
                                            labelText: "Name",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                      ),
                                      vSize(10),
                                      TextField(
                                        readOnly: true,
                                        controller: controller,
                                        decoration: InputDecoration(
                                            labelText: "Birthdate",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          ;
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: const Text("Save"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Total age",
                style: TextStyle(
                    color: Color.fromARGB(255, 91, 72, 177),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 239, 244),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 112, 109, 109))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: columnConatiner(context,
                          title: "Years",
                          value:
                              "${totalAge != null ? totalAge!["years"] : 0}"),
                    ),
                    verticalDivider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: columnConatiner(context,
                          title: "Months",
                          value:
                              "${totalAge != null ? totalAge!["months"] : 0}"),
                    ),
                    verticalDivider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: columnConatiner(context,
                          title: "Days",
                          value: "${totalAge != null ? totalAge!["days"] : 0}"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: const Column(
                  children: [
                    Text("Next Birthday",
                        style: TextStyle(
                            color: Color.fromARGB(255, 91, 72, 177),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 239, 244),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 112, 109, 109))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: columnConatiner(context,
                          title: "Months",
                          value:
                              "${nextBirthDate != null ? nextBirthDate!["months"] : 0}"),
                    ),
                    verticalDivider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: columnConatiner(context,
                          title: "Days",
                          value:
                              "${nextBirthDate != null ? nextBirthDate!["days"] : 0}"),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Total Life of",
                  style: TextStyle(
                      color: Color.fromARGB(255, 91, 72, 177),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 239, 244),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 112, 109, 109))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("Years"),
                          vSize(5),
                          const Text("Months"),
                          vSize(5),
                          const Text("Days"),
                          vSize(5),
                          const Text("Week"),
                          vSize(5),
                          const Text("Hours")
                        ],
                      ),
                      verticalDivider(height: 100),
                      Column(
                        children: [
                          Text(
                              "${totalLife != null ? totalLife!["years"] : "0"}",
                              style: const TextStyle(fontSize: 15)),
                          vSize(5),
                          Text(
                              "${totalLife != null ? totalLife!['months'] : "0"}",
                              style: const TextStyle(fontSize: 15)),
                          vSize(5),
                          Text(
                              "${totalLife != null ? totalLife!['days'] : "0"}",
                              style: const TextStyle(fontSize: 15)),
                          vSize(5),
                          Text(
                              "${totalLife != null ? totalLife!['weeks'] : "0"}",
                              style: const TextStyle(fontSize: 15)),
                          vSize(5),
                          Text(
                              "${totalLife != null ? totalLife!['hours'] : "0"}",
                              style: const TextStyle(fontSize: 15))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: MediaQuery.sizeOf(context).width * 0.5,
            //   color: Color.fromARGB(255, 91, 72, 177),
            // )
          ],
        ),
      ),
    );
  }
}
