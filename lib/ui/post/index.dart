import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../logic/cubit/theme_cubit.dart';
import '../../components/main/drawer.dart';
import '../../types/blogpost.dart';
import '../../types/navigation.dart';
import '../../utils/constants.dart';
import '../theme_data/fonts.dart';

class PostPage extends StatelessWidget {
  final BlogPost blogPost;
  const PostPage({required Key key, required this.blogPost}) : super(key: key);

  _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri url =
        Uri.parse("${AppConstants.STATIC_WEB_URL}/blog/${blogPost.slug}");
    final themeCubit = context.read<SwitchCubit>();
    final isDarkThemeOn = themeCubit.state.isDarkThemeOn;

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
        drawer: PageDrawer(key: UniqueKey(), page: PAGES.blog),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 15.0),
                Text(
                  blogPost.title,
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.blogPostPageTitle,
                    color:
                        (isDarkThemeOn) ? Theme.of(context).primaryColor : null,
                  ),
                ),
                const SizedBox(height: 15.0),
                Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(blogPost.image,
                      headers: {'Keep-Alive': 'timeout=5, max=1000'}),
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Text(
                      DateFormat("d MMMM yyyy").format(
                        DateFormat("dd-M-yyyy hh:mm:ss").parse(blogPost.date),
                      ),
                      style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.blogPostPageDate,
                        color: (isDarkThemeOn)
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Text(
                  blogPost.body,
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.blogPostPageText,
                    color:
                        (isDarkThemeOn) ? Theme.of(context).primaryColor : null,
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: 100.0,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: (isDarkThemeOn) ? Colors.grey : Colors.white,
            border: const Border(
              top: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Color.fromRGBO(216, 216, 216, 1.0),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Text(
                "Share this on",
                style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.blogPostPageText,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        _launchURL(Uri.parse(
                            "https://www.facebook.com/sharer/sharer.php?u=$url"));
                      },
                      child: const Image(
                        width: 40.0,
                        height: 40.0,
                        image: AssetImage('assets/icons/sharer/facebook.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        _launchURL(Uri.parse(
                            "https://www.linkedin.com/sharing/share-offsite/?url=$url"));
                      },
                      child: const Image(
                        width: 40.0,
                        height: 40.0,
                        image: AssetImage('assets/icons/sharer/linkedin.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        _launchURL(
                            Uri.parse("https://twitter.com/share?url=$url"));
                      },
                      child: const Image(
                        width: 40.0,
                        height: 40.0,
                        image: AssetImage('assets/icons/sharer/twitter.png'),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
