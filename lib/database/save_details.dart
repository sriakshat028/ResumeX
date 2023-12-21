import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resumex/database/database.dart';

import '../functions/function.dart';
import '../models/resume_model.dart';

class SaveDetails extends Database {
  saveContact(Contact contact) {
    final data = contact.toMap();
    detailsCol
        .doc('contact')
        .update(data)
        .onError((error, stackTrace) => dprint(error))
        .then(
          (value) => dprint('Success'),
        );
  }

  String saveExperience(WorkExperience experience) {
    detailsCol.doc('workexperience').set({}, SetOptions(merge: true));
    dprint('Saving Experience...');
    final id = experience.id ??
        detailsCol.doc('workexperience').collection('workexperience').doc().id;
    experience.id = id;
    final data = experience.toMap();
    detailsCol
        .doc('workexperience')
        .collection('workexperience')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Saved Successfully'));
    return id;
  }

  String saveProject(Project project) {
    dprint('Saving projects');
    final id = project.id ??
        detailsCol.doc('projects').collection('projects').doc().id;
    project.id = id;
    final data = project.toMap();
    detailsCol
        .doc('projects')
        .collection('projects')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then(
          (_) => dprint('Successfuly saved project'),
        );
    return id;
  }

  String saveEducation(Education education) {
    detailsCol.doc('educations').set({}, SetOptions(merge: true));
    dprint('Saving education...');
    final id = education.id ??
        detailsCol.doc('educations').collection('educations').doc().id;

    final data = education.toMap();
    detailsCol
        .doc('educations')
        .collection('educations')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successful'));

    return id;
  }

  String saveOnlineProfile(OnlineProfile profile) {
    detailsCol.doc('onlineprofiles').set({}, SetOptions(merge: true));
    dprint('Saving profile...');
    final id = profile.id ??
        detailsCol.doc('onlineprofiles').collection('onlineprofiles').doc().id;
    profile.id = id;
    final data = profile.toMap();
    detailsCol
        .doc('onlineprofiles')
        .collection('onlineprofiles')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successful'));

    return id;
  }

  String saveSkill(Skill skill) {
    detailsCol.doc('skills').set({}, SetOptions(merge: true));
    dprint('Saving skill...');
    final id =
        skill.id ?? detailsCol.doc('skills').collection('skills').doc().id;
    skill.id = id;
    final data = skill.toMap();
    detailsCol
        .doc('skills')
        .collection('skills')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successful'));

    return id;
  }

  String saveAchievement(Achievement achievement) {
    detailsCol.doc('achievements').set({}, SetOptions(merge: true));
    dprint('Saving skill...');
    final id = achievement.id ??
        detailsCol.doc('achievements').collection('achievements').doc().id;
    achievement.id = id;
    final data = achievement.toMap();
    detailsCol
        .doc('achievements')
        .collection('achievements')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successful'));

    return id;
  }

  String saveActivity(Activity activity) {
    detailsCol.doc('activities').set({}, SetOptions(merge: true));
    dprint('Saving activity...');
    final id = activity.id ??
        detailsCol.doc('activities').collection('activities').doc().id;
    activity.id = id;
    final data = activity.toMap();
    detailsCol
        .doc('activities')
        .collection('activities')
        .doc(id)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successful'));

    return id;
  }
}
