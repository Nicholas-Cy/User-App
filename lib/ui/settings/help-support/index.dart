import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/main/drawer.dart';
import '../../../types/navigation.dart';
import '../../../utils/constants.dart';
import '../../theme_data/fonts.dart';
import '../index.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final contactUs = Uri.parse("${AppConstants.STATIC_WEB_URL}/contact-us");
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Image(
            width: 85.0,
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      drawer: PageDrawer(key: UniqueKey(), page: PAGES.explore),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 15.0),
              SizedBox(
                width: 130.0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          "Go Back",
                          style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.btnText,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: width - 40.0,
                child: Text(
                  "Help & Support",
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.sectionTitles,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              InkWell(
                onTap: () {
                  _launchURL(contactUs);
                },
                child: SizedBox(
                  width: width - 140.0,
                  child: Text(
                    "Contact Us",
                    style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.settingsListItemPrimary,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
