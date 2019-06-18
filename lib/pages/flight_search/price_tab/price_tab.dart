import 'package:flutter/material.dart';

import 'animated_plane_icon.dart';
import 'animated_dot.dart';
import 'flight_stop.dart';
import 'flight_stop_card.dart';
import 'package:flutter_ui_template/pages/flight_search/fade_route.dart';
import 'package:flutter_ui_template/pages/flight_search/ticket_page/tickets_page.dart';

class PriceTab extends StatefulWidget {
  final double height;

  const PriceTab({Key key, this.height}): super(key: key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {

  final List<GlobalKey<FlightStopCardState>> _stopKeys = [];
  AnimationController _fabAnimationController;
  Animation _fabAnimation;

  final List<FlightStop> _flightStops = [
    FlightStop("JFK", "ORY", "JUN 05", "6h 25m", "\$851", "9:26 am - 3:43 pm"),
    FlightStop("MRG", "FTB", "JUN 20", "6h 25m", "\$532", "9:26 am - 3:43 pm"),
    FlightStop("ERT", "TVS", "JUN 20", "6h 25m", "\$718", "9:26 am - 3:43 pm"),
    FlightStop("KKR", "RTY", "JUN 20", "6h 25m", "\$663", "9:26 am - 3:43 pm"),
  ];
  final double _cardHeight = 80.0;

  AnimationController _planeSizeAnimationController;
  Animation _planeSizeAnimation;

  AnimationController _planeTravelController;
  Animation _planeTravelAnimation;

  AnimationController _dotsAnimationController;
  List<Animation<double>> _dotPositions = [];

  final double _initialPlanePaddingBottom = 16.0;
  final double _minPlanePaddingTop = 16.0;

  double get _planeTopPadding => _minPlanePaddingTop + (1 - _planeTravelAnimation.value) * _maxPlaneTopPadding;
  double get _maxPlaneTopPadding  => widget.height - _initialPlanePaddingBottom - _planeSize;
  double get _planeSize => _planeSizeAnimation.value;

  void _initSizeAnimations() {
    _planeSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          _planeTravelController.forward();
        });

        Future.delayed(Duration(milliseconds: 700), () {
          _dotsAnimationController.forward();
        });
      }
    });

    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0).animate(
      CurvedAnimation(
        parent: _planeSizeAnimationController,
        curve: Curves.easeOut
      )
    );
  }

  void _initPlaneTravelAnimations() {
    _planeTravelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _planeTravelAnimation = CurvedAnimation(
      parent: _planeTravelController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _initDotAnimations() {
    _dotsAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animateFlightStopCards().then((_) => _animateFab());
      }
    });

    final double slideDurationInterval = 0.4;
    final double slideDelayInterval = 0.2;
    double startingMarginTop = widget.height;
    double minMarginTop = _minPlanePaddingTop + _planeSize + 0.5 * (0.8 * _cardHeight);

    for (int i = 0; i < _flightStops.length; i++) {
      final start = slideDelayInterval * i;
      final end = start + slideDurationInterval;

      double finalMarginTop = minMarginTop + i * (0.8 * _cardHeight);
      Animation<double> animation = Tween(
        begin: startingMarginTop,
        end: finalMarginTop,
      ).animate(
        CurvedAnimation(
          parent: _dotsAnimationController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
      _dotPositions.add(animation);
    }
  }

  Future _animateFlightStopCards() async {
    return Future.forEach(_stopKeys, (GlobalKey<FlightStopCardState> stopKey) {
      return Future.delayed(Duration(milliseconds: 250), () {
        stopKey.currentState.runAnimation();
      });
    });
  }

  void _initFabAnimationController() {
    _fabAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _fabAnimation = new CurvedAnimation(
        parent: _fabAnimationController, curve: Curves.easeOut);
  }

  void _animateFab() {
    _fabAnimationController.forward();
  }

  @override
  void initState() {
    _initSizeAnimations();
    _initPlaneTravelAnimations();
    _initDotAnimations();
    _initFabAnimationController();
    _flightStops.forEach((stop) {
      _stopKeys.add(GlobalKey<FlightStopCardState>());
    });
    _planeSizeAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _planeSizeAnimationController.dispose();
    _planeTravelController.dispose();
    _dotsAnimationController.dispose();
    _fabAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildPlane(),
        ]..addAll(_flightStops.map(_buildStopCard))
          ..addAll(_flightStops.map(_mapFlightStopToDot))
          ..add(_buildFab()),
      ),
    );
  }

  Widget _buildStopCard(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin = _dotPositions[index].value - 0.5 * (FlightStopCard.height - AnimatedDot.size);
    bool isLeft = index.isOdd;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isLeft ? Container() : Expanded(child: Container()),
            Expanded(
              child: FlightStopCard(key: _stopKeys[index], flightStop: stop, isLeft: isLeft),
            ),
            !isLeft ? Container() : Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    return Positioned(
      bottom: 16.0,
      child: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(FadeRoute(builder: (context) => TicketsPage()));
          },
          child: Icon(Icons.check, size: 36.0),
        ),
      ),
    );
  }

  Widget _mapFlightStopToDot(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    bool isStartOrEnd = (index == 0) || (index == (_flightStops.length - 1));
    Color color = isStartOrEnd ? Colors.red : Colors.green;

    return AnimatedDot(
      animation: _dotPositions[index],
      color: color,
    );
  }

  Widget _buildPlane() {
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      child: Column(
        children: <Widget>[
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
          Container(
            width: 2.0,
            height: 250.0,
            color: Color.fromARGB(255, 200, 200, 200),
          )
        ],
      ),
      builder: (context, child) {
        return Positioned(
          top: _planeTopPadding,
          child: child,
        );
      },
    );
  }
}