import 'package:crayon_management/datamodels/enum.dart';
import 'package:flutter/material.dart';

class ErrorProvider extends ChangeNotifier {
  ErrorState _state = ErrorState.noError;
  ErrorState get state => _state;
  String _errorText = '';

  String get errorText => _errorText;
  void setErrorText(String text) => _errorText = text;

  void resetErroState() {
    _state = ErrorState.noError;
    notifyListeners();
  }

  void setErrorState(String text) {
    setErrorText(text);
    _state = ErrorState.error;
    notifyListeners();
  }
}
