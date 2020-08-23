import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInExample extends StatefulWidget {
  @override
  _AppleSignInExampleState createState() => _AppleSignInExampleState();
}

class _AppleSignInExampleState extends State<AppleSignInExample>
    with BasicPage {
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SignInWithAppleButton(
          onPressed: () async {
            try {
              final credential = await SignInWithApple.getAppleIDCredential(
                scopes: [],
              );

              print("success");

              print(credential);
            } catch (e) {
              print(e.toString());
            }

            // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
            // after they have been validated with Apple (see `Integration` section for more information on how to do this)
          },
        ),
      ),
    );
  }

  @override
  String appBarTitle() {
    return "Apple Sign in example";
  }
}
