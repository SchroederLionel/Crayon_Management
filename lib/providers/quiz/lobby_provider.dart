import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/services/quiz_service.dart';
import 'package:flutter/foundation.dart';

class LobbyProvider extends ChangeNotifier {
  String lectureId;
  LobbyProvider({required this.lectureId});

  NotifierState _state = NotifierState.initial;
  bool _isLobbyOpen = false;

  NotifierState get state => _state;
  bool get isLobbyOpen => _isLobbyOpen;

  setLobby(bool isLobbyOpen) async {
    setState(NotifierState.loading);
    await QuizService.allowParticipantsToJoinLobby(lectureId);
    _isLobbyOpen = isLobbyOpen;
    setState(NotifierState.loaded);
  }

  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }
}
