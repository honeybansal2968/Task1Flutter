import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:thesurvey/authentication/data/repositories/users_repo.dart';
import 'package:thesurvey/authentication/presentation/pages/login.dart';
import 'package:thesurvey/authentication/presentation/pages/signup.dart';
import 'package:thesurvey/constants/colors.dart';
import 'package:thesurvey/controllers/questionController.dart';
import 'package:thesurvey/entites/survey_model.dart';
import 'package:thesurvey/models/questionModel.dart';
import 'package:thesurvey/pages/form_questions.dart';
import 'package:thesurvey/pages/profile_page.dart';
import 'package:thesurvey/pages/survey_cat.dart';
import 'package:thesurvey/services/test_survey_service.dart';
import '../../../constants/values.dart';
import '../utils/fonts.dart';
import '../utils/methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int total = 0;
  int ongoing = 0;
  int upcomming = 0;
  int completed = 0;

  List<Survey> allSurvey = [];

  initilizeValues() async {
    total = await getSurveyCount('total');
    ongoing = await getSurveyCount('ongoing');
    upcomming = await getSurveyCount('upcomming');
    completed = await getSurveyCount('completed');
    allSurvey = await getAllSurvey();
    setState(() {});
  }

  _moveToSurvey(String apiStr) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SurveyCat(
                  surveyCat: apiStr,
                )));
  }

  @override
  void initState() {
    super.initState();

    initilizeValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(top: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Center(
                      child: Image.asset(
                    logoPath,
                    height: 60,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding:
                        const EdgeInsets.only(top: 28, left: 20, right: 20),
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                          radius: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hello'),
                            Text(
                              'John Doe',
                              style: MainFonts.lableText(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: 1,
                    color: const Color(0xFFE6E8E7),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.dashboard_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text('Dashboard',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_border_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text('Ongoing Survey',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_border_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text('Completed Survey',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.settings_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text('Setting',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ProfileInfo())));
                    },
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text('Profile',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          contentPadding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: const Text('Want to Logout?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                updateLoginStatus(false);
                                clearSharedPrefs();
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.logout_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text('Logout',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/comlogo.png', height: 70),
                    const SizedBox(height: 6),
                    const Text(
                      'App version 1.0.1',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: Column(
          children: [
            Image.asset(
              logoPath,
              height: heightOfLogo,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    height: 40,
                    color: Colors.red,
                    child: Center(
                        child: Text(
                      'Notice Line ALL PAGES',
                      style: MainFonts.lableText(color: Colors.white),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Marceter!',
                          style: MainFonts.dashText(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                _moveToSurvey('all_surveys_api');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFB620CE),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/svg#Layer_1.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        const Text(
                                          'Total Survey',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(total.toString(),
                                            style: MainFonts.dashNoText()),
                                      ]),
                                ),
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                _moveToSurvey('surveys_get_api');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/svg#Layer_1.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        const Text(
                                          'Ongoing Survey',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(ongoing.toString(),
                                            style: MainFonts.dashNoText()),
                                      ]),
                                ),
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                _moveToSurvey('upcoming_get_api');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: thirdColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/svg#Layer_1.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        const Text(
                                          'Upcoming Survey\'s',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(upcomming.toString(),
                                            style: MainFonts.dashNoText()),
                                      ]),
                                ),
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                _moveToSurvey('gets_survey_ans_api');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: fourthColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/svg#Layer_1.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        const Text(
                                          'Completed Survey\'s',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(completed.toString(),
                                            style: MainFonts.dashNoText()),
                                      ]),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]))
          ];
        },
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Last Activites',
                style: MainFonts.dashText(),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allSurvey.length,
                  itemBuilder: (context, index) {
                    Survey survey = allSurvey[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                           
                            List<QuestionModel> questions =
                                await TestSurveyService.fetchQuestions();
                                
                            Get.to(() => QuestionPage(questions: questions));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: listColors[index % listColors.length],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Image.asset(
                                'assets/images/school.png',
                                height: 100,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      survey.surveyName ?? '',
                                      style: MainFonts.pageTitleText(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      survey.description ?? '',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Start Date: ${survey.createdAt != null ? survey.createdAt!.substring(0, 10) : ''}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      'End Date: ${survey.date != null ? survey.date!.substring(0, 10) : ''}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
