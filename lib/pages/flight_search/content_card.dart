import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'multicity_input.dart';
import 'price_tab/price_tab.dart';

class ContentCard extends StatefulWidget {
  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool showInput = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        length: 3,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Column(
              children: <Widget>[
                _buildTabBar(),
                _buildContentContainer(viewportConstraints),
              ],
            );
          },
        )
      ),
    );
  }

  Widget _buildTabBar({bool showFirstOption}) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          top: null,
          child: Container(
            height: 2.0,
            color: Color(0xFFEEEEEE),
          ),
        ),
        TabBar(
          tabs: <Widget>[
            Tab(text: "Flight"),
            Tab(text: "Train"),
            Tab(text: "Bus")
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        )
      ],
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 48.0,
          ),
          child: IntrinsicHeight(
            child: showInput
              ? _buildMultiCityTab()
              : PriceTab(
                  height: viewportConstraints.maxHeight - 48.0,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMultiCityTab() {
    return Column(
      children: <Widget>[
        MultiCityInput(),
//        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                showInput = false;
              });
            },
            child: Icon(Icons.timeline, size: 36.0),
            backgroundColor: Colors.red,
          ),
        )
      ],
    );
  }
}