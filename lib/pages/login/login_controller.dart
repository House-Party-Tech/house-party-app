import 'package:flutter/material.dart';
import 'package:house_party/database/dao/user_dao.dart';
import 'package:house_party/http/webclients/user_webclient.dart';
import 'package:house_party/models/user.dart';

class LoginController {
  static LoginController _instance = LoginController._();

  LoginController._();
  
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserWebClient _userWebClient = UserWebClient();

  static get getInstance => _instance;
  GlobalKey<FormState> get formKey => this._formKey;

  void navigateToCategoryPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/category', (route) => false);
  }

  Future<User> validateAccess(BuildContext context) async {
    User user;
    if (loginTextController.text.contains('@')) {
      user = await _userWebClient.loginWithEmail(loginTextController.text, passwordTextController.text);
    } else {
      user = await _userWebClient.loginWithUserName(loginTextController.text, passwordTextController.text);
    }
    return user;
  }

  validateUserInput(String value) {
    if(value.isEmpty || value.length < 3) {
      return 'É necessário informar uma forma de acesso valida';
    }
  }

  validatePasswordInput(String value) {
    if(value.isEmpty) {
      return 'Informe sua senha';
    }
  }

  void actionEnterButton(BuildContext context) async {
    if (formKey.currentState.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator())
      );
      User user = await validateAccess(context);
      if (user != null) {
        debugPrint(user.toString());
        UserDAO().save(user);
        Navigator.pop(context);
        navigateToCategoryPage(context);
      } else {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário ou senha incorreto', textAlign: TextAlign.center),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red[900],
          )
        );
      }
    }
  }

}
