import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumex/models/models.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class OnlineProfilesForm extends StatefulWidget {
  const OnlineProfilesForm({Key? key}) : super(key: key);
  static const routeName = '/forms/online-profiles-form';

  @override
  State<OnlineProfilesForm> createState() => _OnlineProfilesFormState();
}

class _OnlineProfilesFormState extends State<OnlineProfilesForm> {
  final _formKey = GlobalKey<FormState>();
  int _count = 0;
  final List<bool> _maximize = [];
  final List<bool> _prevSave = [];
  bool once = true;

  final List<TextEditingController> platformController = [];
  final List<TextEditingController> linkController = [];

  final List<String?> platforms = [];
  final List<String?> links = [];
  @override
  Widget build(BuildContext context) {
    final resumeModel = Provider.of<ResumeModelProvider>(context);
    final resume = resumeModel.currentResume();
    if (resume.onlineProfiles != null && once) {
      for (var i = 0; i < resume.onlineProfiles!.length; i++) {
        addProfile();
        final profile = resume.onlineProfiles;
        platformController[i].text = platforms[i] ?? profile![i].platform;
        linkController[i].text = links[i] ?? profile![i].link;
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
              addProfile();
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
                  text:
                      'Start adding your portfolios or profiles by clicking on the plus icon',
                  path: 'assets/form images/online_profile.svg',
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
                                title: 'Profile ${index + 1}',
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      resumeModel.removeOnlineProfile(
                                        '0',
                                        index,
                                        'o',
                                      );
                                      removeProfile(index);
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
                                      controller: platformController[index],
                                      hintText: 'LinkedIn',
                                      infoText: 'Platform',
                                      onChanged: (value) {
                                        platforms[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter platform';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    InputBox(
                                      controller: linkController[index],
                                      hintText: 'https://linkedin.com/JohnDoe',
                                      infoText: 'URL',
                                      onChanged: (value) {
                                        links[index] = value;
                                      },
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter link';
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
                                      resumeModel.addOnlineProfile(
                                        '0',
                                        OnlineProfile(
                                            id: platformController[index].text,
                                            platform:
                                                platformController[index].text,
                                            link: linkController[index].text),
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

  void addProfile() {
    platformController.add(TextEditingController());
    platforms.add(null);
    linkController.add(TextEditingController());
    links.add(null);
    _maximize.add(true);
    _prevSave.add(false);
  }

  void removeProfile(int index) {
    platformController.removeAt(index);
    platforms.removeAt(index);
    linkController.removeAt(index);
    links.removeAt(index);
    _maximize.removeAt(index);
    _prevSave.removeAt(index);
    _count--;
  }
}
