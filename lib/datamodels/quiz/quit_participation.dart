import 'dart:convert';

class QuizParticipation {
  bool isLobbyOpen = false;
  List<String> participants = [];
  List<UserResponses> userResponses = [];
  QuizParticipation({
    required this.participants,
    required this.userResponses,
  });

  setLobbyOpen(bool open) => isLobbyOpen = open;

  factory QuizParticipation.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return QuizParticipation(participants: [], userResponses: []);
    }
    List<String> participants = [];
    bool isLobbyOpen = false;
    if (json['openLobby'] != null) {
      isLobbyOpen = json['openLobby'] as bool;
    }
    if (json['participants'] == null) {
      var quizP = QuizParticipation(participants: [], userResponses: []);
      quizP.setLobbyOpen(isLobbyOpen);
      return quizP;
    } else {
      final participansdata = jsonEncode(json['participants']);
      participants =
          (jsonDecode(participansdata) as List<dynamic>).cast<String>();
    }

    final userResponsesData = json['userResponses'] as List<dynamic>?;
    final userResponses = userResponsesData != null
        ? userResponsesData
            .map((userResponse) => UserResponses.fromJson(userResponse))
            .toList()
        : <UserResponses>[];
    var quizP = QuizParticipation(
        participants: participants, userResponses: userResponses);
    quizP.setLobbyOpen(isLobbyOpen);
    return quizP;
  }

  @override
  Map<String, dynamic> toJson() => {
        'openLobby': jsonEncode(isLobbyOpen),
        'participants': jsonEncode(participants),
        'userResponses':
            userResponses.map((userResponse) => userResponse.toJson()).toList()
      };
}

class UserResponses {
  String userName;
  List<SingleResponse> responses = [];
  UserResponses({required this.userName, required this.responses});

  factory UserResponses.fromJson(Map<String, dynamic>? json) {
    final userName = json!['userName'] as String;
    final responsesData = json['responses'] as List<dynamic>?;
    final responses = responsesData != null
        ? responsesData
            .map((response) => SingleResponse.fromJson(response))
            .toList()
        : <SingleResponse>[];
    return UserResponses(userName: userName, responses: responses);
  }

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'responses': responses.map((response) => response.toJson()).toList()
      };
}

class SingleResponse {
  String response;
  int questionIndex;
  double score;
  SingleResponse(
      {required this.response,
      required this.questionIndex,
      required this.score});

  factory SingleResponse.fromJson(Map<String, dynamic>? json) {
    final response = json!['response'] as String;
    final questionIndex = json['questionIndex'] as int;
    final score = json['score'] as double;

    return SingleResponse(
        response: response, questionIndex: questionIndex, score: score);
  }

  @override
  Map<String, dynamic> toJson() =>
      {'response': response, 'questionIndex': questionIndex, 'score': score};
}
