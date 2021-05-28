
import 'package:flutter/material.dart';
import 'package:house_party/components/input_text.dart';
import 'package:house_party/components/outlined_text.dart';
import 'package:house_party/pages/register_user/register_user_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  RegisterUserController _registerController = RegisterUserController.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: OutlinedText(
          'House Party',
          fontSize: 24,
        ),
      ),

      body: Form(
        key: this._registerController.formKey,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(8),

              child: Column(
                children: [

                  InputText(
                    this._registerController.nameInputController,
                    label: 'Nome',
                    hint: 'Informe seu nome',
                    textCapitalization: TextCapitalization.words,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateNameInput(value)
                  ),

                  InputText(
                    this._registerController.surnameInputController,
                    label: 'Sobrenome',
                    hint: 'Informe seu sobrenome',
                    textCapitalization: TextCapitalization.words,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateSurnameInput(value)
                  ),

                  InputText(
                    this._registerController.cpfInputController,
                    label: 'CPF',
                    hint: '000.000.000-00',
                    mask: MaskTextInputFormatter(mask: '###.###.###-##'),
                    keyboardType: TextInputType.number,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateCpfInput(value),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Data de nascimento',
                        hintText: '25/12/1997',
                      ),
                      controller: this._registerController.dateOfBirthController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [MaskTextInputFormatter(mask: '##/##/####')],
                      readOnly: true,
                      onTap: () async {
                        await this._registerController.selectDateAction(context);
                        setState(() {});
                      },
                    ),
                  ),

                  InputText(
                    this._registerController.numberPhoneInputController,
                    label: 'Celular',
                    hint: '(11)99999-9999',
                    keyboardType: TextInputType.phone,
                    mask: MaskTextInputFormatter(mask: '(##)#####-####'),
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validatePhoneInput(value),
                  ),

                  InputText(
                    this._registerController.emailInputController,
                    label: 'E-mail',
                    hint: 'exemplo@houseparty.com',
                    keyboardType: TextInputType.emailAddress,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateEmailInput(value),
                  ),

                  InputText(
                    this._registerController.usernameController,
                    label: 'Nome de usuário',
                    hint: 'house_party',
                    keyboardType: TextInputType.emailAddress,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateUsernameInput(value),
                  ),

                  InputText(
                    this._registerController.passwordInputController,
                    label: 'Senha',
                    hint: 'Informe sua senha',
                    isHidden: true,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validatePasswordInput(value),
                  ),

                  InputText(
                    this._registerController.repeatPasswordInputController,
                    label: 'Confirme a senha',
                    hint: 'Repita a senha',
                    isHidden: true,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateRepeatPasswordInput(value),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth * 0.7,
                          child: InputText(
                            this._registerController.streetAddressInputController,
                            textCapitalization: TextCapitalization.words,
                            label: 'Logradouro',
                            hint: 'Rua Vergueiro',
                            validator: (value) => this._registerController.validateEmptyInput(value),
                          ),
                        ),

                        SizedBox(
                          width: constraint.maxWidth * 0.2,
                          child: InputText(
                            this._registerController.numberAddressInputController,
                            label: 'Número',
                            hint: '831',
                            keyboardType: TextInputType.number,
                            validator: (value) => this._registerController.validateEmptyInput(value),
                          ),
                        ),
                      ],
                    ),
                  ),

                  InputText(
                    this._registerController.complementAddressInputController,
                    label: 'Complemento',
                    textCapitalization: TextCapitalization.words,
                    hint: 'Apto, casa 1, fundos...',
                    horizontalMargin: 8,
                    verticalMargin: 8,
                  ),

                  InputText(
                    this._registerController.neighborhoodAddressInputController,
                    label: 'Bairro',
                    hint: 'Liberdade',
                    textCapitalization: TextCapitalization.words,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateEmptyInput(value),
                  ),

                  InputText(
                    this._registerController.cityInputController,
                    label: 'Cidade',
                    hint: 'São Paulo',
                    textCapitalization: TextCapitalization.words,
                    horizontalMargin: 8,
                    verticalMargin: 8,
                    validator: (value) => this._registerController.validateEmptyInput(value),
                  ),


                  SizedBox(
                    width: constraint.maxWidth - 32,
                    child: RaisedButton(
                      child: Text(
                        'Cadastrar'
                      ),
                      onPressed: () {
                        this._registerController.registerActionButton(context);
                      }
                    ),
                  ),

                ],
              ),
            );
          }
        ),
      ),
      
    );
  }
}
