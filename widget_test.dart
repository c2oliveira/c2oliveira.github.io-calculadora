// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';

void main() {
  testWidgets('Testando a funcionalidade da calculadora', (WidgetTester tester) async {
    // Inicializa o aplicativo
    await tester.pumpWidget(CalculatorApp() as Widget);

    // Localiza os botões e a tela de exibição
    final button1 = find.text('1');
    final button2 = find.text('2');
    final buttonAdd = find.text('+');
    final buttonEquals = find.text('=');
    final resultDisplay = find.textContaining('0');

    // Verifica se os elementos básicos estão na tela
    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    expect(buttonAdd, findsOneWidget);
    expect(buttonEquals, findsOneWidget);
    expect(resultDisplay, findsWidgets);

    // Simula o clique nos botões '1', '+', '2', '='
    await tester.tap(button1);
    await tester.pump();

    await tester.tap(buttonAdd);
    await tester.pump();

    await tester.tap(button2);
    await tester.pump();

    await tester.tap(buttonEquals);
    await tester.pump();

    // Verifica se o resultado esperado aparece na tela
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Testando o botão de limpar (C)', (WidgetTester tester) async {
    // Inicializa o aplicativo
    await tester.pumpWidget(CalculatorApp() as Widget);

    // Localiza os botões e a tela de exibição
    final button1 = find.text('1');
    final buttonClear = find.text('C');
    final resultDisplay = find.textContaining('0');

    // Simula o clique no botão '1'
    await tester.tap(button1);
    await tester.pump();

    // Verifica se o número '1' aparece na expressão
    expect(find.textContaining('1'), findsOneWidget);

    // Simula o clique no botão 'C'
    await tester.tap(buttonClear);
    await tester.pump();

    // Verifica se a tela foi limpa
    expect(resultDisplay, findsWidgets);
  });

  testWidgets('Testando divisões por zero', (WidgetTester tester) async {
    // Inicializa o aplicativo
    await tester.pumpWidget(CalculatorApp() as Widget);

    // Localiza os botões
    final button1 = find.text('1');
    final buttonDivide = find.text('/');
    final button0 = find.text('0');
    final buttonEquals = find.text('=');

    // Simula o clique nos botões '1', '/', '0', '='
    await tester.tap(button1);
    await tester.pump();

    await tester.tap(buttonDivide);
    await tester.pump();

    await tester.tap(button0);
    await tester.pump();

    await tester.tap(buttonEquals);
    await tester.pump();

    // Verifica se o erro esperado aparece na tela
    expect(find.text('Error'), findsOneWidget);
  });
}

class CalculatorApp {
}
