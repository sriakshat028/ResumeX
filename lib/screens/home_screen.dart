import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:resumex/screens/display_info.dart';
import 'package:resumex/screens/drawer/my_account.dart';
import '../models/profession_model.dart';
import '../providers/providers.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  static final CarouselController _carouselController = CarouselController();

  // Sample Data to work with
  static final List<ResumeDesign> sampleDesigns = ResumeDesign.sampleDesigns;
  //static final sampleUser = UserModel.sampleUser;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    final user = Provider.of<UserModel>(context);
    // final res = Provider.of<ResumeModelProvider>(context);

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      // leading: Builder(
      //   builder: (context) {
      //     return IconButton(
      //       icon: const Icon(
      //         Icons.subject,
      //         color: Colors.black,
      //       ),
      //       onPressed: () => Scaffold.of(context).openDrawer(),
      //     );
      //   },
      // ),
      title: const Text(
        'ResumeX',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w300,
          letterSpacing: 1,
        ),
      ),
    );
    final appBarHeight = appBar.preferredSize.height;
    final bodyHeight = MediaQuery.of(context).size.height - appBarHeight;
    final bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SizedBox(
        height: bodyHeight,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                height: bodyHeight * .50,
              ),
              itemCount: sampleDesigns.length,
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                ResumeDesign design = sampleDesigns[index];
                return ResumeSlides(
                  design: design,
                  bodyWidth: bodyWidth,
                  bodyHeight: bodyHeight,
                );
              },
              carouselController: _carouselController,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 100.0, left: 100, bottom: 8),
              child: ChipButton(
                color: Colors.black,
                text: 'Quick Resume',
                onPressed: () {
                  Navigator.of(context).pushNamed(DisplayInfo.routeName);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, bottom: 10),
              child: HeadingText(color: Colors.black, text: 'Tips: '),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: InfoText(
                title: '1. Look for keywords in the job posting '
                    '\n2. Review resume examples for your industry'
                    '\n3. Make it simple and easy to read.'
                    '\n4. Make it brief and Include Numbers'
                    '\n5. Include only relevant information and put it first'
                    '\n6. Use active language'
                    '\n7. Call attention to important achievements'
                    '\n8. Only include subheadings and sections you need'
                    '\n9. Choose appropriate margins'
                    '\n10. Proofread and edit'
                    '\n11. Decide whether you need a unique resume for different jobs',
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      // drawer: HomeDrawer(user: user, auth: auth),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.user,
    required this.auth,
  }) : super(key: key);

  final UserModel user;
  final Authentication auth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 42, 82, 102),
            ),
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.grey,
                      size: 48,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.name ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.document_scanner),
            onTap: () {},
            title: const InfoText2(
              title: 'My Resumes',
              color: Colors.black,
            ),
            minLeadingWidth: 10,
            style: ListTileStyle.list,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            onTap: () {},
            title: const InfoText2(
              title: 'Settings',
              color: Colors.black,
            ),
            minLeadingWidth: 10,
            style: ListTileStyle.list,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            onTap: () {
              Navigator.pushNamed(context, MyAccount.routeName);
            },
            title: const InfoText2(
              title: 'My Account',
              color: Colors.black,
            ),
            minLeadingWidth: 10,
            style: ListTileStyle.list,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            onTap: () {
              auth.signOut();
            },
            title: const InfoText2(
              title: 'Log Out',
              color: Colors.black,
            ),
            minLeadingWidth: 10,
            style: ListTileStyle.list,
          ),
        ],
      ),
    );
  }
}
