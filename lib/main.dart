import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe Seus Dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe Seus Dados";
    });
  }

  void _calcular() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText =
            "Você está muito magro!          IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Você está bem! IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            "Você está meio gordo!    IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText =
            "Você está gordo!  (Obesidade I) IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText =
            "Você está muito gordo! (Obesidade II) IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40) {
        _infoText =
            "Você está MUITO GORDO! (Obesidade III) IMC: ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.accessibility, size: 160.0, color: Colors.indigo),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 22.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 22.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Container(
                  height: 65.0,
                  child: RaisedButton(
                    onPressed: _calcular,
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.indigo,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
