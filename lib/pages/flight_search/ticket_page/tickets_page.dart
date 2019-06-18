import 'package:flutter/material.dart';
import 'package:flutter_ui_template/pages/flight_search/air_asia_bar.dart';
import 'package:flutter_ui_template/pages/flight_search/price_tab/flight_stop.dart';
import 'flight_stop_ticket.dart';
import 'ticket_card.dart';

class TicketsPage extends StatefulWidget {
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> with TickerProviderStateMixin {
  List<FlightStopTicket> stops = [
    new FlightStopTicket("Sahara", "SHE", "Macao", "MAC", "SE2341"),
    new FlightStopTicket("Macao", "MAC", "Cape Verde", "CAP", "KU2342"),
    new FlightStopTicket("Cape Verde", "CAP", "Ireland", "IRE", "KR3452"),
    new FlightStopTicket("Ireland", "IRE", "Sahara", "SHE", "MR4321"),
    new FlightStopTicket("Sahara", "SHE", "Macao", "MAC", "SE2341"),
    new FlightStopTicket("Macao", "MAC", "Cape Verde", "CAP", "KU2342"),
    new FlightStopTicket("Cape Verde", "CAP", "Ireland", "IRE", "KR3452"),
    new FlightStopTicket("Ireland", "IRE", "Sahara", "SHE", "MR4321"),
  ];

  AnimationController _cardEntranceAnimationController;
  List<Animation> _ticketAnimations;
  Animation _fabAnimation;

  @override
  void initState() {
    super.initState();
    _cardEntranceAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );

    _ticketAnimations = stops.map((stop) {
      int index = stops.indexOf(stop);
      double start = index * 0.05;
      double duration = 0.6;
      double end = duration + start;

      return Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
          parent: _cardEntranceAnimationController,
          curve: Interval(start, end, curve: Curves.decelerate),
        )
      );
    }).toList();

    _fabAnimation = CurvedAnimation(
      parent: _cardEntranceAnimationController,
      curve: Interval(0.7, 1.0, curve: Curves.decelerate),
    );

    _cardEntranceAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _cardEntranceAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AirAsiaBar(height: 180.0),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 64.0,
            child: SingleChildScrollView(
              child: Column(
                children: _buildTickets().toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Iterable<Widget> _buildTickets() {
    return stops.map((stop) {
      int index = stops.indexOf(stop);
      return AnimatedBuilder(
        animation: _cardEntranceAnimationController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: TicketCard(stop: stop),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0.0, _ticketAnimations[index].value),
            child: (child != null) ? child : Container(),
          );
        },
      );
    });
  }

  _buildFab() {
    return ScaleTransition(
      scale: _fabAnimation,
      child: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(Icons.fingerprint),
      ),
    );
  }
}