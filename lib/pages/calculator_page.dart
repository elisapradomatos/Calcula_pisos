import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:floor_calculator/dialogs/result_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();


}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = CalculatorController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de pisos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: _buildForm(),
        ),
      ),
    );
  }

  _buildForm() {

    return Form(

      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderText('Dimensões do cômodo'),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Largura (metros)',
            onSaved: _controller.setRoomWidth,

          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Comprimento (metros)',
            onSaved: _controller.setRoomLength,
          ),
          _buildVerticalSpace(),
          _buildHeaderText('Dimensões do piso'),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Largura (centímetros)',
            onSaved: _controller.setFloorWidth,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Comprimento (centímetros)',
            onSaved: _controller.setFloorLength,
          ),
          _buildVerticalSpace(),
          _buildHeaderText('Valor do piso'),
          _buildVerticalSpace(),
          _buildNumberInputField('Preço em R\$',
            onSaved: _controller.setPriceValue,
          ),

          _buildVerticalSpace(height: 40),
          _buildCalculateButton(),

         ],
      ),
    );
  }

  _buildNumberInputField(String label, {Function(String) onSaved}) {
    var _controller = TextEditingController();
    return TextFormField(
      controller: _controller,
      validator: _validarCampo,
      onSaved: onSaved,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        suffixIcon: IconButton(
          onPressed: () => _controller.clear(),
          icon: Icon(Icons.clear),
        ),
      ),
      keyboardType: TextInputType.number,

      maxLines: 1,

    );

  }

  _buildCalculateButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
      child: const Text('CALCULAR'),
        onPressed: _calcular,


    );
  }



  _buildHeaderText(String label) {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.2),
      height: 40,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildVerticalSpace({double height = 20.0}) {
    return SizedBox(height: height);
  }

  void _calcular() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final result = _controller.calculate();
      showDialog(
        context: context,
        builder: (context) => ResultDialog(result),
      );


     }
  }

   String _validarCampo(String value) {
    String patttern = '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o valor";
    }else if (!regExp.hasMatch(value)) {
      return "Caracter inválido";
    } else if(double.parse(value) < 0){
      return "Não pode ser menor que zero";
    }

  }




}
