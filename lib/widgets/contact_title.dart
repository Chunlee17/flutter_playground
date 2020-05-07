import 'package:flutter/material.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:flutter_playground/models/contact.dart';
import 'package:hive/hive.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:toast/toast.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final int index;

  const ContactTile({Key key, this.contact, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(contact.name.firstUpperCase()[0],
            style: TextStyle(fontSize: 16)),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.age.toString()),
      onLongPress: () {
        Box box = Hive.box(ContactBox);
        var con = box.values.firstWhere((c) {
          return c.name == contact.name;
        });
        int index = box.values.toList().indexOf(con);
        box.deleteAt(index);
      },
      trailing: SmallIconButton(
        icon: Icon(Icons.edit),
        onTap: () async {
          try {
            Box box = Hive.box(ContactBox);
            await box.putAt(index, Contact("Chunlee Edit", 32));
          } catch (e) {
            Toast.show(e.toString(), context);
          }
        },
      ),
    );
  }
}
