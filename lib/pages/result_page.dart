import 'package:BMI/pages/home_page.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  final String gender;
  final int age;
  const ResultPage({
    super.key,
    required this.bmi,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: 70),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.check, color: Colors.white, size: 100),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF464646),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BMI: ${bmi.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${gender.capitalize()}, $age Years",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${bmi < 18.5 ? "Underweight" : bmi < 25 ? "Normal" : "Overweight"}",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),

                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text(
                  "Re-Calculate BMI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
