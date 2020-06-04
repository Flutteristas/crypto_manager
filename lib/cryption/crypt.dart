import 'package:crypt/crypt.dart';

class CryptFunction{

  String hashedPassword;
  String salted;

  String encrypt(String username, String password){

    salted = getSalt(username); //obtem salt utilizando o username

    
    hashedPassword = Crypt.sha256(password, salt: salted) as String;  //gera hash com salt

    return hashedPassword;

  }

  String getSalt(String username){
      return username.substring(0,1); //pega a primeira letra do usuario
  }
}