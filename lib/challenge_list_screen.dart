import 'package:flutter/material.dart';
import 'challenge_card.dart';
import 'challenge.dart';
import 'completed_screen.dart';
import 'not_completed_screen.dart';

class ChallengeListScreen extends StatefulWidget {
  @override
  _ChallengeListScreenState createState() => _ChallengeListScreenState();
}

class _ChallengeListScreenState extends State<ChallengeListScreen> {
  bool _challengeCompleted = false;
  bool _showNotCompletedView = false;

  @override
  Widget build(BuildContext context) {
    final bool showAppBar = !_challengeCompleted && !_showNotCompletedView;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      appBar: showAppBar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: _buildAppBar(),
            )
          : null,
      body: _showNotCompletedView
          ? _buildNotCompletedView()
          : (_challengeCompleted
              ? _buildChallengeCompletedView()
              : _buildChallengeListView()),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: const Text(
        "LIST OF CHALLENGES",
        style: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromRGBO(15, 44, 89, 1),
    );
  }

  Widget _buildChallengeListView() {
    return ListView.builder(
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return ChallengeCard(
          challenge: challenges[index],
          onComplete: () {
            setState(() {
              _challengeCompleted = true;
            });
          },
          onNotComplete: () {
            setState(() {
              _showNotCompletedView = true;
            });
          },
        );
      },
    );
  }

  Widget _buildChallengeCompletedView() {
    return CompletedScreen(
      onComplete: () {
        setState(() {
          _challengeCompleted = false;
        });
      },
    );
  }

  Widget _buildNotCompletedView() {
    return NotCompletedScreen(
      onNotComplete: () {
        setState(() {
          _showNotCompletedView = false;
        });
      },
    );
  }

  final List<Challenge> challenges = [
    Challenge("Go meatless for a day", "Try a vegetarian diet for a day",
        'assets/images/1.jpeg'),
    Challenge("Recycle 5 Items", "Help the environment by recycling 5 items",
        'assets/images/2.jpeg'),
    Challenge(
        "Reduce Screen Time",
        "Try to reduce the screen time and engage in offline activities",
        'assets/images/3.jpeg'),
    Challenge(
        "Plant a Tree or Flower",
        "Contribute to the environment by planting a tree or flower",
        'assets/images/4.jpeg'),
    Challenge(
        "Learn a New Skill",
        "Learn a new skill, whether it's coding, painting, or a DIY project",
        'assets/images/5.jpeg'),
  ];
}
