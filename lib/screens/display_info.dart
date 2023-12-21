import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './forms/forms.dart';
import '../screens/screens.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

const List<String> routes = [
  ContactForm.routeName,
  WorkForm.routeName,
  ProjectsForm.routeName,
  EducationForm.routeName,
  OnlineProfilesForm.routeName,
  SkillsForm.routeName,
  AchievementsForm.routeName,
  ActivitiesForm.routeName,
];

class DisplayInfo extends StatefulWidget {
  const DisplayInfo({Key? key}) : super(key: key);
  static const routeName = '/display-info';

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 5,
      backgroundColor: Colors.white,
      title: const HeadingText(
        color: Colors.black,
        text: 'Review/Edit your details',
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(DisplayPdf.routeName);
          },
          icon: const Icon(
            Icons.preview,
            size: 30,
            color: Colors.black,
          ),
        ),
      ],
    );

    final appBarHeight = appBar.preferredSize.height;
    final bodyHeight = MediaQuery.of(context).size.height - appBarHeight;
    final bodyWidth = MediaQuery.of(context).size.width;

    final infoModel = Provider.of<InfosModel>(context);
    final resume = Provider.of<ResumeModelProvider>(context);

    return Scaffold(
      appBar: appBar,
      body: infoModel.trueCount == 0
          ? const PlaceHolder(
              path: 'assets/form images/build_resume.svg',
              text: 'Start building your resume by adding '
                  'different sections from the \'+\' icon.',
            )
          : ListView.builder(
              itemCount: infoModel.infos.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < infoModel.infos.length) {
                  if (infoModel.infosAvail[index]) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: infoModel.colors[index],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  HeadingText(
                                    text: infoModel.infos[index],
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (index < routes.length) {
                                        Navigator.of(context).pushNamed(
                                          routes[index],
                                        );
                                      } else {}
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      infoModel
                                          .removeInfo(infoModel.infos[index]);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          ParaText(
                            text: resume.currentResume().resumeObjects[index] !=
                                    null
                                ? resume
                                    .currentResume()
                                    .resumeObjects[index]
                                    .toString()
                                    .substring(
                                      1,
                                      resume
                                              .currentResume()
                                              .resumeObjects[index]
                                              .toString()
                                              .length -
                                          1,
                                    )
                                : '',
                            color: Colors.white,
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return Column(
                    children: const [
                      Divider(
                        color: Colors.black,
                        endIndent: 40,
                        indent: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0, right: 40),
                        child: Text(
                          'You can add sections using the plus section at the bottom corner.'
                          ' Use the edit button to modify each section',
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        endIndent: 40,
                        indent: 40,
                      ),
                    ],
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Stack(
                children: [
                  Positioned(
                    bottom: 50,
                    right: 0,
                    left: bodyWidth * .5 * 1.25,
                    child: SizedBox(
                      height: bodyHeight * .25,
                      child: ListView.builder(
                        itemCount: infoModel.infos.length,
                        itemBuilder: (context, index) {
                          if (!infoModel.infosAvail[index]) {
                            return ChipButton(
                              text: infoModel.infos[index],
                              color: infoModel.colors[index],
                              onPressed: () {
                                infoModel.updateInfosAvail(
                                  true,
                                  infoModel.infos[index],
                                );
                                snackbar(
                                  context,
                                  'Added ${infoModel.infos[index]}',
                                );
                                Navigator.pop(context);
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.black,
        elevation: 5,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
