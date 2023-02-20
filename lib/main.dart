import 'dart:ffi';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calculator huihwe',
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "";
  String result = "0";
  String expresson = "";
  double euqationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "c") {
        equation = "";
        result = "0";
      } else if (buttonText == "⌫") {
        if (equation == "") {
          equation = "";
        } else {
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (buttonText == "=") {
        expresson = equation;

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expresson);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else {
        if (equation.length > 40) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Expression is too long!'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      // color: Color.fromARGB(255, 82, 255, 111),
      child: Container(
        margin: EdgeInsets.all(8.0), // set the margin to 10 pixels on all sides
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight *
                  0.65; // calculate the font size as 75% of the button height
              return Text(
                buttonText,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),

      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //       primary: buttonColor,
      //       onPrimary: Colors.white,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(50),

      //       )),
      //   onPressed: () => buttonPressed(buttonText),
      //   child: Text(
      //     buttonText,
      //     style: TextStyle(
      //         fontSize: 30.0,
      //         fontWeight: FontWeight.normal,
      //         color: Colors.white),
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("calculator"),
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: euqationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("c", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.grey),
                        buildButton("/", 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.blue),
                        buildButton("8", 1, Colors.blue),
                        buildButton("9", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.blue),
                        buildButton("5", 1, Colors.blue),
                        buildButton("6", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.blue),
                        buildButton("2", 1, Colors.blue),
                        buildButton("3", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.blue),
                        buildButton("0", 1, Colors.blue),
                        buildButton("00", 1, Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("*", 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("%", 1, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 1, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
