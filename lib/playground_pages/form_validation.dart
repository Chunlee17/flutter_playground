import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FormValidation extends StatefulWidget {
  @override
  _FormValidationState createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> with BasicPage {
  final formKey = GlobalKey<FormState>();

  void onValidateForm() {
    formKey.currentState.validate();
  }

  @override
  Widget body(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
        children: [
          TextFormField(
            //autofillHints: [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            autovalidate: true,
            validator: (value) => value.isNotEmpty ? null : "Please input value",
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Email",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: JinWidget.radius(),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.4),
            ),
          ),
          SpaceY(12),
          TextFormField(
            //autofillHints: [AutofillHints.password],
            keyboardType: TextInputType.text,
            autovalidate: true,
            validator: (value) => value.isNotEmpty ? null : "Please input value",
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_lock),
              hintText: "Password",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: JinWidget.radius(),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.4),
            ),
          ),
          ActionButton(
            onPressed: onValidateForm,
            child: Text("validate"),
          ),
        ],
      ),
    );
  }

  @override
  String appBarTitle() {
    return "Form validation";
  }
}
