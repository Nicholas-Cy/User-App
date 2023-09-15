import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../logic/cubit/theme_cubit.dart';
import '../../../types/blogpost.dart';
import '../../post/index.dart';
import '../../theme_data/fonts.dart';

class BlogPostTile extends StatelessWidget {
  final BlogPost blogPost;
  const BlogPostTile({required Key key, required this.blogPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeCubit = context.read<SwitchCubit>();
    final isDarkThemeOn = themeCubit.state.isDarkThemeOn;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: width,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  PostPage(key: UniqueKey(), blogPost: blogPost),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(blogPost.image,
                  headers: {'Keep-Alive': 'timeout=5, max=1000'}),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    width: width - 150.0,
                    child: Text(
                      blogPost.title,
                      style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.blogPostTitle,
                        color: (isDarkThemeOn)
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat("d MMMM y").format(
                        DateFormat("dd-M-yyyy hh:mm:ss").parse(blogPost.date),
                      ),
                      style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.blogPostDate,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
