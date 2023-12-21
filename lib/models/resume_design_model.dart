import 'package:flutter/material.dart';

class ResumeDesign {
  String name;
  List<String> keyPoints;
  Color? color;
  String path;
  String? url;
  int? stars;

  ResumeDesign({
    required this.name,
    required this.keyPoints,
    required this.color,
    required this.path,
    this.url,
    this.stars,
  });

  static List<ResumeDesign> sampleDesigns = [
    ResumeDesign(
      name: 'Simple',
      keyPoints: [
        'Simple resume template',
        'Excellent readability',
        'Without being bland'
      ],
      color: const Color.fromARGB(186, 33, 3, 24),
      path: 'assets/resume_templates/template0.png',
      stars: 4,
    ),
    ResumeDesign(
      name: 'Vibes',
      keyPoints: [
        'Sleek Resume Templates',
        'Clean Format',
        'With Exciting details'
      ],
      color: const Color.fromARGB(184, 3, 28, 33),
      path: 'assets/resume_templates/template1.png',
      stars: 5,
    ),
    ResumeDesign(
      name: 'New Cast',
      keyPoints: [
        'Basic Resume Template',
        'Standard Design',
        'Designer finish'
      ],
      path: 'assets/resume_templates/template2.png',
      color: const Color.fromARGB(184, 6, 33, 3),
    ),
  ];
}
