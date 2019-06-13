import 'package:flutter/material.dart';

class Task {
  final String name;
  final String category;
  final String time;
  final Color color;
  final bool completed;

  Task({this.name, this.category, this.time, this.color, this.completed});
}

List<Task> tasks = [
  Task(
    name: "Catch up with Brian",
    category: "Mobile Project",
    time: "5pm",
    color: Colors.orange,
    completed: false
  ),
  new Task(
    name: "Make new icons",
    category: "Web App",
    time: "3pm",
    color: Colors.cyan,
    completed: true),
  new Task(
    name: "Design explorations",
    category: "Company Website",
    time: "2pm",
    color: Colors.pink,
    completed: false),
  new Task(
    name: "Lunch with Mary",
    category: "Grill House",
    time: "12pm",
    color: Colors.cyan,
    completed: true),
  new Task(
    name: "Teem Meeting",
    category: "Hangouts",
    time: "10am",
    color: Colors.cyan,
    completed: true),
];

class TaskRow extends StatefulWidget {
  final Task task;
  final double dotSize = 12.0;
  final Animation<double> animation;

  TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  _TaskRowState createState() => _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: SizeTransition(
        sizeFactor: widget.animation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
                child: Container(
                  height: widget.dotSize,
                  width: widget.dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: widget.task.color,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.task.name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      widget.task.category,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  widget.task.time,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}