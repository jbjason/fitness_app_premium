import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/onboard/presentation/providers/onboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboard4Target extends StatefulWidget {
  const Onboard4Target({super.key});
  @override
  State<Onboard4Target> createState() => _Onboard4TargetState();
}

class _Onboard4TargetState extends State<Onboard4Target> {
  int selectedIndex = 0;
  final List<Map<String, String>> _goals = [
    {
      'title': 'Lose Weight & Keep Fit',
      'subtitle': "💪 Slim & fit ahead!",
      'description':
          'Get ready to see a healthier, lighter you. Follow our tailored plan to conquer your fitness goal!',
      'image': MyImage.loseWeightImg
    },
    {
      'title': 'Butt Lift & Tone',
      'subtitle': "🥰 Bubble butt awaits!",
      'description':
          'Your journey to lifted butt starts now!\nLet\'s shape your gluets into perfect ones!',
      'image': MyImage.buttLiftImg
    },
    {
      'title': 'Lose Belly Fat',
      'subtitle': "👋 Say bye to belly fat!",
      'description':
          'Shed your stubborn belly fat and get a slimmer waistline, and we\'re here to support you!',
      'image': MyImage.bellyFatImg
    },
    {
      'title': 'Build Muscles & Strength',
      'subtitle': "💪 Muscle up, confidence up!",
      'description':
          'Let\'s craft your ideal physique with our superb plan, one muscle at a time.',
      'image': MyImage.buildMuscleImg
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "What's your main goal?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                _goals.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      final data =
                          Provider.of<OnboardProvider>(context, listen: false);
                      data.setTarget(index);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedIndex == index
                                  ? MyColor.accentColor
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                              color: selectedIndex == index
                                  ? MyColor.accentColor
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      _goals[index]['title'] ?? '',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(_goals[index]['image'] ?? '',
                                    height: 130, fit: BoxFit.cover),
                              ],
                            ),
                          ),
                        ),
                        if (selectedIndex == index &&
                            _goals[index]['description'] != '')
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${_goals[index]['subtitle'] ?? ""}\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  TextSpan(
                                    text: _goals[index]['description'] ?? "",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
