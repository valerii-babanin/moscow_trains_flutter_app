import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';
import 'package:trains/data/classes/station.dart';

//Suggestions will be reworked soon

class PersistentSuggestionsBloc {
  final BehaviorSubject<Station> fromStation;
  final BehaviorSubject<Station> toStation;
  final BehaviorSubject<List<Station>> allStations;

  final fromList = BehaviorSubject.seeded(List<Station>());
  final toList = BehaviorSubject.seeded(List<Station>());

  final fromPosition = BehaviorSubject<Map<String, int>>();
  final toPosition = BehaviorSubject<Map<String, int>>();

  PersistentSuggestionsBloc(
      {@required this.allStations,
      @required this.fromStation,
      @required this.toStation}) {
    allStations.listen((list) => select(list));
    fromStation.listen((station) {
      if (!fromList.value.contains(station)) {
        final fromIndex = toPosition.value['current'];
        fromList.value.removeAt(fromIndex);
        fromList.value.insert(fromIndex, station);
      }
    });
    toStation.listen((station) {
      if (!toList.value.contains(station)) {
        final toIndex = toPosition.value['current'];
        toList.value.removeAt(toIndex);
        toList.value.insert(toIndex, station);
      }
    });
  }

  select(List<Station> allStations) {
    final rnd = Random();
    final available = List.generate(allStations.length, (index) => index);
    final used = List();

    index() {
      final place = rnd.nextInt(available.length);
      final index = available.elementAt(place);
      available.removeAt(place);
      used.add(index);
      return index;
    }

    fromList.add(List.generate(5, (_) => allStations.elementAt(index())));
    fromStation.add(fromList.value.elementAt(0));
    _setFromIndex(0);

    toList.add(List.generate(5, (_) => allStations.elementAt(index())));
    toStation.add(toList.value.elementAt(0));
    _setToIndex(0);
  }

  switchStations() {
    final toIndex = toPosition.value['current'];
    final fromIndex = toPosition.value['current'];

    final to = toList.value.elementAt(toPosition.value['current']);
    final from = fromList.value.elementAt(fromPosition.value['current']);

    toList.value.removeAt(toIndex);
    toList.value.insert(toIndex, from);

    fromList.value.removeAt(fromIndex);
    fromList.value.insert(fromIndex, to);
  }

  nextTo() {
    final current = toPosition.value['current'];
    if (current < toList.value.length - 1 && current >= 0) {
      _setToIndex(current + 1);
      final newIndex = toPosition.value['current'];
      toStation.add(toList.value.elementAt(newIndex));
    }
  }

  prevTo() {
    final current = toPosition.value['current'];
    if (current <= toList.value.length && current > 0) {
      _setToIndex(current - 1);
      final newIndex = toPosition.value['current'];
      toStation.add(toList.value.elementAt(newIndex));
    }
  }

  nextFrom() {
    final current = fromPosition.value['current'];
    if (current < fromList.value.length - 1 && current >= 0) {
      _setFromIndex(current + 1);
      final newIndex = fromPosition.value['current'];
      fromStation.add(fromList.value.elementAt(newIndex));
    }
  }

  prevFrom() {
    final current = fromPosition.value['current'];
    if (current <= fromList.value.length && current > 0) {
      _setFromIndex(current - 1);
      final newIndex = fromPosition.value['current'];
      fromStation.add(fromList.value.elementAt(newIndex));
    }
  }

  _setFromIndex(int index) {
    if (index < fromList.value.length)
      fromPosition.add({'current': index, 'total': fromList.value.length});
  }

  _setToIndex(int index) {
    if (index < toList.value.length)
      toPosition.add({'current': index, 'total': toList.value.length});
  }

  close() {
    fromList.close();
    toList.close();
    fromPosition.close();
    toPosition.close();
  }
}
