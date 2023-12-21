import '../widgets/input_field.dart' show bullet;

class Contact {
  String name;
  String email;
  String phoneNumber;

  String? city;
  String? province;
  String? country;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.city,
    this.province,
    this.country,
  });

  @override
  String toString() {
    return '[Name: $name\n'
        'Email: $email\n'
        'Phone Number: $phoneNumber\n'
        'Address: $city $province $country]';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phonenumber': phoneNumber,
      'email': email,
      'city': city,
      'province': province,
      'country': country,
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      phoneNumber: map['phonenumber'],
      email: map['email'],
      city: map['city'],
      province: map['province'],
      country: map['country'],
    );
  }
}

class WorkExperience {
  String? id;
  String companyName;
  String role;
  String address;
  String startDate;
  String? endDate;
  bool? currentlyWorking;
  String workDone;

  WorkExperience({
    required this.companyName,
    required this.role,
    required this.address,
    required this.startDate,
    this.endDate,
    this.currentlyWorking,
    required this.workDone,
    this.id,
  });

  List<String> getWork() {
    List<String> result = [];
    String currentLine = '';
    for (var i = 1; i < workDone.length; i++) {
      if (workDone[i] == '\n') {
        continue;
      } else if (workDone[i] == '\u2022') {
        result.add(currentLine);
        // i += 1;
        currentLine = '';
      } else {
        currentLine += workDone[i];
      }
    }
    result.add(currentLine);
    return result;
  }

  @override
  String toString() {
    return '\n$role at $companyName, $address\n'
        'From: $startDate To: ${endDate != null ? '$endDate' : ''}\n'
        'Work- \n$workDone\n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyname': companyName,
      'role': role,
      'address': address,
      'startdate': startDate,
      'enddate': endDate,
      'currentlyworking': currentlyWorking,
      'workdone': workDone,
      'id': id
    };
  }

  static WorkExperience fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      companyName: map['companyname'],
      role: map['role'],
      address: map['address'],
      startDate: map['startdate'],
      workDone: map['workdone'],
      endDate: map['enddate'],
      currentlyWorking: map['currentlyworking'],
      id: map['id'],
    );
  }
}

class Project {
  String? id;
  String projectName;
  String link;
  String description;
  String tools;
  String? additionals;

  Project({
    required this.projectName,
    required this.link,
    required this.description,
    required this.tools,
    this.additionals,
    this.id,
  });

  List<String> getDesc() {
    List<String> result = [];
    String currentLine = '';
    for (var i = 1; i < description.length; i++) {
      if (description[i] == '\n') {
        continue;
      } else if (description[i] == '\u2022') {
        result.add(currentLine);
        currentLine = '';
      } else {
        currentLine += description[i];
      }
    }
    result.add(currentLine);
    return result;
  }

  @override
  String toString() {
    return '\n$projectName { $tools }\n'
        'Link: $link\n'
        'About -\n$description\n'
        '$additionals\n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectname': projectName,
      'link': link,
      'description': description,
      'tools': tools,
      'additionals': additionals,
      'id': id,
    };
  }

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      projectName: map['projectname'],
      link: map['link'],
      description: map['description'],
      tools: map['tools'],
      id: map['id'],
      additionals: map['additionals'],
    );
  }
}

class Education {
  String? id;
  String institute;
  String course;
  String programme;
  String? score;
  String startDate;
  String endDate;

  Education({
    this.id,
    required this.institute,
    required this.course,
    required this.programme,
    this.score,
    required this.startDate,
    required this.endDate,
  });

  @override
  String toString() {
    return '\n$programme in $course\n'
        '$institute\t$score\n'
        'From: $startDate To: $endDate\n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'institute': institute,
      'course': course,
      'programme': programme,
      'score': score,
      'startdate': startDate,
      'enddate': endDate,
      'id': id,
    };
  }

  static Education fromMap(Map<String, dynamic> map) {
    return Education(
      institute: map['institute'],
      course: map['course'],
      programme: map['programme'],
      startDate: map['startdate'],
      endDate: map['enddate'],
    );
  }
}

class OnlineProfile {
  String? id;
  String platform;
  String link;

  OnlineProfile({required this.platform, required this.link, this.id});

  @override
  String toString() {
    return '\n$platform - $link\n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'platform': platform,
      'link': link,
    };
  }

  static OnlineProfile fromMap(Map<String, dynamic> map) {
    return OnlineProfile(
      platform: map['platform'],
      link: map['link'],
    );
  }
}

class Skill {
  String? id;
  String domain;
  String skills;

  Skill({this.id, required this.domain, required this.skills});

  @override
  String toString() {
    return '\n$domain - $skills\n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'domain': domain,
      'skills': skills,
    };
  }

  static Skill fromMap(Map<String, dynamic> map) {
    return Skill(
      domain: map['domain'],
      skills: map['skills'],
    );
  }
}

class Achievement {
  String? id;
  String achievement;
  Achievement({this.id, required this.achievement});
  @override
  String toString() {
    return '\n$achievement \n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'achievement': achievement,
    };
  }

  static Achievement fromMap(Map<String, dynamic> map) {
    return Achievement(
      achievement: map['achievement'],
      id: map['id'],
    );
  }
}

