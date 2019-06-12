import 'package:flutter/material.dart';
import 'package:flutter_ui_template/models/contact.dart';

List<Contact> missedCallContacts = [
  Contact(fullName: 'Pratap Kumar', email: 'pratap@example.com'),
  Contact(fullName: 'Jagadeesh', email: 'Jagadeesh@example.com'),
  Contact(fullName: 'Srinivas', email: 'Srinivas@example.com'),
  Contact(fullName: 'Narendra', email: 'Narendra@example.com'),
  Contact(fullName: 'Sravan ', email: 'Sravan@example.com'),
  Contact(fullName: 'Ranganadh', email: 'Ranganadh@example.com'),
  Contact(fullName: 'Karthik', email: 'Karthik@example.com'),
  Contact(fullName: 'Saranya', email: 'Saranya@example.com'),
  Contact(fullName: 'Mahesh', email: 'Mahesh@example.com'),
];

class MissedCallsPage extends StatefulWidget {
  @override
  _MissedCallsPageState createState() => _MissedCallsPageState();
}

class _MissedCallsPageState extends State<MissedCallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: missedCallContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${missedCallContacts[index].fullName}'),
                  subtitle: Text('${missedCallContacts[index].email}'),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('${missedCallContacts[index].fullName[0]}'),
                  ),
                  onTap: () => _onTapItem(context, missedCallContacts[index]),
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