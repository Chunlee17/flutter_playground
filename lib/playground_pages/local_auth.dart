import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenthicationDemo extends StatefulWidget {
  @override
  _LocalAuthenthicationDemoState createState() => _LocalAuthenthicationDemoState();
}

class _LocalAuthenthicationDemoState extends State<LocalAuthenthicationDemo> {
  final LocalAuthentication auth = LocalAuthentication();

  bool _canCheckBiometrics;

  List<BiometricType> _availableBiometrics;

  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Can check biometrics: $_canCheckBiometrics\n'),
            RaisedButton(
              child: const Text('Check biometrics'),
              onPressed: _checkBiometrics,
            ),
            Text('Available biometrics: $_availableBiometrics\n'),
            RaisedButton(
              child: const Text('Get available biometrics'),
              onPressed: _getAvailableBiometrics,
            ),
            Text('Current State: $_authorized\n'),
            RaisedButton(
              child: const Text('Authenticate'),
              onPressed: _authenticate,
            )
          ],
        ),
      ),
    ));
  }

  Widget buildSection(String title, String button, Function onPressed) {
    return Column(
      children: <Widget>[],
    );
  }
}
