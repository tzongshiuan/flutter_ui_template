import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flight_stop.dart';


class FlightStopCard extends StatefulWidget {
  final FlightStop flightStop;
  final bool isLeft;

  static const double height = 80.0;
  static const double width = 140.0;

  const FlightStopCard({Key key, @required this.flightStop, @required this.isLeft})
    : super(key: key);

  @override
  FlightStopCardState createState() => FlightStopCardState();
}

class FlightStopCardState extends State<FlightStopCard> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _cardSizeAnimation;
  Animation<double> _durationPositionAnimation;
  Animation<double> _airportsPositionAnimation;
  Animation<double> _datePositionAnimation;
  Animation<double> _pricePositionAnimation;
  Animation<double> _fromToPositionAnimation;
  Animation<double> _lineAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600)
    );

    _cardSizeAnimation = new CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.9, curve: ElasticOutCurve(0.8)));

    _durationPositionAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.05, 0.95, curve: new ElasticOutCurve(0.95)));
    _airportsPositionAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.1, 1.0, curve: new ElasticOutCurve(0.95)));
    _datePositionAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.1, 0.8, curve: new ElasticOutCurve(0.95)));
    _pricePositionAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.0, 0.9, curve: new ElasticOutCurve(0.95)));
    _fromToPositionAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.1, 0.95, curve: new ElasticOutCurve(0.95)));
    _lineAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.0, 0.2, curve: Curves.linear));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void runAnimation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FlightStopCard.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              _buildLine(),
              _buildCard(),
              _buildDurationText(),
              _buildAirportNamesText(),
              _buildDateText(),
              _buildPriceText(),
              _buildFromToTimeText(),
            ],
          );
        }
      ),
    );
  }

  double get maxWidth {
    RenderBox renderBox = context.findRenderObject();
    BoxConstraints constraints = renderBox?.constraints;
    double maxWidth = constraints?.maxWidth ?? 0.0;
    return maxWidth;
  }

  double getMarginBottom(double animationValue) {
    double minBottomMargin = 8.0;
    double bottomMargin = minBottomMargin + (1 - animationValue) * minBottomMargin;
    return bottomMargin;
  }

  double getMarginTop(double animationValue) {
    double minMarginTop = 8.0;
    double marginTop = minMarginTop + (1 - animationValue) * FlightStopCard.height * 0.5;
    return marginTop;
  }

  double getMarginLeft(double animationValue) {
    return getMarginHorizontal(animationValue, true);
  }

  double getMarginRight(double animationValue) {
    return getMarginHorizontal(animationValue, false);
  }

  double getMarginHorizontal(double animationValue, bool isTextLeft) {
    if (isTextLeft == widget.isLeft) {
      double minHorizontalMargin = 16.0;
      double maxHorizontalMargin = maxWidth - minHorizontalMargin;
      double horizontalMargin = minHorizontalMargin + (1 - animationValue) * maxHorizontalMargin;
      return horizontalMargin;
    } else {
      double maxHorizontalMargin = maxWidth - FlightStopCard.width;
      double horizontalMargin = animationValue * maxHorizontalMargin;
      return horizontalMargin;
    }
  }

  Widget _buildLine() {
    double animationValue = _lineAnimation.value;

    double maxLength = maxWidth - FlightStopCard.width;
    if (maxLength < 0.0) {
      maxLength = 0.0;
    }

    return Align(
      alignment: widget.isLeft ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: 2.0,
        width: maxLength * animationValue,
        color: Color.fromARGB(255, 200, 200, 200),
      ),
    );
  }

  Positioned _buildCard() {
    double animationValue = _cardSizeAnimation.value;
    double minOuterMargin  = 8.0;
    double outerMargin = minOuterMargin + (1 - animationValue) * maxWidth;

    return Positioned(
      right: widget.isLeft ? null : outerMargin,
      left: widget.isLeft ? outerMargin : null,
      child: Transform.scale(
        scale: animationValue,
        child: Container(
          width: FlightStopCard.width,
          height: FlightStopCard.height,
          child: Card(
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Positioned _buildDurationText() {
    double animationValue = _durationPositionAnimation.value;

    return Positioned(
      top: getMarginTop(animationValue),
      right: getMarginRight(animationValue),
      child: Text(
        widget.flightStop.duration,
        style: TextStyle(
          fontSize: 10.0 * animationValue,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned _buildAirportNamesText() {
    double animationValue = _airportsPositionAnimation.value;
    return Positioned(
      top: getMarginTop(animationValue),
      left: getMarginLeft(animationValue),
      child: Text(
        "${widget.flightStop.from} \u00B7 ${widget.flightStop.to}",
        style: TextStyle(
          fontSize: 14.0 * animationValue,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned _buildDateText() {
    double animationValue = _datePositionAnimation.value;
    return Positioned(
      left: getMarginLeft(animationValue),
      child: Text(
        "${widget.flightStop.date}",
        style: new TextStyle(
          fontSize: 14.0 * animationValue,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned _buildPriceText() {
    double animationValue = _pricePositionAnimation.value;
    return Positioned(
      right: getMarginRight(animationValue),
      child: Text(
        "${widget.flightStop.price}",
        style: new TextStyle(
            fontSize: 16.0 * animationValue, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Positioned _buildFromToTimeText() {
    double animationValue = _fromToPositionAnimation.value;
    return Positioned(
      left: getMarginLeft(animationValue),
      bottom: getMarginBottom(animationValue),
      child: Text(
        "${widget.flightStop.fromToTime}",
        style: new TextStyle(
            fontSize: 12.0 * animationValue, color: Colors.grey, fontWeight: FontWeight.w500),
      ),
    );
  }
}