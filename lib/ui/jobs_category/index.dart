import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../components/main/drawer.dart';
import '../../components/shared/jobs/job_post.dart';
import '../../data/auth.dart';
import '../../types/job_post_compact.dart';
import '../../types/navigation.dart';
import '../../ui/homepage/index.dart';
import '../../ui/theme_data/fonts.dart';
import '../../utils/constants.dart';

class JobsCategory extends StatefulWidget {
  final int id;
  final String name;
  const JobsCategory({required Key key, required this.id, required this.name})
      : super(key: key);

  @override
  State<JobsCategory> createState() => _JobsCategoryState();
}

class _JobsCategoryState extends State<JobsCategory> {
  late Future<List<JobPostCompact>> jobs;

  Future<List<JobPostCompact>> loadJobs(BuildContext ctx) async {
    List<JobPostCompact> jobs = [];
    String? token =
        await Provider.of<AuthProvider>(ctx, listen: false).getToken();
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.CAGEGORY_JOBS}?category_id=${widget.id}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      data["data"].forEach(
        (jobpost) => {
          jobs.add(
            JobPostCompact.fromJson(jobpost),
          ),
        },
      );

      return jobs;
    } else {
      throw Exception('Problem loading jobs.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
              SizedBox(
                width: 130.0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jobs by Category: ${widget.name}",
                    style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.sectionTitles,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: height,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 150.0),
                  child: FutureBuilder<List<JobPostCompact>>(
                    future: loadJobs(context),
                    builder: (context, future) {
                      if (!future.hasData) {
                        return Container();
                      } else {
                        List<JobPostCompact>? jobs = future.data;
                        return (jobs!.isNotEmpty)
                            ? ListView.builder(
                                // Removes scroll overflow glow (material design)
                                physics: const BouncingScrollPhysics(),
                                itemCount: jobs.length,
                                itemBuilder: (_, i) {
                                  return JobPost(
                                      key: UniqueKey(), jobPost: jobs[i]);
                                },
                              )
                            : const Text("No Job Posts Found.");
                      }
                    },
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
