import 'dart:convert';
import 'dart:math';

class CryptoRandomString{

  static final Random _random = Random.secure();

  String createCryptoRandomString([int length = 6]){
    var values = List<int>.generate(length, (i) => _random.nextInt(128));

    return base64Url.encode(values);
  }
}