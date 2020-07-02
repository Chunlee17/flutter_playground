import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class EasyLocalizationPackageDemo extends StatefulWidget {
  EasyLocalizationPackageDemo({Key key}) : super(key: key);

  @override
  _EasyLocalizationPackageDemoState createState() =>
      _EasyLocalizationPackageDemoState();
}

class _EasyLocalizationPackageDemoState
    extends State<EasyLocalizationPackageDemo> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("title").tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Status: ${tr('status')}"),
            JinWidget.verticalSpace(32),
            Text("Message: " + tr('message', args: ["This value"])),
            JinWidget.verticalSpace(32),
            Text("Name: ${tr('data.name')}"),
            JinWidget.verticalSpace(32),
            Text("Age: ${tr('data.age')}"),
            JinWidget.verticalSpace(32),
            Text('amount').tr(context: context),
            JinWidget.verticalSpace(32),
            Text('horse').tr(context: context, gender: 'female'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (data.locale == Locale('en', 'US'))
            data.locale = Locale('km', 'KH');
          else
            data.locale = Locale('en', 'US');
        },
        child: Icon(Icons.language),
      ),
    );
  }
}
