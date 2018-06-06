import 'package:cesufood_app/auth_page/form/cadasatro_form.dart';
import 'package:cesufood_app/auth_page/form/esqueci_senha_form.dart';
import 'package:cesufood_app/auth_page/form/login_form.dart';
import 'package:cesufood_app/components/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const PAGE_LOGIN = 1;
const PAGE_CADASTRO = 2;
const PAGE_ESQUECI_SENHA = 3;

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  var page = PAGE_LOGIN;

  AnimationController _animationLoginController;
  AnimationController _animationCadastroController;
  AnimationController _animationEsqueciSenhaController;
  Animation<double> animationFormLogin;
  Animation<double> animationFormCadastro;
  Animation<double> animationFormEsqueciSenha;

  @override
  void initState() {
    super.initState();

    _animationLoginController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animationFormLogin = new Tween(
      begin: 500.0,
      end: 0.0,
    ).animate(_animationLoginController)
      ..addListener(() {
        setState(() {});
      });

    _animationLoginController.forward();

    _animationCadastroController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animationFormCadastro = new Tween(
      begin: 500.0,
      end: 0.0,
    ).animate(_animationCadastroController);

    _animationCadastroController.addListener(() {
      setState(() {});
    });

    _animationEsqueciSenhaController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animationFormEsqueciSenha = new Tween(
      begin: -500.0,
      end: 0.0,
    ).animate(_animationEsqueciSenhaController);

    _animationEsqueciSenhaController.addListener(() {
      setState(() {});
    });
  }

  void changePage(value) {
    page = value;
    switch (value) {
      case PAGE_LOGIN:
        if (_animationLoginController.status != AnimationStatus.completed) {
          _animationLoginController.forward();
        }
        if (_animationCadastroController.status == AnimationStatus.completed) {
          _animationCadastroController.reverse();
        }
        if (_animationEsqueciSenhaController.status ==
            AnimationStatus.completed) {
          _animationEsqueciSenhaController.reverse();
        }
        break;
      case PAGE_CADASTRO:
        if (_animationCadastroController.status != AnimationStatus.completed) {
          _animationCadastroController.forward();
        }
        if (_animationLoginController.status == AnimationStatus.completed) {
          _animationLoginController.reverse();
        }
        if (_animationEsqueciSenhaController.status ==
            AnimationStatus.completed) {
          _animationEsqueciSenhaController.reverse();
        }
        break;

      case PAGE_ESQUECI_SENHA:
        if (_animationEsqueciSenhaController.status !=
            AnimationStatus.completed) {
          _animationEsqueciSenhaController.forward();
        }
        if (_animationCadastroController.status == AnimationStatus.completed) {
          _animationCadastroController.reverse();
        }
        if (_animationLoginController.status == AnimationStatus.completed) {
          _animationLoginController.reverse();
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationLoginController.dispose();
    _animationCadastroController.dispose();
    _animationEsqueciSenhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        height: double.infinity,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomRight,
            colors: [
              new Color(0xFF283B60),
              new Color(0xFF4F689C),
            ],
          ),
        ),
        child: new SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: new Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                width: double.infinity,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(
                        left: 90.0,
                        right: 90.0,
                        top: 40.0,
                        bottom: 10.0,
                      ),
                      child: new Logo(),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          'CESU',
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        new Text(
                          'FOOD',
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              new Stack(children: [
                new Container(
                  transform: new Matrix4.translationValues(
                      animationFormLogin.value *
                          (animationFormCadastro.status !=
                                  AnimationStatus.dismissed
                              ? -1
                              : 1),
                      0.0,
                      0.0),
                  child: new LoginForm(
                    onChangePage: changePage,
                  ),
                ),
                new Container(
                  transform: new Matrix4.translationValues(
                      animationFormCadastro.value, 0.0, 0.0),
                  child: new CadastroForm(
                    onChangePage: changePage,
                  ),
                ),
                new Container(
                  transform: new Matrix4.translationValues(
                      animationFormEsqueciSenha.value, 0.0, 0.0),
                  child: new EsqueciSenhaForm(
                    onChangePage: changePage,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
