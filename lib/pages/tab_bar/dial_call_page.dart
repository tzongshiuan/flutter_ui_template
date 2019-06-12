import 'package:flutter/material.dart';
import 'package:flutter_ui_template/models/contact.dart';

List<Contact> dialledCallContacts = [
  Contact(fullName: 'Ranganadh', email: 'Ranganadh@example.com'),
  Contact(fullName: 'Karthik', email: 'Karthik@example.com'),
  Contact(fullName: 'Saranya', email: 'Saranya@example.com'),
  Contact(fullName: 'Mahesh', email: 'Mahesh@example.com'),
];

class DialledCallsPage extends StatefulWidget {
  @override
  _DialledCallsPageState createState() => _DialledCallsPageState();
}

class _DialledCallsPageState extends State<DialledCallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: dialledCallContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${dialledCallContacts[index].fullName}'),
                  subtitle: Text('${dialledCallContacts[index].email}'),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('${dialledCallContacts[index].fullName[0]}'),
                  ),
                  onTap: () => _onTapItem(context, dialledCallContacts[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _onTapItem(BuildContext context, Contact post) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(content: new Text("Tap on " + ' - ' + post.fullName)));
  }
}