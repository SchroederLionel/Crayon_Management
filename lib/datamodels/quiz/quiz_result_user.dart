import 'package:crayon_management/datamodels/quiz/quiz_response_user.dart';

/// QuizResult from the user.
/// Has the ability to transform the object into json. (without the totalScore)
class QuizResultUser {
  /// Answers of the user containing the question and the response.
  final List<QuizResponse> responses;

  /// The score the user achived in the quiz.
  final int score;

  /// Username selected by the user.
  final String userName;

  QuizResultUser(
      {required this.responses, required this.score, required this.userName});

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'score': score,
        'responses': responses.map((response) => response.toJson()).toList(),
      };
      
  factory QuizResultUser.fromJson(Map<String, dynamic> json) {
    var userName = json['userName'];
    var score = json['score'];
    final responseData = json['responses'] as List<dynamic>?;
    var responses = responseData != null
        ? responseData
            .map((response) => QuizResponse.fromJson(response))
            .toList()
        : <QuizResponse>[];
    return QuizResultUser(
        responses: responses, score: score, userName: userName);
  }
}
