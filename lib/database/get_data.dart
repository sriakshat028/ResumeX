import 'package:resumex/database/database.dart';

import '../functions/function.dart';
import '../models/resume_model.dart';

class GetData extends Database {
  String getResumeId() {
    dprint('Fetching resume Id');
    String id = '';
    userDoc.get().then((value) {
      id = value.data()!['currentresumeid'];
    });
    return id;
  }

  Future<Contact> getContact() async {
    dprint('Fetching Contact');
    Contact contact = Contact(
      name: '',
      email: '',
      phoneNumber: '',
      city: '',
      province: '',
      country: '',
    );
    await detailsCol.doc('contact').get().then((value) {
      dprint('Here goes the contact');
      dprint(value.data());
      contact = Contact.fromMap(value.data() ?? {});
    });
    dprint('Fetched Contacts successfully');
    return contact;
  }

  Future<List<WorkExperience>> getExperience() async {
    dprint('Fetching Experiences');
    List<WorkExperience> experience = [];
    await detailsCol
        .doc('workexperience')
        .collection('workexperience')
        .get()
        .then((value) {
          for (var element in value.docs) {
            experience.add(WorkExperience.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Fetched Experiences Successfuly'));
    return experience;
  }

  Future<List<Project>> getProjects() async {
    dprint('Fetching projects');
    List<Project> projects = [];
    await detailsCol
        .doc('projects')
        .collection('projects')
        .get()
        .then((value) {
          for (var element in value.docs) {
            projects.add(Project.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Success'));
    return projects;
  }

  Future<List<Education>> getEducations() async {
    dprint("Trying to get education");
    List<Education> educations = [];
    await detailsCol
        .doc('educations')
        .collection('educations')
        .get()
        .then((value) {
          for (var element in value.docs) {
            educations.add(Education.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Success'));
    return educations;
  }

  Future<List<OnlineProfile>> getProfiles() async {
    dprint("Trying to get profiles");
    List<OnlineProfile> profiles = [];
    await detailsCol
        .doc('onlineprofiles')
        .collection('onlineprofiles')
        .get()
        .then((value) {
          for (var element in value.docs) {
            profiles.add(OnlineProfile.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Success'));
    return profiles;
  }

  Future<List<Skill>> getSkills() async {
    dprint("Trying to get skills");
    List<Skill> skills = [];
    await detailsCol
        .doc('skills')
        .collection('skills')
        .get()
        .then((value) {
          for (var element in value.docs) {
            skills.add(Skill.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Success'));
    return skills;
  }

  Future<List<Achievement>> getAchievement() async {
    dprint("Trying to get avhievements");
    List<Achievement> achievements = [];
    await detailsCol
        .doc('achievements')
        .collection('achievements')
        .get()
        .then((value) {
          for (var element in value.docs) {
            achievements.add(Achievement.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successfully fetched achievements'));
    return achievements;
  }

  Future<List<Activity>> getActivity() async {
    dprint("Trying to get activities");
    List<Activity> activities = [];
    await detailsCol
        .doc('activities')
        .collection('activities')
        .get()
        .then((value) {
          for (var element in value.docs) {
            activities.add(Activity.fromMap(element.data()));
          }
        })
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Success'));
    return activities;
  }
}
