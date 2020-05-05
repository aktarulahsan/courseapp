import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/constants.dart';
import 'package:course_app/model/category.dart';
import 'package:course_app/stylefiles/colors.dart';

import 'package:course_app/views/details_screen.dart';
import 'package:course_app/views/sidebarscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  Firestore db = Firestore.instance;

  HomeScreen();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: SidebarScreen(),
        ),


//      drawer: SizedBox(
//        width: size.width,
//        child: Drawer(
//          child: SidebarScreen(),
//        ),
//      ),
//      appBar: new AppBar(
//        title: new Text("Courses Demo"),
//
//      ),courseapp
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
//                RaisedButton(
//                  child: Icon(Icons.menu, color: primaryTextColor),
//                  onPressed: (){
//                    Scaffold.of(context).openDrawer();
//                  },
//                ),

                InkWell(
///  ai jaykay hobe
                   child: Icon(Icons.menu, color: primaryTextColor),
                   onTap: () {
                     _scaffoldKey.currentState.openDrawer();
                   },
                    ),

                Image.asset("assets/images/user.png"),
                // Icon(
                //   Icons.search,
                //   color: primaryTextColor,
                // )

                // SvgPicture.asset("assets/icons/menu.svg"),
                // Image.asset("assets/images/user.png"),
              ],
            ),
            SizedBox(height: 30),
            Text("Hey Alex,", style: kHeadingextStyle),
            Text("Find a course you want to learn", style: kSubheadingextStyle),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/search.svg"),
                  SizedBox(width: 16),
                  Text(
                    "Search for anything",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFA0A5BD),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Episodes", style: kTitleTextStyle),
                Text(
                  "See All",
                  style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection("books").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return StaggeredGridView.countBuilder(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 2,
                      itemCount: snapshot.data.documents.length,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return DetailsScreen(
                                  snapshot.data.documents[index]["book_id"]);
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: index.isEven ? 180 : 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(categories[index].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data.documents[index]["name"],
                                  style: kTitleTextStyle,
                                ),
                                Text(
                                  snapshot.data.documents[index]["courses"]+" "+ "Episodes",
                                  style: TextStyle(
                                    color: kTextColor.withOpacity(.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
