import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const AppCalculadora());
}

class AppCalculadora extends StatelessWidget {
  const AppCalculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaCalculadora(),
    );
  }
}

class TelaCalculadora extends StatefulWidget {
  const TelaCalculadora({super.key});

  @override
  State<TelaCalculadora> createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaCalculadora> {
  String _saida = "";
  String _entrada = "";

  void pressionarBotao(String textoBotao) {
    setState(() {
      if (textoBotao == "=") {
        try {
          _saida = _calcular();
          _entrada = _calcular();
        } catch (e) {
          _saida = "Erro";
        }
      } else if (textoBotao == "C") {
        _saida = "";
        _entrada = "";
      } else {
        _entrada += textoBotao;
      }
    });
  }

  String _calcular() {
    try {
      Parser parser = Parser();
      Expression expressao = parser.parse(_entrada);
      ContextModel contexto = ContextModel();
      double resultado = expressao.evaluate(EvaluationType.REAL, contexto);
      return resultado.toString();
    } catch (e) {
      return "Erro";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora Flutter"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Text(
                // 'Entrada',
                _entrada,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Text(
                // 'Saida',
                _saida,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 12,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        int numero = index + 1;
                        if (numero == 10) {
                          return BotaoCalculadora(
                            texto: 'C',
                            aoPressionar: () {
                              pressionarBotao('C');
                            },
                          );
                        } else if (numero == 11) {
                          return BotaoCalculadora(
                            texto: '0',
                            aoPressionar: () {
                              pressionarBotao('0');
                            },
                          );
                        } else if (numero == 12) {
                          return BotaoCalculadora(
                            texto: '=',
                            aoPressionar: () {
                              pressionarBotao('=');
                            },
                          );
                        } else {
                          return BotaoCalculadora(
                            texto: numero.toString(),
                            aoPressionar: () {
                              pressionarBotao(numero.toString());
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        int numero = index + 1;
                        if (numero == 1) {
                          return BotaoCalculadora(
                            texto: '/',
                            aoPressionar: () {
                              pressionarBotao('/');
                            },
                          );
                        } else if (numero == 2) {
                          return BotaoCalculadora(
                            texto: '*',
                            aoPressionar: () {
                              pressionarBotao('*');
                            },
                          );
                        } else if (numero == 3) {
                          return BotaoCalculadora(
                            texto: '-',
                            aoPressionar: () {
                              pressionarBotao('-');
                            },
                          );
                        } else if (numero == 4) {
                          return BotaoCalculadora(
                            texto: '+',
                            aoPressionar: () {
                              pressionarBotao('+');
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BotaoCalculadora extends StatelessWidget {
  const BotaoCalculadora(
      {super.key, required this.texto, required this.aoPressionar});
  final String texto;
  final Function aoPressionar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          aoPressionar();
        },
        child: Text(
          texto,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
