import 'package:flutter/material.dart';
import 'package:BMI/pages/result_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double height = 170;
  int weight = 50;
  int age = 25;
  String gender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenderSection(onGenderChanged: (val) {
              setState(() {
                gender = val;
              });
            }),
            HeightSection(onHeightChanged: (val) {
              setState(() {
                height = val;
              });
            }),
            WeightAgeSection(
              onWeightChanged: (val) {
                setState(() {
                  weight = val;
                });
              },
              onAgeChanged: (val) {
                setState(() {
                  age = val;
                });
              },
            ),
            CalculateButton(height: height, weight: weight.toDouble(), gender: gender, age: age),
          ],
        ),
      ),
    );
  }
}

// GENDER SECTION
class GenderSection extends StatefulWidget {
  final ValueChanged<String> onGenderChanged;
  const GenderSection({super.key, required this.onGenderChanged});

  @override
  State<GenderSection> createState() => _GenderSectionState();
}

class _GenderSectionState extends State<GenderSection> {
  String gender = "";
  final selectedBorder = Border.all(color: Colors.redAccent, width: 3);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1,
      children: [
        buildGenderCard("male", Icons.man),
        buildGenderCard("female", Icons.woman),
      ],
    );
  }

  Widget buildGenderCard(String selected, IconData icon) {
    bool isSelected = gender == selected;
    return InkWell(
      onTap: () {
        setState(() {
          gender = selected;
        });
        widget.onGenderChanged(gender);
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFEF5434) : Color(0xFF464646),
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? selectedBorder : Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 80),
            SizedBox(height: 10),
            Text(
              selected.capitalize(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

// HEIGHT SECTION
class HeightSection extends StatefulWidget {
  final ValueChanged<double> onHeightChanged;
  const HeightSection({super.key, required this.onHeightChanged});

  @override
  State<HeightSection> createState() => _HeightSectionState();
}

class _HeightSectionState extends State<HeightSection> {
  double _height = 170;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF464646),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Height", style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height: 10),
          Text(
            "${_height.toInt()} cm",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Slider(
            value: _height,
            min: 100,
            max: 220,
            divisions: 120,
            activeColor: Colors.red,
            inactiveColor: Colors.white,
            label: _height.toInt().toString(),
            onChanged: (changedValue) {
              setState(() {
                _height = changedValue;
              });
              widget.onHeightChanged(_height);
            },
          ),
        ],
      ),
    );
  }
}

// WEIGHT + AGE SECTION
class WeightAgeSection extends StatefulWidget {
  final ValueChanged<int> onWeightChanged;
  final ValueChanged<int> onAgeChanged;

  const WeightAgeSection({
    super.key,
    required this.onWeightChanged,
    required this.onAgeChanged,
  });

  @override
  State<WeightAgeSection> createState() => _WeightAgeSectionState();
}

class _WeightAgeSectionState extends State<WeightAgeSection> {
  int weight = 50;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      children: [
        buildInfoCard(
          "Weight",
          "$weight kg",
              () {
            setState(() {
              weight++;
            });
            widget.onWeightChanged(weight);
          },
              () {
            setState(() {
              if (weight > 1) weight--;
            });
            widget.onWeightChanged(weight);
          },
        ),
        buildInfoCard(
          "Age",
          "$age Years",
              () {
            setState(() {
              age++;
            });
            widget.onAgeChanged(age);
          },
              () {
            setState(() {
              if (age > 1) age--;
            });
            widget.onAgeChanged(age);
          },
        ),
      ],
    );
  }

  Widget buildInfoCard(
      String label,
      String value,
      VoidCallback onPlus,
      VoidCallback onMinus,
      ) {
    Widget circularIconButton(String label, VoidCallback onPressed) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 2, color: Colors.white),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF464646),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 25)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              circularIconButton("+", onPlus),
              circularIconButton("-", onMinus),
            ],
          ),
        ],
      ),
    );
  }
}

// CALCULATE BUTTON
class CalculateButton extends StatelessWidget {
  final double height;
  final double weight;
  final String gender;
  final int age;

  const CalculateButton({
    super.key,
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          if (gender.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please select a gender")),
            );
            return;
          }

          double heightInMeters = height / 100;
          double bmi = weight / (heightInMeters * heightInMeters);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                bmi: bmi,
                gender: gender,
                age: age,
              ),
            ),
          );
        },
        child: Text("Calculate BMI", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
