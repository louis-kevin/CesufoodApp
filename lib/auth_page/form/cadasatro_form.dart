import 'package:cesufood_app/auth_page/components/ButtonSubmitAuth.dart';
import 'package:cesufood_app/auth_page/components/EmailFormField.dart';
import 'package:cesufood_app/auth_page/components/RaFormField.dart';
import 'package:cesufood_app/auth_page/components/SenhaFormField.dart';
import 'package:cesufood_app/auth_page/components/TextButtonAuth.dart';
import 'package:cesufood_app/services/auth_service.dart';
import 'package:cesufood_app/services/service.dart';
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
  final TextEditingController inputEmailController =
  new TextEditingController();
  final TextEditingController inputRAController =
  new MaskedTextController(mask: '00000000');
  final TextEditingController inputSenhaController =
  new TextEditingController();

  String errorInputEmail= '';
  String errorInputRa = '';
  String errorInputSenha = '';
  bool loading = false;

  AuthService authService;

  @override
  void dispose() {
    super.dispose();
    inputEmailController.dispose();
    inputRAController.dispose();
    inputSenhaController.dispose();
  }

  sendCadastroForm(context) async {
    Object data = {
      'email': inputEmailController.text,
      'ra': inputRAController.text,
      'senha': inputSenhaController.text
    };
    ParsedResponse response = await this.authService.cadastro(data);

    if (response.isOk()) {
      errorInputEmail = '';
      errorInputRa = '';
      errorInputSenha = '';
      Navigator.of(context).pushNamed('/main');
    }

    if (response.isBadRequest()) {
      errorInputEmail = response.getFirstErrorInput('email');
      errorInputRa = response.getFirstErrorInput('ra');
      errorInputSenha = response.getFirstErrorInput('senha');
    }
    setState(() { loading = false; });
  }

  getButtom(context){
    if(loading){
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 34.6),
        width: double.infinity,
        child: Center(
          child: new CircularProgressIndicator(),// TODO alinhar loading
        ),
      );
    }

    return new ButtonSubmitAuth(
      text: 'CADASTRAR',
      onTap: () async {
        if (!_formKey.currentState.validate()) {
          setState(() {});
          return false;
        }
        setState(() { loading = true; });
        sendCadastroForm(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this.authService = new AuthService(context);
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new EmailFormField(
            color: 0xFFC0C4CC,
            controller: inputEmailController,
            errorText: errorInputEmail
          ),
          new RaFormField(
            color: 0xFFC0C4CC,
            controller: inputRAController,
            errorText: errorInputRa,
          ),
          new SenhaFormField(
              color: 0xFFC0C4CC,
            controller: inputSenhaController,
              errorText: errorInputSenha,
          ),
          getButtom(context),
          new Padding(
            padding: const EdgeInsets.only(bottom: 28.5),
            child: new Divider(
              height: 10.0,
              color: Color(0xFFC0C4CC),
            ),
          ),
          new TextButtonAuth(
            onPressed: () => widget.onChangePage(PAGE_LOGIN),
            firstText: 'Já possui conta?',
            secondText: 'Entrar',
          ),
        ],
      ), // We'll build this out in the next steps!
    );
  }
}
