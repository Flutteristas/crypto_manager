import 'package:crypt/crypt.dart';

class CryptFunction{

  String salted;

  String encrypt(String username, String password){

    salted = getSalt(username); //obtem salt utilizando o username

    
    final hashedPassword = Crypt.sha256(password, salt: salted);  //gera hash com salt

    return hashedPassword.toString();

  }

  String getSalt(String username){
      return username.substring(0,1); //pega a primeira letra do usuario
  }
}