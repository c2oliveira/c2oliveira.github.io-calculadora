// Importação das bibliotecas necessárias para a aplicação Flutter
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // Biblioteca para avaliar expressões matemáticas

void main() => runApp(const CalculatorApp()); // Função principal que executa o aplicativo

// Classe principal do aplicativo, que retorna a interface do usuário
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug da interface
      home: Calculator(), // Define a tela principal como a calculadora
    );
  }
}

// Classe que representa a tela principal da calculadora
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState(); // Cria o estado da calculadora
}

// Estado da calculadora onde a lógica de funcionamento está implementada
class _CalculatorState extends State<Calculator> {
  String _expression = "", _result = "0"; // Variáveis para armazenar a expressão digitada e o resultado

  // Função chamada quando um botão da calculadora é pressionado
  void _onButtonPressed(String value) {
    setState(() { // Atualiza a interface do usuário
      if (value == "C") { // Se o botão for "C", limpa a expressão e o resultado
        _expression = "";
        _result = "0";
      } else if (value == "=") { // Se o botão for "=", avalia a expressão matemática
        try {
          _result = Parser() // Usa a biblioteca para avaliar a expressão
              .parse(_expression)
              .evaluate(EvaluationType.REAL, ContextModel())
              .toString(); // Converte o resultado para string
        } catch (e) {
          _result = "Error"; // Em caso de erro na expressão, exibe "Error"
        }
      } else {
        _expression += value; // Se for um número ou operador, adiciona à expressão
      }
    });
  }

  // Função para criar os botões da calculadora de forma dinâmica
  Widget _buildButton(String text, Color color) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4.0), // Adiciona espaçamento entre os botões
          child: ElevatedButton(
            onPressed: () => _onButtonPressed(text), // Define a ação ao clicar no botão
            style: ElevatedButton.styleFrom(
              backgroundColor: color, // Define a cor do botão
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // Borda arredondada
              padding: const EdgeInsets.all(20), // Tamanho do botão
            ),
            child: Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Cor de fundo da tela
      appBar: AppBar(title: const Text("Calculadora"), backgroundColor: Colors.blueGrey), // Barra superior com título
      body: Column(
        children: [
          Expanded(
            flex: 2, // Área superior para exibição da expressão e do resultado
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight, // Alinha os textos à direita
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expression, style: TextStyle(fontSize: 24, color: Colors.grey[800])), // Exibe a expressão
                  const SizedBox(height: 10),
                  Text(_result, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black)), // Exibe o resultado
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3, // Área inferior com os botões da calculadora
            child: Column(
              children: [
                for (var row in [["7", "8", "9", "/"], ["4", "5", "6", "*"], ["1", "2", "3", "-"], ["C", "0", "=", "+"]])
                  Row(
                    children: row.map((btn) => _buildButton(
                      btn,
                      btn == "C" ? Colors.red : // Define a cor do botão C (vermelho)
                      btn == "=" ? Colors.green : // Define a cor do botão = (verde)
                      "/+-*".contains(btn) ? Colors.orange : // Define a cor dos operadores (laranja)
                      Colors.blueGrey // Define a cor dos números (azul acinzentado)
                    )).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
