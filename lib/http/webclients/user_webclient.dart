import 'dart:convert';

import 'package:house_party/http/webclient.dart';
import 'package:house_party/models/user.dart';
import 'package:http/http.dart';

class UserWebClient {

  /// Envia os dados do usuário para serem salvos
  Future<User> saveUser(User user) async {
    Response response = await client.post(
      '$url/cliente/cadastro',
      body: jsonEncode(user.toMap()),
      headers:
      {
        "Accept": "application/json",
        "content-type": "application/json"
      }
    ).timeout(Duration(seconds: 30));
    Map<String, dynamic> responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    if(response.statusCode == 201) {
      return User.fromJson(responseJson);
    } else {
      return null;
    }
  }

  /// Valida se o usuário e senha informados estão corretos
  Future<bool> authentic(String userName, String password) async {
    Response response = await client.get(
        '$url/cliente/autenticacao?usuario=$userName&senha=$password'
    ).timeout(Duration(seconds: 30));

    return response.statusCode == 202 ? true : false;
  }

  /// Retorna um usuário caso o nome se usuário e senha estejam corretos
  Future<User> loginWithUserName(String userName, String password) async {
    if(await authentic(userName, password)) {
      return await findByUserName(userName);
    }
    return null;
  }

  /// Retorna um usuário caso o e-mail e senha estejam corretos
  Future<User> loginWithEmail(String email, String password) async {
    User user = await findByEmail(email);
    if (await authentic(user.userName, password)) {
      return user;
    }
    return null;
  }

  /// Busca um usuário pelo nome de usuário
  Future<User> findByUserName(String username) async {
    Response response = await client.get(
      '$url/usuario?usuario=$username'
    ).timeout(Duration(seconds: 30));

    Map<String, dynamic> respondeJson = jsonDecode(utf8.decode(response.bodyBytes));
    return User.fromJson(respondeJson);
  }

  /// Busca um usuário pelo e-mail
  Future<User> findByEmail(String email) async {
    Response response = await client.get(
      '$url/cliente/email/$email'
    ).timeout(Duration(seconds: 30));
    Map<String, dynamic> responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return User.fromJson(responseJson);
  }
}
