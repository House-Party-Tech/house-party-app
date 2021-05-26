import 'package:flutter/material.dart';
import 'package:house_party/database/dao/user_dao.dart';
import 'package:house_party/http/webclients/user_webclient.dart';
import 'package:house_party/models/address.dart';
import 'package:house_party/models/user.dart';
import 'package:intl/intl.dart';

class RegisterUserController {
  
  static RegisterUserController _instance = RegisterUserController._();
  final UserWebClient _userWebClient = UserWebClient();
  final UserDAO _userDAO = UserDAO();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameInputController = TextEditingController();
  TextEditingController _surnameInputController = TextEditingController();
  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();
  TextEditingController _repeatPasswordInputController = TextEditingController();
  TextEditingController _streetAddressInputController = TextEditingController();
  TextEditingController _numberAddressInputController = TextEditingController();
  TextEditingController _neighborhoodAddressInputController = TextEditingController();
  TextEditingController _stateAddressInputController = TextEditingController();
  TextEditingController _complementAddressInputController = TextEditingController();
  TextEditingController _numberPhoneInputController = TextEditingController();
  TextEditingController _cpfInputController = TextEditingController();
  TextEditingController _cityInputController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();

  RegisterUserController._();

  static get instance => _instance;

  navigateToCategoryPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/category', (route) => false);
  }

  User createUser() {
    return User(
      name: nameInputController.text,
      cpf: cpfInputController.text,
      email: emailInputController.text,
      password: passwordInputController.text,
      userName: usernameController.text,
      phone: numberPhoneInputController.text,
      dateOfBirth: DateFormat('dd/MM/y').parse(dateOfBirthController.text),
      address: Address(
        cep: '00000000',
        street: streetAddressInputController.text,
        number: int.tryParse(numberAddressInputController.text),
        neighborhood: neighborhoodAddressInputController.text,
        city: cityInputController.text,
      )
    );
  }

  void registerActionButton(BuildContext context) async {
    if (this.formKey.currentState.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator())
      );
      User user = createUser();
      String responseBody = await userWebClient.saveUser(user);
      if (responseBody == 'Salvo com sucesso!') {
        userDAO.save(user);
        Navigator.pop(context);
        navigateToCategoryPage(context);
      } else {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('$responseBody'),
            backgroundColor: Colors.red[900],
          )
        );
      }
    }
  }

  validateEmptyInput(String value) {
    if (value.isEmpty) {
      return 'Este campo é obrigatório';
    }
  }

  validateNameInput(String value) {
    if(value.length < 2) {
      return 'Informe seu nome';
    }
  }

  validateSurnameInput(String value) {
    if(value.length < 3) {
      return 'Informe seu sobrenome';
    }
  }

  validateCpfInput(String value) {
    if(value.length < 11) {
      return 'Informe um CPF válido';
    }
  }

  validatePhoneInput(String value) {
    if(value.length < 14) {
      return 'Informe um número de celular válido';
    }
  }

  validateEmailInput(String value) {
    if(value.isEmpty || !value.contains('@') || !value.contains('.')) {
      return 'Informe um e-mail válido';
    }
  }

  validateUsernameInput(String value) {
    if(value.contains('@')) {
      return 'O nome de usuário não pode conter \'@\'';
    } else if(value.length < 3) {
      return 'Nome de usuário inválido';
    } else if(value.contains(' ')) {
      return 'Nome de usuário não pode conter espaços';
    }
  }

  validatePasswordInput(String value) {
    if(value.length < 6) {
      return 'Sua senha deve ter no mínimo 6 caracteres';
    }
  }

  validateRepeatPasswordInput(String value) {
    if(value != passwordInputController.text) {
      return 'As senhas não conferem';
    }
  }

  Future<void> selectDateAction(BuildContext context) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now()
    );
    if (date != null) {
      this.dateOfBirthController.text = DateFormat(
          'dd/MM/y'
      ).format(date);
    }
  }

  GlobalKey<FormState> get formKey => _formKey;
  UserWebClient get userWebClient => _userWebClient;
  UserDAO get userDAO => _userDAO;
  TextEditingController get cityInputController => _cityInputController;
  TextEditingController get cpfInputController => _cpfInputController;
  TextEditingController get numberPhoneInputController => _numberPhoneInputController;
  TextEditingController get complementAddressInputController => _complementAddressInputController;
  TextEditingController get stateAddressInputController => _stateAddressInputController;
  TextEditingController get neighborhoodAddressInputController => _neighborhoodAddressInputController;
  TextEditingController get numberAddressInputController => _numberAddressInputController;
  TextEditingController get streetAddressInputController => _streetAddressInputController;
  TextEditingController get repeatPasswordInputController => _repeatPasswordInputController;
  TextEditingController get passwordInputController => _passwordInputController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get emailInputController => _emailInputController;
  TextEditingController get surnameInputController => _surnameInputController;
  TextEditingController get nameInputController => _nameInputController;
  TextEditingController get dateOfBirthController => _dateOfBirthController;
}
