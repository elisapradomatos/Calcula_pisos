import 'package:floor_calculator/models/result_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:floor_calculator/controllers/calculator_controller.dart';



class ResultDialog extends StatelessWidget {
  final ResultModel result;

  ResultDialog(this.result);
  NumberFormat formatter = NumberFormat.currency(symbol: "R\$:");
  final _controller = CalculatorController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Result'),
      content: Wrap(
        children: [
          ListTile(
            title: Text('${result.amountPieces} pisos'),
            subtitle: Text('Quantidade de pisos'),
          ),
          ListTile(
            title: Text('${result.amountFloor} pisos'),
            subtitle: Text('Quantidade de pisos para o rodapé'),
          ),
          ListTile(
            title: Text('${result.amountPiecesAndFooter} pisos'),
            subtitle: Text('Quantidade total de pisos'),
          ),
          ListTile(
            title: Text(formatter.format(num.parse('${result.totalprice}'))),
            subtitle: Text('Valor total dos pisos'),
          ),
          Divider(),
          ListTile(
            title: Text('${result.areaWithoutFooter.toStringAsFixed(2)} m²'),
            subtitle: Text('Metragem quadrada sem rodapé'),
          ),
          ListTile(
            title: Text('${result.areaWithFooter.toStringAsFixed(2)} m²'),
            subtitle: Text('Metragem quadrada com rodapé'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('CONTINUAR'),
          onPressed: () => _dispose(context),

        ),
      ],
    );
  }

  _dispose(context) {
    Navigator.of(context).pop();
  }
}
