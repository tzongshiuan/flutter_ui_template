import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';
import 'package:flutter_ui_template/res/config/assets.dart';
import 'package:intl/intl.dart';

import 'tasks.dart';
import 'animated_fab.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

final Log _logger = new Log("timeline_screen");
class _TimelineScreenState extends State<TimelineScreen> {

  static const double _imageHeight = 256.0;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;

  @override
  void initState() {
    super.initState();
    listModel = ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(S.of(context).timeline_title),
//      ),
      body: Stack(
        children: <Widget>[
          _buildClipImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildTimeline(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildClipImage() {
    return ClipPath(
      clipper: DiagonalClipper(),
      child: Image.asset(
        Assets.birdImage,
        fit: BoxFit.cover,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: Color.fromARGB(100, 20, 10, 40),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.menu, size: 32.0, color: Colors.white),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                  S.of(context).timeline_title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300
                ),
              ),
            ),
          ),
          Icon(Icons.linear_scale, color: Colors.white)
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: AssetImage(Assets.candidPhotoImage),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  S.of(context).profile_name,
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  S.of(context).profile_job_title,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Padding(
      padding: const EdgeInsets.only(top: _imageHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTasksHeader(),
          _buildTasksList()
        ],
      ),
    );
  }

  Widget _buildTasksHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'My Tasks',
            style: TextStyle(fontSize: 34.0),
          ),
          Text(
            _getCurrentDate(),
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          )
        ],
      ),
    );
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formatDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return formatDate;
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: AnimatedList(
        initialItemCount: listModel.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
//      child: new ListView(
//        children: tasks.map((task) => new TaskRow(task: task)).toList(),
//      ),
    );
  }

  Widget _buildTimeline() {
    return Positioned(
      top: _imageHeight - 20.0,
      bottom: 0.0,
      left: 32.0,
      child: Container(
        width: 1.0,
        color: Colors.grey[500],
      ),
    );
  }

  /// Fab = FloatingActionButton
  Widget _buildFab() {
    return Positioned(
      top: _imageHeight - 100.0,
      right: -40.0,
      child: AnimatedFab(
        onClick: _changeFilterState,
      ),
    );
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;

    int removeCount = 0;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(tasks.indexOf(task) - removeCount);
        removeCount++;
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ListModel {
  ListModel(this.listKey, items): this.items = List.of(items);

  final GlobalKey<AnimatedListState> listKey;
  final List<Task> items;

  AnimatedListState get _animatedListState => listKey.currentState;

  void insert(int index, Task item) {
    _logger.fine(message: "insert index: $index");

    items.insert(index, item);
    _animatedListState.insertItem(index);
  }

  Task removeAt(int index) {
    _logger.fine(message: "remove index: $index");

    final Task removeItem = items.removeAt(index);

    if (removeItem != null) {
      _animatedListState.removeItem(index, (context, animation) =>
        TaskRow(
          task: removeItem,
          animation: animation,
        ),
        duration: Duration(milliseconds: (150 + 150*(index/length)).toInt())
      );
    }

    return removeItem;
  }

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}