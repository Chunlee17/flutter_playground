import 'package:flutter/material.dart';

class DraggableSrollableSheetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraggableScrollableSheet'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Hello Flutter"),
            subtitle: Text("Hi my name is Chunlee"),
            leading: CircleAvatar(child: Text("T")),
          ),
          Expanded(
            child: DraggableScrollableSheet(
              minChildSize: 0.1,
              maxChildSize: 1.0,
              initialChildSize: 0.1,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Card(
                  color: Colors.blue[100],
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
