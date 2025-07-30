import 'package:equatable/equatable.dart';

class JokeModel extends Equatable {
  final String? setup;
  final String? delivery;
  final String? joke;
  final bool? isTwoPart;

  const JokeModel({this.setup, this.delivery, this.joke, this.isTwoPart});

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      setup: json['setup'],
      delivery: json['delivery'],
      isTwoPart: json['type'] == 'twopart',
      joke: json['joke'],
    );
  }

  String get setupJoke =>
      setup != null && delivery != null ? setup! : joke ?? '';

  String get deliverJoke => setup != null && delivery != null ? delivery! : '';

  @override
  List<Object?> get props => [setup, delivery, joke];
}
