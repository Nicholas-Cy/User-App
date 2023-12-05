import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../logic/cubit/theme_cubit.dart';
import '../../../types/job_post.dart';
import '../../../ui/job/index.dart';
import '../../../ui/theme_data/fonts.dart';
//this is the page that shows job applications like the words of jobs, company, salary
//this is styling for the jobs in job applicatoins page
class JobPostAppliedItem extends StatelessWidget {
  final JobPost jobPost;
  const JobPostAppliedItem({required Key key, required this.jobPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<SwitchCubit>();
    final isDarkThemeOn = themeCubit.state.isDarkThemeOn;

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JobPage(key: UniqueKey(), id: jobPost.id),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                width: 1,
                style: BorderStyle.solid,
                color: const Color.fromRGBO(216, 216, 216, 1.0),
              ),
            ),
            child: Image(
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
              image: NetworkImage(jobPost.image,
                  headers: {'Keep-Alive': 'timeout=5, max=1000'}),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180.0,
                child: Text(
                  jobPost.title,
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.jobItemName,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                jobPost.companyName,
                style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.jobItemCompanyName,
                  color: (isDarkThemeOn) ? Colors.white : null,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5.0),
              Text(
                jobPost.jobTypeAndLocation,
                style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.jobItemTypeAndLocation,
                  color: (isDarkThemeOn) ? Colors.white : null,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              jobPost.salaryInfo,
              softWrap: true,
              style: GoogleFonts.dmSans(
                textStyle: FontThemeData.jobItemSalary,
                color: (isDarkThemeOn) ? Colors.white : null,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

