import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumex/models/models.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({Key? key}) : super(key: key);
  static const routeName = '/forms/education-form';

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> instituteController = [];
  final List<TextEditingController> courseController = [];
  final List<TextEditingController> programController = [];
  final List<TextEditingController> startDateController = [];
  final List<TextEditingController> endDateController = [];
  final List<TextEditingController> scoreController = [];

  List<String?> institutes = [];
  List<String?> courses = [];
  List<String?> programs = [];
  List<String?> startDates = [];
  List<String?> endDates = [];
  List<String?> scores = [];
  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.educations != null && once) {
      for (var i = 0; i < resume.educations!.length; i++) {
        addEducation();
        final educations = resume.educations;
        instituteController[i].text = institutes[i] ?? educations![i].institute;
        courseController[i].text = courses[i] ?? educations![i].course;
        programController[i].text = programs[i] ?? educations![i].programme;
        startDateController[i].text = startDates[i] ?? educations![i].startDate;
        endDateController[i].text = endDates[i] ?? educations![i].endDate;
        scoreController[i].text = courses[i] ?? educations![i].course;
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
          text: 'Add your education',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _count++;
              });
              addEducation();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          child: _count == 0
              ? const PlaceHolder(
                  text:
                      'Start adding your education by clicking on the plus icon',
                  path: 'assets/form images/education_form.svg',
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
                                title: 'Education ${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      resumeModel.removeEducation(
                                        '0',
                                        index,
                                        resume.educations![index].id!,
                                      );
                                      removeEducation(index);
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
                                child: Column(
                                  children: [
                                    InputBox(
                                      controller: instituteController[index],
                                      hintText:
                                          'National Institute of Technology',
                                      infoText: 'University / Institute Name',
                                      onChanged: (value) {
                                        institutes[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter institute name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: courseController[index],
                                      hintText: 'Electronics etc',
                                      infoText: 'Specialization / Major',
                                      onChanged: (value) {
                                        courses[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter some text';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: programController[index],
                                      hintText: 'Bachelors or Masters',
                                      infoText: 'Programme',
                                      onChanged: (value) {
                                        programs[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter programme';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: startDateController[index],
                                      hintText: 'June 2020',
                                      infoText: 'From: ',
                                      onChanged: (value) {
                                        startDates[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter start date';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: endDateController[index],
                                      hintText: 'June 2024',
                                      infoText: 'To: ',
                                      onChanged: (value) {
                                        endDates[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter end date';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: scoreController[index],
                                      hintText: '9.1 CGPA',
                                      infoText: 'Score',
                                      onChanged: (value) {
                                        scores[index] = value;
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        _prevSave[index] != true
                            ? SaveButton(
                                onPressed: () {
                                  if (index == 0 || _prevSave[index - 1]) {
                                    if (_formKey.currentState!.validate()) {
                                      snackbar(context, 'Saving...');
                                      resumeModel.addEducation(
                                        '0',
                                        Education(
                                          institute:
                                              instituteController[index].text,
                                          course: courseController[index].text,
                                          endDate:
                                              endDateController[index].text,
                                          programme:
                                              programController[index].text,
                                          startDate:
                                              startDateController[index].text,
                                          score: scoreController[index].text,
                                          id: instituteController[index].text + endDateController[index].text
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

  void addEducation() {
    instituteController.add(TextEditingController());
    institutes.add(null);
    courseController.add(TextEditingController());
    courses.add(null);
    programController.add(TextEditingController());
    programs.add(null);
    startDateController.add(TextEditingController());
    startDates.add(null);
    endDateController.add(TextEditingController());
    endDates.add(null);
    scoreController.add(TextEditingController());
    scores.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeEducation(int index) {
    instituteController.removeAt(index);
    institutes.removeAt(index);
    courseController.removeAt(index);
    courses.removeAt(index);
    programController.removeAt(index);
    programs.removeAt(index);
    startDateController.removeAt(index);
    startDates.removeAt(index);
    endDateController.removeAt(index);
    endDates.removeAt(index);
    scoreController.removeAt(index);
    scores.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
