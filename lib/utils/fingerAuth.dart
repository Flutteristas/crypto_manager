import 'package:local_auth/local_auth.dart';

class FingerPrintAuthentication {

  Future<bool> checkIfBiometricIsAvailable() async{
    bool canCheckBiometrics = await LocalAuthentication().canCheckBiometrics;
    return Future<bool>.value(canCheckBiometrics);
  }

  Future<bool> authenticateUserWithFingerPrint() async{
    bool didAuthenticate = false;

    List<BiometricType> availableBiometrics = await LocalAuthentication().getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.fingerprint)){
      didAuthenticate = await LocalAuthentication().authenticateWithBiometrics(
        localizedReason: 'Please authenticate to show entry settings'
      );
    }   
    
    return Future<bool>.value(didAuthenticate); 
  }

}