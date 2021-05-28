import 'package:flutter/material.dart';
import 'package:house_party/components/input_text.dart';
import 'package:house_party/pages/login/login_controller.dart';

class UserLoginPage extends StatefulWidget {  
  @override
  UserLoginPageState createState() =>  UserLoginPageState();
}

class  UserLoginPageState extends State<UserLoginPage> {
  LoginController _loginController = LoginController.getInstance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),

      body: Form(
        key: this._loginController.formKey,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: constraints.maxHeight * 0.2,
                left: constraints.maxWidth * 0.08,
                right: constraints.maxWidth * 0.08
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InputText(
                      _loginController.loginTextController,
                      label: 'Usuário',
                      hint: 'E-mail ou nome de usuário',
                      validator: (value) => this._loginController.validateUserInput(value),
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: InputText(
                      _loginController.passwordTextController,
                      label: 'Senha',
                      hint: 'Infome sua senha',
                      isHidden: true,
                      validator: (value) => this._loginController.validatePasswordInput(value),
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: 48,
                      child: RaisedButton(
                        child: Text('Entrar'),
                        onPressed: () {
                          this._loginController.actionEnterButton(context);
                        },
                      ),
                    ),
                  ),

                  //TODO: Implementar forma de realizar login com Google ou facebook
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: ButtonWithImage(
                  //     'Conectar usando o Google',
                  //     'assets/images/google-account.png',
                  //     () {
                  //       _loginController.navigateToCategoryPage(context);
                  //     }
                  //   )
                  // ),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: ButtonWithImage(
                  //     'Conectar usando o Facebook',
                  //     'assets/images/facebook-account.png',
                  //     () {
                  //     }
                  //   )
                  // ),

                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
