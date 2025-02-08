// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = "", _result = "0";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "0";
      } else if (value == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          _result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          _result = "Error";
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String text, Color color) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () => _onButtonPressed(text),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.all(20),
            ),
            child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Calculadora"), backgroundColor: Colors.blueGrey),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expression, style: TextStyle(fontSize: 24, color: Colors.grey[800])),
                  const SizedBox(height: 10),
                  Text(_result, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                for (var row in [["7", "8", "9", "/"], ["4", "5", "6", "*"], ["1", "2", "3", "-"], ["C", "0", "=", "+"]])
                  Row(
                    children: row.map((btn) => _buildButton(
                      btn,
                      btn == "C" ? Colors.red :
                      btn == "=" ? Colors.green :
                      "/+-*".contains(btn) ? Colors.orange :
                      Colors.blueGrey
                    )).toList(),
                  ),
                Row(
                  children: ["sin(", "cos(", "tan(", "log("]
                      .map((func) => _buildButton(func, Colors.purple))
                      .toList(),
                ),
                Row(
                  children: [")", "(", "^", "%"]
                      .map((symbol) => _buildButton(symbol, Colors.deepOrange))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

