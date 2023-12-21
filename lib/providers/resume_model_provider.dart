import 'package:flutter/material.dart';
import 'package:resumex/database/database.dart';
import 'package:resumex/database/save_details.dart';
import 'package:resumex/models/resume_model.dart';

import '../database/get_data.dart';
import '../database/remove_data.dart';
import '../models/models.dart';

class ResumeModelProvider extends ChangeNotifier {
  final _resumes = [
    Resume(
      id: '0',
      workExperiences: [],
      acheivements: [],
      activities: [],
      educations: [],
      onlineProfiles: [],
      projects: [],
      skills: [],
    )
  ];
  List<Resume> get resumes => _resumes;
  String _currentResumeId = '';
  int _currentIndex = 0;
  String get currentResumeId => _currentResumeId;
  int get currentIndex => _currentIndex;
  bool _loading = false;
  bool get isLoading => _loading;
  final _db = Database();
  final _saveDetails = SaveDetails();
  final _getData = GetData();
  final _removeData = RemoveData();

  Resume currentResume() {
    return _resumes[_currentIndex];
  }

  ResumeModelProvider() {
    init();
  }
  init() async {
    _loading = true;
    notifyListeners();
    try {
      _resumes[currentIndex].contact = await _getData.getContact();
      _resumes[currentIndex].workExperiences = await _getData.getExperience();
      _resumes[currentIndex].projects = await _getData.getProjects();
      _resumes[currentIndex].educations = await _getData.getEducations();
      _resumes[currentIndex].onlineProfiles = await _getData.getProfiles();
      _resumes[currentIndex].skills = await _getData.getSkills();
      _resumes[currentIndex].acheivements = await _getData.getAchievement();
      _resumes[currentIndex].activities = await _getData.getActivity();
    } catch (e) {
      rethrow;
    }
    _loading = false;
    notifyListeners();
  }

  void addResume(Resume resume) {
    _resumes.add(resume);
    notifyListeners();
  }

  void removeResume(String id) {
    _resumes.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void changeCurrentResume(String id) {
    _currentResumeId = id;
    _currentIndex = int.parse(id);
    notifyListeners();
  }

  void testResume() {
    _resumes[0] = Resume.sampleRes;
    notifyListeners();
  }

  void addContact(String resumeId, Contact contact) {
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(Resume(
        id: _resumes.length.toString(),
        contact: contact,
      ));
      changeCurrentResume(_resumes.length.toString());
    } else {
      _resumes[index].contact = contact;
    }
    _db.updateContact(contact);
    notifyListeners();
  }

