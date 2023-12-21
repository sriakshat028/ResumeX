import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class ActivitiesForm extends StatefulWidget {
  const ActivitiesForm({Key? key}) : super(key: key);
  static const routeName = '/forms/activities-form';
  @override
  State<ActivitiesForm> createState() => _ActivitiesFormState();
}

class _ActivitiesFormState extends State<ActivitiesForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> activitiesController = [];
  final List<String?> activities = [];
  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.activities != null && once) {
      for (var i = 0; i < resume.activities!.length; i++) {
        addActivity();
        final activitySet = resume.activities;
        activitiesController[i].text =
            activities[i] ?? activitySet![i].activity;
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
          text: 'Add your activities',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _count++;
              });
              addActivity();
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
                  path: 'assets/form images/activities_form.svg',
                  text: 'You can add your extra curricular activities here',
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
                                title: 'Activities ${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      resumeModel.removeActivity(
                                        '0',
                                        index,
                                        resume.activities![index].id!,
                                      );
                                      removeActivity(index);
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
                                  controller: activitiesController[index],
                                  hintText:
                                      'Core team member at coders club in my city',
                                  infoText: 'Activity ',
                                  onChanged: (value) {
                                    activities[index] = value;
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
                                      resumeModel.addActivity(
                                        '0',
                                        Activity(
                                          activity: activitiesController[index].text,
                                          id: activitiesController[index].text,
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

  void addActivity() {
    activitiesController.add(TextEditingController());
    activities.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeActivity(int index) {
    activitiesController.removeAt(index);
    activities.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
