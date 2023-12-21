import 'package:resumex/models/models.dart';

class Profession {
  final String path;
  final String name;
  final ResumeDesign design;

  const Profession({
    required this.path,
    required this.name,
    required this.design,
  });

  static List<Profession> sampleProfession = [
    Profession(
      path: 'assets/images/profession images/coder.svg',
      name: 'Coder',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/writer.svg',
      name: 'Writer',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/engineer.svg',
      name: 'Engineer',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/designer.svg',
      name: 'Designer',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/doctor.svg',
      name: 'Doctor',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/scientist.svg',
      name: 'Scientist',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/professor.svg',
      name: 'Professor',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/management.svg',
      name: 'Management/HR',
      design: ResumeDesign.sampleDesigns[0],
    ),
    Profession(
      path: 'assets/images/profession images/other.svg',
      name: 'Other',
      design: ResumeDesign.sampleDesigns[0],
    )
  ];
}
