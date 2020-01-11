import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trains/ui/background/screens/searchingscreen.dart';

class BackPanelThread extends StatefulWidget {
  @override
  _BackPanelThreadState createState() => _BackPanelThreadState();
}

class _BackPanelThreadState extends State<BackPanelThread> {
  final _stopsLeftController = BehaviorSubject<int>();
  final _minutesLeftController = BehaviorSubject<int>();

  @override
  void dispose() {
    _stopsLeftController.close();
    _minutesLeftController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
              return SearchingScreen();

    // return StreamBuilder<Thread>(
    //     stream: trainsBloc.threadStream,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting ||
    //           !snapshot.hasData) 
    //           return SearchingScreen();
    //       final thread = snapshot.data;
    //       return Stack(
    //         children: <Widget>[
    //           BackPanelThreadStopsList(
    //             thread: thread,
    //             stopsLeft: _stopsLeftController.sink,
    //             minutesLeft: _minutesLeftController.sink,
    //           ),
    //           Positioned(
    //             top: 0.0,
    //             left: 0.0,
    //             right: 0.0,
    //             child: BackPanelThreadTitle(
    //               thread: thread,
    //               stopsLeft: _stopsLeftController.stream,
    //               minutesLeft: _minutesLeftController.stream,
    //             ),
    //           ),
    //         ],
    //       );
    //     });
  }
}
