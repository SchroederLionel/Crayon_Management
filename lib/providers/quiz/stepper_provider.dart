import 'package:crayon_management/datamodels/enum.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperProvider extends ChangeNotifier {
  BuildContext context;

  StepperProvider({required this.context});

  StepperState _state = StepperState.select;
  int _currentPage = 0;
  int get currentPage => _currentPage;
  StepperState get state => _state;

  setState(StepperState state) {
    _state = state;
    setCurrentPage(state);
    notifyListeners();
  }

  setCurrentPage(StepperState state) {
    if (state == StepperState.select) {
      _currentPage = 0;
    } else if (state == StepperState.time) {
      _currentPage = 1;
    } else if (state == StepperState.lobby) {
      _currentPage = 2;
    } else if (state == StepperState.countdown) {
      _currentPage = 3;
    } else if (state == StepperState.result) {
      _currentPage = 4;
    } else if (state == StepperState.explenation) {
      _currentPage = 5;
    }
  }

  Widget getButtons() {
    if (_state == StepperState.select) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Quiz choosen'),
              onPressed: () => setState(StepperState.time)),
        ],
      );
    } else if (_state == StepperState.time) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Time Picked (You wont be able to go back)'),
              onPressed: () => setState(StepperState.lobby)),
          const SizedBox(width: 20),
          ElevatedButton(
              child: Text('Back'),
              onPressed: () => setState(StepperState.select))
        ],
      );
    } else if (_state == StepperState.lobby) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Closing Lobby '),
              onPressed: () => setState(StepperState.countdown)),
        ],
      );
    } else if (_state == StepperState.countdown) {
      return const SizedBox();
    } else if (_state == StepperState.result) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Explain quiz'),
              onPressed: () => setState(StepperState.explenation)),
        ],
      );
    } else if (_state == StepperState.explenation) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text('Finished'),
              onPressed: () => Navigator.of(context).pop()),
        ],
      );
    }
    return Container();
  }
}
