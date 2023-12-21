import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class SkillsForm extends StatefulWidget {
  const SkillsForm({Key? key}) : super(key: key);
  static const routeName = '/forms/skills-form';

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> domainController = [];
  final List<TextEditingController> skillController = [];

  final List<String?> domains = [];
  final List<String?> skills = [];
  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.skills != null && once) {
      for (var i = 0; i < resume.skills!.length; i++) {
        addSkills();
        final skillset = resume.skills;
        skillController[i].text = skills[i] ?? skillset![i].skills;
        domainController[i].text = domains[i] ?? skillset![i].domain;
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
          text: 'Add your profiles',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _count++;
              });
              addSkills();
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
                  path: 'assets/form images/skills_form.svg',
                  text: 'You can add your skills and their domains ',
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
                                title: 'Skillset ${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (resume.skills == null ||
                                          resume.skills!.isEmpty) {
                                        removeSkills(index);
                                      } else {
                                        resumeModel.removeSkills(
                                          '0',
                                          index,
                                          resume.skills![index].id!,
                                        );
                                      }

                                      removeSkills(index);
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
                                      controller: domainController[index],
                                      hintText: 'Framework/Languages/Design',
                                      infoText: 'Domain',
                                      onChanged: (value) {
                                        domains[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter domain';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: skillController[index],
                                      hintText: 'C++, Java, Python etc',
                                      infoText: 'Skillset',
                                      onChanged: (value) {
                                        skills[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter domain';
                                        } else {
                                          return null;
                                        }
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
                                      resumeModel.addSkill(
                                        '0',
                                        Skill(
                                          domain: domainController[index].text,
                                          skills: skillController[index].text,
                                          id: domainController[index].text,
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

  void addSkills() {
    skillController.add(TextEditingController());
    skills.add(null);
    domainController.add(TextEditingController());
    domains.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeSkills(int index) {
    skillController.removeAt(index);
    skills.removeAt(index);
    domainController.removeAt(index);
    domains.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
