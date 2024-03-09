import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../types/job_post.dart';


import '../../data/job.dart';
import './sections/blog/index.dart';
import './sections/categories/index.dart';
import './sections/companies/index.dart';
import './sections/jobs/index.dart';
import './sections/welcome.dart';
import '../../components/main/drawer.dart';
import '../../types/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: <Widget>[
             Container(
               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: Image.asset('assets/images/logo.png', width: 80),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){

            },
          )
        ]
        ,centerTitle: true,
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme
            .of(context)
            .primaryColor),
      ),
      // body: new Column(
      //   children: <Widget>[
      //     new Container(
      //       color: Colors.grey,
      //       child: new Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: new Card(
      //           child: ListTile(
      //             leading: Icon(Icons.search),
      //             title: new TextField(
      //               controller: controller,
      //               decoration: new InputDecoration(
      //                 hintText: 'Search', border: InputBorder.none),
      //               onChanged: onSearchTextChanged,
      //               ),
      //             trailing: new IconButton(
      //                 icon: new Icon(Icons.cancel),
      //               onPressed: (){
      //                   controller.clear();
      //                   onSearchTextChanged('');
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     new Expanded(
      //       child: _searchResult.length !=0 || controller.text.isNotEmpty
      //           ? new ListView.builder(
      //           itemCount: _searchResult.length,
      //       itemBuilder: (context, i){
      //             return new Card(
      //           child: new ListTile(
      //             title: new Text(
      //             _searchResult[i].title,
      //             style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             color: Colors.purpleAccent),
      //              ),
      //
      //             ),
      //             );
      //       },
      //       ),
      //     ),
      //   ],
      // ),
      drawer: PageDrawer(key: UniqueKey(), page: PAGES.home),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          color: Theme
              .of(context)
              .backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              SizedBox(height: 10.0),
              WelcomeHomeSection(),
              SizedBox(height: 10.0),
              JobCategoriesList(),
              SizedBox(height: 10.0),
              CompaniesList(),
              SizedBox(height: 10.0),
              HomeBlog(),
              SizedBox(height: 10.0),
              ExploreJobs(),
            ],
          ),
        ),
      ),
    );
  }
}

