import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class AchievementsForm extends StatefulWidget {
  const AchievementsForm({Key? key}) : super(key: key);
  static const routeName = '/forms/achievements-form';
  @override
  State<AchievementsForm> createState() => _AchievementsFormState();
}

class _AchievementsFormState extends State<AchievementsForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> achievementController = [];
  final List<String?> achievements = [];
  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.acheivements != null && once) {
      for (var i = 0; i < resume.acheivements!.length; i++) {
        addAchievement();
        final achievementSet = resume.acheivements;
        achievementController[i].text =
            achievements[i] ?? achievementSet![i].achievement;
        _count++;
      }
      once = false;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: const HeadingText(
          color: Colors.black,
          text: 'Add your achievements',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _count++;
              });
              addAchievement();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SizedBox(
        child: Form(
          key: _formKey,
          child: _count == 0
              ? const PlaceHolder(
                  path: 'assets/form images/achievements_form.svg',
                  text: 'You can add your achievements here',
                )
              : ListView.builder(
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 30,
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InfoText(
                                title: 'Achievement ${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      resumeModel.removeAchievement(
                                        '0',
                                        index,
                                        resume.acheivements![index].id!,
                                      );
                                      removeAchievement(index);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _maximize[index] = !_maximize[index];
                                        if (_maximize[index]) {
                                          _prevSave[index] = false;
                                        }
                                      });
                                    },
                                    icon: _maximize[index]
                                        ? const Icon(Icons.expand_less)
                                        : const Icon(Icons.expand_more),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        _maximize[index]
                            ? Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 12,
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(58, 189, 181, 181),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: InputBox(
                                  controller: achievementController[index],
                                  hintText: 'I won blah blah competition',
                                  infoText: 'Your Achievement',
                                  onChanged: (value) {
                                    achievements[index] = value;
                                  },
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              )
                            : const SizedBox(),
                        _prevSave[index] != true
                            ? SaveButton(
                                onPressed: () {
                                  if (index == 0 || _prevSave[index - 1]) {
                                    if (_formKey.currentState!.validate()) {
                                      snackbar(context, 'Saving...');
                                      resumeModel.addAcheievement(
                                        '0',
                                        Achievement(
                                          achievement:
                                              achievementController[index].text,
                                          id: achievementController[index].text,
                                        ),
                                        index,
                                      );
                                      setState(() {
                                        _maximize[index] = false;
                                        _prevSave[index] = true;
                                      });
                                    }
                                  } else {
                                    snackbar(
                                      context,
                                      'Please save the previous one first...',
                                    );
                                  }
                                },
                              )
                            : ChipButton(
                                color: Colors.green,
                                text: 'Saved',
                                onPressed: () {},
                              ),
                        const Divider(
                          indent: 40,
                          endIndent: 40,
                          color: Colors.grey,
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }

  void addAchievement() {
    achievementController.add(TextEditingController());
    achievements.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeAchievement(int index) {
    achievementController.removeAt(index);
    achievements.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
