import 'package:flutter/material.dart';
import 'package:graduation_project/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff30836F),
        centerTitle: true,
        title: const Text(
          "صف حالتك ",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.translate, color: Colors.white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: index == answers.length
            ? _resultWidget()
            : Column(
                children: [
                  const SizedBox(height: 40),
                  _questionWidget(),
                  const SizedBox(height: 50),
                  Expanded(child: _answerButtonsWidget()),
                  const SizedBox(height: 50),
                ],
              ),
      ),
    );
  }

///////////////////////////////////////////////////////////
///////////////// Widget Methods //////////////////////////
//////////////////////////////////////////////////////////
  int index = 0;
  int userPoints = 0;
  int maxPoints = answers.length * 3;
  double percentage = 0;

  Widget _questionWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xff30836F))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.psychology_alt,
            color: Color(0xff30836F),
            size: 40,
          ),
          Text(
            "${index + 1}",
            style: const TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _answerButtonWidget({required int points, required String answer}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          userPoints += points;
          index++;
          answers.length == index
              ? percentage = (userPoints / maxPoints) * 100
              : null;
          setState(() {});
        },
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xff30836F)),
          child: Center(
            child: Text(
              answer,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _answerButtonsWidget() {
    return Column(
      children: [
        _answerButtonWidget(points: 0, answer: answers[index][0]),
        const SizedBox(height: 10),
        _answerButtonWidget(points: 1, answer: answers[index][1]),
        const SizedBox(height: 10),
        _answerButtonWidget(points: 2, answer: answers[index][2]),
        const SizedBox(height: 10),
        _answerButtonWidget(points: 3, answer: answers[index][3]),
      ],
    );
  }

  Widget _resultWidget() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff30836F)),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "نتيجة اختبار الاكتئاب: $userPoints نقطة",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "حالتك: ${_getPatientStatus(userPoints: userPoints)}",
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

////////////////////////////////////////////////////////////
///////////////// Helper Methods //////////////////////////
//////////////////////////////////////////////////////////

  String _getPatientStatus({required int userPoints}) {
    if (userPoints >= 0 && userPoints <= 9) {
      return "متفائل";
    } else if (userPoints >= 10 && userPoints <= 15) {
      return "اكتئاب بسيط";
    } else if (userPoints >= 16 && userPoints <= 23) {
      return "الاكتئاب متوسط";
    } else if (userPoints >= 24 && userPoints <= 36) {
      return "الاكتئاب شديد";
    } else {
      return "الاكتئاب شديد جدا";
    }
  }
}
