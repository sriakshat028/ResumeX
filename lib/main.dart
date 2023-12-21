import 'package:flutter/material.dart';
import 'package:resumex/screens/drawer/my_account.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './screens/forms/forms.dart';
import './providers/providers.dart';
import './screens/screens.dart';
import './models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => ResumeModelProvider()),
        ChangeNotifierProvider(create: (context) => InfosModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ResumeX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 24,
        ),
        drawerTheme: const DrawerThemeData(
          scrimColor: Color.fromARGB(114, 42, 82, 102),
          //backgroundColor: Color.fromARGB(255, 49, 48, 48),
        ),
      ),
      home: auth.currentAuthState == AuthState.loggedIn
          ? const HomeScreen()
          : const LoginScreen(),
      routes: {
        DisplayInfo.routeName: (context) => const DisplayInfo(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ContactForm.routeName: (context) => const ContactForm(),
        WorkForm.routeName: (context) => const WorkForm(),
        ProjectsForm.routeName: (context) => const ProjectsForm(),
        EducationForm.routeName: (context) => const EducationForm(),
        OnlineProfilesForm.routeName: (context) => const OnlineProfilesForm(),
        SkillsForm.routeName: (context) => const SkillsForm(),
        AchievementsForm.routeName: (context) => const AchievementsForm(),
        ActivitiesForm.routeName: (context) => const ActivitiesForm(),
        DisplayPdf.routeName: (context) => const DisplayPdf(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        MyAccount.routeName: (context) => const MyAccount(),
      },
    );
  }
}