  void addExperience(String resumeId, WorkExperience experience, int idx) {
    final id = _saveDetails.saveExperience(experience);
    experience.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          workExperiences: [experience],
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].workExperiences == null) {
        _resumes[index].workExperiences = [experience];
      } else {
        if (idx >= _resumes[index].workExperiences!.length) {
          _resumes[index].workExperiences!.add(experience);
        } else {
          _resumes[index].workExperiences![idx] = experience;
        }
      }
    }
    notifyListeners();
  }

  void removeExperience(String resumeId, int idx, String experienceId) {
    _removeData.removeExperience(experienceId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].workExperiences != null &&
        idx < _resumes[index].workExperiences!.length) {
      _resumes[index].workExperiences!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addProject(String resumeId, Project project, int idx) {
    final id = _saveDetails.saveProject(project);
    project.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          projects: [project],
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].projects == null) {
        _resumes[index].projects = [(project)];
      } else {
        if (idx >= _resumes[index].projects!.length) {
          _resumes[index].projects!.add(project);
        } else {
          _resumes[index].projects![idx] = project;
        }
      }
    }
    notifyListeners();
  }

  void removeProject(String resumeId, int idx, String projectId) {
    _removeData.removeProjects(projectId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].projects != null &&
        idx < _resumes[index].projects!.length) {
      _resumes[index].projects!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addEducation(String resumeId, Education education, int idx) {
    final id = _saveDetails.saveEducation(education);
    education.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          educations: [education],
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].educations == null) {
        _resumes[index].educations = [(education)];
      } else {
        if (idx >= _resumes[index].educations!.length) {
          _resumes[index].educations!.add(education);
        } else {
          _resumes[index].educations![idx] = education;
        }
      }
    }
    notifyListeners();
  }

  void removeEducation(String resumeId, int idx, String educationId) {
    _removeData.removeEducataion(educationId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].educations != null &&
        idx < _resumes[index].educations!.length) {
      _resumes[index].educations!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addOnlineProfile(String resumeId, OnlineProfile onlineProfile, int idx) {
    final id = _saveDetails.saveOnlineProfile(onlineProfile);
    onlineProfile.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(Resume(
        id: _resumes.length.toString(),
        onlineProfiles: [onlineProfile],
      ));
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].onlineProfiles == null) {
        _resumes[index].onlineProfiles = [(onlineProfile)];
      } else {
        if (idx >= _resumes[index].onlineProfiles!.length) {
          _resumes[index].onlineProfiles!.add(onlineProfile);
        } else {
          _resumes[index].onlineProfiles![idx] = onlineProfile;
        }
      }
    }
    notifyListeners();
  }

  void removeOnlineProfile(String resumeId, int idx, String profileId) {
    _removeData.removeProfile(profileId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].onlineProfiles != null &&
        idx < _resumes[index].onlineProfiles!.length) {
      _resumes[index].onlineProfiles!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addSkill(String resumeId, Skill skill, int idx) {
    final id = _saveDetails.saveSkill(skill);
    skill.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          skills: [skill],
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].skills == null) {
        _resumes[index].skills = [(skill)];
      } else {
        if (idx >= _resumes[index].skills!.length) {
          _resumes[index].skills!.add(skill);
        } else {
          _resumes[index].skills![idx] = skill;
        }
      }
    }
    notifyListeners();
  }

  void removeSkills(String resumeId, int idx, String skillId) {
    _removeData.removeSkill(skillId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].skills != null &&
        idx < _resumes[index].skills!.length) {
      _resumes[index].skills!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addAcheievement(String resumeId, Achievement achievement, int idx) {
    final id = _saveDetails.saveAchievement(achievement);
    achievement.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          acheivements: [achievement],
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].acheivements == null) {
        _resumes[index].acheivements = [(achievement)];
      } else {
        if (idx >= _resumes[index].acheivements!.length) {
          _resumes[index].acheivements!.add(achievement);
        } else {
          _resumes[index].acheivements![idx] = achievement;
        }
      }
    }
    notifyListeners();
  }

  void removeAchievement(String resumeId, int idx, String achievementId) {
    _removeData.removeAchievement(achievementId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].acheivements != null &&
        idx < _resumes[index].acheivements!.length) {
      _resumes[index].acheivements!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addActivity(String resumeId, Activity activity, int idx) {
    final id = _saveDetails.saveActivity(activity);
    activity.id = id;
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          activities: [activity],
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      if (_resumes[index].activities == null) {
        _resumes[index].activities = [(activity)];
      } else {
        if (idx >= _resumes[index].activities!.length) {
          _resumes[index].activities!.add(activity);
        } else {
          _resumes[index].activities![idx] = activity;
        }
      }
    }
    notifyListeners();
  }

  void removeActivity(String resumeId, int idx, String activityId) {
    _removeData.removeActivity(activityId);
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index != -1 &&
        _resumes[index].activities != null &&
        idx < _resumes[index].activities!.length) {
      _resumes[index].activities!.removeAt(idx);
      debugPrint('Removed');
      notifyListeners();
    }
  }

  void addOther(String resumeId, Map<dynamic, dynamic> map) {
    int index = _resumes.indexWhere(
      (element) => resumeId == element.id,
    );
    if (index == -1) {
      _resumes.add(
        Resume(
          id: _resumes.length.toString(),
          other: map,
        ),
      );
      changeCurrentResume(_resumes.length.toString());
    } else {
      _resumes[index].other!.addEntries(map.entries);
    }
    notifyListeners();
  }
}

// class ResumeProvider extends ChangeNotifier {
//   late Resume _resume;
//   late String _resumeId;

//   Resume get resume => _resume;
//   String get resumeId => _resumeId;

//   final _db = Database();
//   final _saveDetails = SaveDetails();
//   final _getData = GetData();
//   final _removeData = RemoveData();

//   ResumeProvider() {
//     init();
//   }

//   init() {
//     _resumeId = _getData.getResumeId();
//     _resume = Resume(
//       id: _resumeId,
//       acheivements: _getData.getAchievement(),
//       activities: _getData.getActivity(),
//       contact: _getData.getContact(),
//       educations: _getData.getEducations(),
//       onlineProfiles: _getData.getProfiles(),
//       projects: _getData.getProjects(),
//       skills: _getData.getSkills(),
//       workExperiences: _getData.getExperience(),
//     );
//     notifyListeners();
//   }
// }
