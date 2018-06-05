import 'package:cesufood_app/components/form/auth/ButtonSubmitAuth.dart';
import 'package:cesufood_app/components/form/auth/EmailFormField.dart';
import 'package:cesufood_app/components/form/auth/RaFormField.dart';
import 'package:cesufood_app/components/form/auth/SenhaFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

const PAGE_LOGIN = 1;
const PAGE_ESQUECI_SENHA = 3;

class CadastroForm extends StatefulWidget {
  final Function onChangePage;

  const CadastroForm({Key key, this.onChangePage}) : super(key: key);
  @override
  _CadastroFormState createState() => new _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController inputEmailController = new MaskedTextController(mask: '00000000');
  final TextEditingController inputRAController = new MaskedTextController(mask: '00000000');
  final TextEditingController inputSenhaController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputEmailController.dispose();
    inputRAController.dispose();
    inputSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new EmailFormField(
            color: 0xFFC0C4CC,
            controller: inputEmailController,
          ),
          new RaFormField(
            color: 0xFFC0C4CC,
            controller: inputRAController,
          ),
          new SenhaFormField(
            color: 0xFFC0C4CC,
            controller: inputSenhaController
          ),
          new ButtomSubmitAuth(
            text: 'CADASTRAR',
            onTap: () {
              if (_formKey.currentState.validate()) {
                // TODO Enviar Request
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text(inputRAController.text)));
              }
              setState(() {});
            },
          ),
          new Padding(
            padding: const EdgeInsets.only(bottom: 28.5),
            child: new Divider(
              height: 10.0,
              color: Color(0xFFC0C4CC),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 66.0),
            child: new Material(
              color: Colors.transparent,
              child: new InkWell(
                onTap: () =>  widget.onChangePage(PAGE_LOGIN),
                borderRadius: new BorderRadius.circular(10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: new Text(
                        'Já possui conta?',
                        style: new TextStyle(color: Color(0xFFC0C4CC)),
                      ),
                    ),
                    new Text('Entrar')
                  ],
                ),
              ),
            ),
          ),
        ],
      ), // We'll build this out in the next steps!
    );
  }
}
