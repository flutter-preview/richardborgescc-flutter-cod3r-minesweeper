import 'dart:math';

import 'campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar() {
    _campos.forEach((campo) {
      campo.reiniciar();
    });
    _sortearMinas();
  }

  void revelarBombas() {
    _campos.forEach((campo) => campo.revelarBomba());
  }

  void _criarCampos() {
    for (var linha = 0; linha < linhas; linha++) {
      for (var coluna = 0; coluna < colunas; coluna++) {
        _campos.add(Campo(linha: linha, coluna: coluna));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdeBombas < linhas * colunas) {
      return;
    }

    while (sorteadas < qtdeBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((campo) => campo.resolvido);
  }
}
