import 'package:flutter/material.dart';
import 'package:flutter_ui_template/models/contact.dart';

List<Contact> receivedCallContacts = [
  Contact(fullName: 'Pratap Kumar', email: 'pratap@example.com'),
  Contact(fullName: 'Jagadeesh', email: 'Jagadeesh@example.com'),
  Contact(fullName: 'Srinivas', email: 'Srinivas@example.com'),
];

class ReceivedCallsPage extends StatefulWidget {
  @override
  _ReceivedCallsPageState createState() => _ReceivedCallsPageState();
}

class _ReceivedCallsPageState extends State<ReceivedCallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: receivedCallContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${receivedCallContacts[index].fullName}'),
                  subtitle: Text('${receivedCallContacts[index].email}'),
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('${receivedCallContacts[index].fullName[0]}')
                  ),
                  onTap: () => _onTapItem(context, receivedCallContacts[index]),
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