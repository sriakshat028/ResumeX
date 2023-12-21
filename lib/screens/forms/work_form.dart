import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumex/models/resume_model.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class WorkForm extends StatefulWidget {
  const WorkForm({Key? key}) : super(key: key);
  static const routeName = '/forms/work-form';

  @override
  State<WorkForm> createState() => _WorkFormState();
}

class _WorkFormState extends State<WorkForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> companyController = [];
  final List<TextEditingController> roleController = [];
  final List<TextEditingController> addressController = [];
  final List<TextEditingController> startDateController = [];
  final List<TextEditingController> endDateController = [];
  final List<bool> currentlyWorkingList = [];
  final List<TextEditingController> workController = [];

  List<String?> companyName = [];
  List<String?> role = [];
  List<String?> address = [];
  List<String?> startDate = [];
  List<String?> endDate = [];
  List<bool?> currentlyWorking = [];
  List<String?> workDone = [];

  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.workExperiences != null && once) {
      for (var i = 0; i < (resume.workExperiences!.length); i++) {
        addWork();
        _count++;
        final workexp = resume.workExperiences;
        companyController[i].text = companyName[i] ?? workexp![i].companyName;
        roleController[i].text = role[i] ?? workexp![i].role;
        addressController[i].text = address[i] ?? workexp![i].address;
        startDateController[i].text = startDate[i] ?? workexp![i].startDate;
        endDateController[i].text = endDate[i] ?? workexp![i].endDate ?? '';
        workController[i].text = workDone[i] ?? workexp![i].workDone;
      }
      once = false;
    } else {}

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: const HeadingText(
          color: Colors.black,
          text: 'Add your work experience',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _count++;
              });
              addWork();
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
                  path: 'assets/form images/experience.svg',
                  text: 'Start adding your work experience'
                      ' by clicking on the \'+\' icon.',
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
                                title: 'Work Experience #${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // print('Delete pressed');
                                      resumeModel.removeExperience(
                                        '0',
                                        index,
                                        resume.workExperiences![index].id!,
                                      );
                                      removeWork(index);
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
                                      controller: companyController[index],
                                      hintText: 'e.g. Dunder Mufflin',
                                      infoText: 'Company',
                                      onChanged: (value) {
                                        companyName[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter company name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: roleController[index],
                                      hintText:
                                          'e.g. Assitant Regional Manager',
                                      infoText: 'Job Role',
                                      onChanged: (value) {
                                        role[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter role';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: addressController[index],
                                      hintText: 'e.g. Scranton',
                                      infoText: 'Location',
                                      onChanged: (value) {
                                        address[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter company location';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: startDateController[index],
                                      hintText: 'e.g. June 2002',
                                      infoText: 'Start Date',
                                      onChanged: (value) {
                                        startDate[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter company location';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: endDateController[index],
                                      hintText:
                                          'September 2021 / Currently Working',
                                      infoText: 'End Date',
                                      onChanged: (value) {
                                        endDate[index] = value;
                                      },
                                    ),
                                    InputBox(
                                      infoText: 'Description',
                                      hintText:
                                          'Describe your work in 3-4 lines\n'
                                          '$bullet Tailor your experience to the job description\n'
                                          '$bullet Use important keywords and accomplishments\n'
                                          '$bullet Find out what\'s important from the job listing\n',
                                      maxLines: 4,
                                      onChanged: (value) {
                                        workDone[index] = value;
                                        if (value.isNotEmpty) {
                                          if (value.codeUnitAt(
                                                value.length - 1,
                                              ) ==
                                              10) {
                                            workDone[index] =
                                                workDone[index]! + bullet;
                                            workController[index].text =
                                                workDone[index]!;
                                            workController[index].selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset: workController[index]
                                                    .text
                                                    .length,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      onTap: () {
                                        setState(() {
                                          if (workController[index]
                                              .text
                                              .isEmpty) {
                                            workController[index].text = bullet;
                                          }
                                        });
                                      },
                                      controller: workController[index],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        workDone[index] = null;
                                        workController[index].text = bullet;
                                        workController[index].selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                            offset: workController[index]
                                                .text
                                                .length,
                                          ),
                                        );
                                      },
                                      child: const Text('Clear Description'),
                                    )
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
                                      resumeModel.addExperience(
                                        '0',
                                        WorkExperience(
                                          companyName:
                                              companyController[index].text,
                                          role: roleController[index].text,
                                          address:
                                              addressController[index].text,
                                          startDate:
                                              startDateController[index].text,
                                          endDate:
                                              endDateController[index].text,
                                          workDone: workController[index].text,
                                          id: companyController[index].text +
                                              startDateController[index].text +
                                              endDateController[index].text,
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

  void addWork() {
    companyController.add(TextEditingController());
    companyName.add(null);
    roleController.add(TextEditingController());
    role.add(null);
    addressController.add(TextEditingController());
    address.add(null);
    startDateController.add(TextEditingController());
    startDate.add(null);
    endDateController.add(TextEditingController());
    endDate.add(null);
    currentlyWorkingList.add(false);
    currentlyWorking.add(false);
    workController.add(TextEditingController());
    workDone.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeWork(int index) {
    companyController.removeAt(index);
    companyName.removeAt(index);
    roleController.removeAt(index);
    role.removeAt(index);
    addressController.removeAt(index);
    address.removeAt(index);
    startDateController.removeAt(index);
    startDate.removeAt(index);
    endDateController.removeAt(index);
    endDate.removeAt(index);
    currentlyWorkingList.removeAt(index);
    currentlyWorking.removeAt(index);
    workController.removeAt(index);
    workDone.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
