import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class ProjectsForm extends StatefulWidget {
  const ProjectsForm({Key? key}) : super(key: key);
  static const routeName = '/forms/projectNames-form';
  @override
  State<ProjectsForm> createState() => _ProjectNametstate();
}

class _ProjectNametstate extends State<ProjectsForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> projectController = [];
  final List<TextEditingController> linkController = [];
  final List<TextEditingController> descriptionController = [];
  final List<TextEditingController> toolsController = [];
  final List<TextEditingController> additionalsController = [];

  List<String?> projectNames = [];
  List<String?> links = [];
  List<String?> descriptions = [];
  List<String?> tools = [];
  List<String?> additionals = [];

  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.projects != null && once) {
      for (var i = 0; i < (resume.projects!.length); i++) {
        addProject();
        _count++;
        final projects = resume.projects;
        projectController[i].text = projectNames[i] ?? projects![i].projectName;
        linkController[i].text = links[i] ?? projects![i].link;
        descriptionController[i].text =
            descriptions[i] ?? projects![i].description;
        additionalsController[i].text =
            additionals[i] ?? projects![i].additionals ?? '';
        toolsController[i].text = tools[i] ?? projects![i].tools;
      }
      once = false;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: const HeadingText(
          color: Colors.black,
          text: 'Add your projects',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _count++;
              });
              addProject();
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
                  path: 'assets/form images/project.svg',
                  text:
                      'Start adding your projects by clicking on the \'+\' icon.',
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
                                title: 'Project ${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      resumeModel.removeProject('0', index,
                                          resume.projects![index].id!);
                                      removeProject(index);
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InputBox(
                                      controller: projectController[index],
                                      hintText: 'Amazon',
                                      infoText: 'Project Name',
                                      onChanged: (value) {
                                        projectNames[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter project name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: linkController[index],
                                      hintText: 'https://github.com/',
                                      infoText: 'Project Link',
                                      onChanged: (value) {
                                        links[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter project link';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: descriptionController[index],
                                      hintText:
                                          'Describe your project in 2 - 3 lines',
                                      infoText: 'Description',
                                      maxLines: 4,
                                      onChanged: (value) {
                                        descriptions[index] = value;
                                        if (value.isNotEmpty) {
                                          if (value.codeUnitAt(
                                                value.length - 1,
                                              ) ==
                                              10) {
                                            descriptions[index] =
                                                descriptions[index]! + bullet;
                                            descriptionController[index].text =
                                                descriptions[index]!;
                                            descriptionController[index]
                                                    .selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                    descriptionController[index]
                                                        .text
                                                        .length,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      onTap: () {
                                        setState(() {
                                          if (descriptionController[index]
                                              .text
                                              .isEmpty) {
                                            descriptionController[index].text =
                                                bullet;
                                          }
                                        });
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        descriptions[index] = null;
                                        descriptionController[index].text =
                                            bullet;
                                        descriptionController[index].selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                            offset: descriptionController[index]
                                                .text
                                                .length,
                                          ),
                                        );
                                      },
                                      child: const Text('Clear Description'),
                                    ),
                                    InputBox(
                                      controller: toolsController[index],
                                      hintText:
                                          'Flutter Firebase React Angular',
                                      infoText: 'Tools Used',
                                      onChanged: (value) {
                                        tools[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter tools used';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: additionalsController[index],
                                      hintText:
                                          'Anything else you want to mention',
                                      infoText: 'Additional Details',
                                      onChanged: (value) {
                                        additionals[index] = value;
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
                                      resumeModel.addProject(
                                        '0',
                                        Project(
                                          projectName:
                                              projectController[index].text,
                                          description:
                                              descriptionController[index].text,
                                          link: linkController[index].text,
                                          tools: toolsController[index].text,
                                          additionals:
                                              additionalsController[index].text,
                                          id: projectController[index].text,
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

  void addProject() {
    projectController.add(TextEditingController());
    projectNames.add(null);
    linkController.add(TextEditingController());
    links.add(null);
    descriptionController.add(TextEditingController());
    descriptions.add(null);
    toolsController.add(TextEditingController());
    tools.add(null);
    additionalsController.add(TextEditingController());
    additionals.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeProject(int index) {
    projectController.removeAt(index);
    projectNames.removeAt(index);
    linkController.removeAt(index);
    links.removeAt(index);
    descriptionController.removeAt(index);
    descriptions.removeAt(index);
    toolsController.removeAt(index);
    tools.removeAt(index);
    additionalsController.removeAt(index);
    additionals.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
