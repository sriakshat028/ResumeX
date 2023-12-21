import 'package:flutter/material.dart';
import 'package:resumex/models/models.dart';

class InfosModel extends ChangeNotifier {
  int _currentDesign = 0;
  int get currentDesign => _currentDesign;

  setDesign(String design) {
    final int index = ResumeDesign.sampleDesigns.indexWhere(
      (element) => design == element.name,
    );
    if (index != -1) {
      _currentDesign = index;
    }
  }

  final List<String> _infos = [
    'Contact',
    'Experience',
    'Project',
    'Education',
    'Online Profiles',
    'Skills',
    'Achievements',
    'Activities',
    // 'Other',
  ];

  int _trueCount = 0;

  final List<bool> _infosAvail = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    // false,
  ];

  final List<Color> _colors = [
    const Color.fromARGB(255, 26, 34, 78),
    const Color.fromARGB(255, 79, 55, 47),
    const Color.fromARGB(255, 61, 35, 107),
    const Color.fromARGB(255, 13, 41, 14),
    const Color.fromARGB(255, 62, 18, 69),
    const Color.fromARGB(255, 92, 29, 29),
    const Color.fromARGB(255, 54, 51, 4),
    const Color.fromARGB(255, 4, 47, 54),
    // const Color.fromARGB(255, 0, 0, 0),
  ];

  List<String> get infos => _infos;
  List<bool> get infosAvail => _infosAvail;
  List<Color> get colors => _colors;
  int get trueCount => _trueCount;

  void addInfo(String info, bool value) {
    // _infos.add(info);
    _infosAvail.add(value);
    _colors.add(Colors.black);
    notifyListeners();
  }

  void addAll() {
  }

  void removeInfo(String info) {
    int index = _infos.indexOf(info);
    if (index != -1) {
      _infosAvail[index] = false;
      _trueCount--;
    }
    notifyListeners();
  }

  void updateInfosAvail(bool value, String correspondence) {
    int index = _infos.indexOf(correspondence);
    if (index != -1) _infosAvail[index] = value;
    if (value) _trueCount++;
    if (!value) _trueCount--;

    notifyListeners();
  }
}