class Activity {
  String? id;
  String activity;
  Activity({this.id, required this.activity});
  @override
  String toString() {
    return '\n$activity \n';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'activity': activity,
    };
  }

  static Activity fromMap(Map<String, dynamic> activity) {
    return Activity(
      activity: activity['activity'],
      id: activity['id'],
    );
  }
}

class Resume {
  String id;
  Contact? contact;
  List<OnlineProfile>? onlineProfiles;
  List<Education>? educations;
  List<WorkExperience>? workExperiences;
  List<Skill>? skills;
  List<Project>? projects;
  List<Achievement>? acheivements;
  List<Activity>? activities;
  Map<dynamic, dynamic>? other;

  List get resumeObjects => [
        contact,
        workExperiences,
        projects,
        educations,
        onlineProfiles,
        skills,
        acheivements,
        activities,
        other,
      ];

  String projectsToString() {
    if (projects == null) return '';
    if (projects != null) {
      String text = '';
      for (var i = 0; i < projects!.length; i++) {
        text += ('\n${projects![i]}');
      }
      return text;
    }
    return '';
  }

  Resume({
    required this.id,
    this.contact,
    this.onlineProfiles,
    this.educations,
    this.workExperiences,
    this.skills,
    this.projects,
    this.acheivements,
    this.activities,
    this.other,
  });

  static Resume sampleRes = Resume(
    id: '0',
    contact: Contact(
      name: 'Alien Earth',
      email: 'alien.earth@gmail.com',
      phoneNumber: '+91 9876543210',
      city: 'City',
      province: 'State',
      country: 'Country',
    ),
    onlineProfiles: [
      OnlineProfile(platform: 'LinkedIn', link: 'https://linked.com'),
      OnlineProfile(platform: 'GitHub', link: 'https://github.com'),
      OnlineProfile(platform: 'LeetCode', link: 'https://leetcode.com')
    ],
    educations: [
      Education(
        institute: 'Some Institute of Technology',
        course: 'Electronics',
        programme: 'Bachelors',
        startDate: 'June 2020',
        endDate: 'June 2024',
        score: '9.1 CGPA',
      ),
      Education(
        institute: 'Massachusets Institute of Technology',
        course: 'Computer Science',
        programme: 'Bachelors',
        startDate: 'June 2020',
        endDate: 'June 2024',
        score: '9.1 CGPA',
      )
    ],
    workExperiences: [
      WorkExperience(
        companyName: 'Comapny Name',
        role: 'SDE 2',
        address: 'Somewhere',
        startDate: 'June 2022',
        endDate: 'Currently Working',
        workDone:
            '$bullet Implemented a new payment interface for users both at the admin side and the user side.'
            '$bullet Users receive a payment link over RazorPay APIs after generating a payment request.'
            '$bullet Implemented Google Maps Places API and Directions API to show a route between two selected locations.'
            '$bullet Solved a bug caused due to battery restrictions.',
      ),
    ],
    projects: [
      Project(
        projectName: 'Project Name',
        link: 'link',
        description:
            'Was it enough? That was the question he kept asking himself. Was being satisfied enough? He looked around him at everyone yearning to just be satisfied in their daily life and he had reached that goal. He knew that he was satisfied and he also knew it wasn\'t going to be enough.',
        tools: 'Lib rar win worr eyetst',
      ),
      Project(
        projectName: 'Project Name',
        link: 'link',
        description:
            'Was it enough? That was the question he kept asking himself. Was being satisfied enough? He looked around him at everyone yearning to just be satisfied in their daily life and he had reached that goal. He knew that he was satisfied and he also knew it wasn\'t going to be enough.',
        tools: 'Lib rar win worr eyetst',
      ),
    ],
    skills: [
      Skill(
          domain: 'Right',
          skills: 'Generating random paragraphs can be an excellent'),
      Skill(
          domain: 'Right',
          skills: 'Generating random paragraphs can be an excellent'),
      Skill(
          domain: 'Right',
          skills: 'Generating random paragraphs can be an excellent'),
      Skill(
          domain: 'Right',
          skills: 'Generating random paragraphs can be an excellent'),
    ],
    acheivements: [
      Achievement(
          achievement:
              'If you\'re looking for random randomrandomrandomrandom paragraphs, you\'ve come to the right place.'),
      Achievement(
          achievement:
              'If you\'re looking for random paragraphs, you\'ve come to the right place.'),
      Achievement(
          achievement:
              'If you\'re looking for random paragraphs, you\'ve come to the right place.'),
    ],
    activities: [
      Activity(
        activity:
            'Some thing sjhefui sefuybef uwefb sfb bescc sefgweufb bfcvjbvrbb ',
      ),
      Activity(
        activity:
            'Some thing sjhefui sefuybef uwefb sfb bescc sefgweufb bfcvjbvrbb ',
      ),
      Activity(
        activity:
            'Some thing sjhefui sefuybef uwefb sfb bescc sefgweufb bfcvjbvrbb ',
      ),
    ],
  );
}
