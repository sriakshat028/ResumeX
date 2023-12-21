import 'package:resumex/database/database.dart';

import '../functions/function.dart';

class RemoveData extends Database {
  removeExperience(String id) {
    dprint('Trying to delete an experience with $id');
    detailsCol
        .doc('workexperience')
        .collection('workexperience')
        .doc(id)
        .delete()
        .onError((error, stackTrace) => dprint(error))
        .then((value) => {dprint('Successfully deleted')});
  }

  removeProjects(String id) {
    detailsCol.doc('projects').collection('projects').doc(id).delete();
  }

  removeEducataion(String id) {
    dprint('Deleting Education');
    detailsCol
        .doc('educations')
        .collection('educations')
        .doc(id)
        .delete()
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successfully deleted'));
  }

  removeProfile(String id) {
    dprint('Deleting online profile');
    detailsCol
        .doc('onlineprofiles')
        .collection('onlineprofiles')
        .doc(id)
        .delete()
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successfully deleted'));
  }

  removeSkill(String id) {
    dprint('Deleting skill');
    detailsCol
        .doc('skills')
        .collection('skills')
        .doc(id)
        .delete()
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successfully deleted'));
  }

  removeAchievement(String id) {
    dprint('Deleting Achievement');
    detailsCol
        .doc('achievements')
        .collection('achievements')
        .doc(id)
        .delete()
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successfully deleted'));
  }

  removeActivity(String id) {
    dprint('Deleting activity');
    detailsCol
        .doc('activities')
        .collection('activities')
        .doc(id)
        .delete()
        .onError((error, stackTrace) => dprint(error))
        .then((_) => dprint('Successfully deleted'));
  }
}