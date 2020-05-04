import 'package:flutter/material.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:flutter_playground/models/contact.dart';
import 'package:flutter_playground/widgets/contact_title.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class HiveDatabase extends StatefulWidget {
  @override
  _HiveDatabaseState createState() => _HiveDatabaseState();
}

class _HiveDatabaseState extends State<HiveDatabase> {
  Future<Box> contactBox;
  @override
  void initState() {
    contactBox = Hive.openBox(ContactBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Contact Database"),
        actions: <Widget>[
          SmallIconButton(
            icon: Icon(Icons.delete),
            onTap: () => Hive.box(ContactBox).clear(),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: contactBox,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ValueListenableBuilder<Box>(
                    valueListenable: Hive.box(ContactBox).listenable(),
                    builder: (context, data, child) {
                      if (data.values.length <= 0) {
                        return Center(child: Text("No Contact found!"));
                      }
                      return ListView.separated(
                        separatorBuilder: (c, i) => Divider(height: 0.2),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final contact = data.getAt(index);
                          return ContactTile(contact: contact, index: index);
                        },
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Divider(),
          AddContactPage(),
        ],
      ),
    );
  }
}

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _age;

  void addContact(Contact contact) {
    final contactsBox = Hive.box(ContactBox);
    contactsBox.add(contact);
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (value) => _name = value,
                  ),
                ),
                UIHelper.horizontalSpace(),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _age = value,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(),
            RaisedButton(
              child: Text('Add New Contact'),
              onPressed: () {
                _formKey.currentState.save();
                final newContact = Contact(_name, int.parse(_age));
                addContact(newContact);
              },
            ),
          ],
        ),
      ),
    );
  }
}
