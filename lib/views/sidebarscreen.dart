import 'package:course_app/common/content_heading_widget.dart';
import 'package:course_app/common/last_played_game_tile_widget.dart';
import 'package:course_app/common/rounded_image_widget.dart';
import 'package:course_app/model/friends.dart';
import 'package:course_app/model/image_asset.dart';
import 'package:course_app/model/last_played_game.dart';
import 'package:course_app/services/auth.dart';
import 'package:course_app/stylefiles/colors.dart';
import 'package:course_app/stylefiles/text_styles.dart';
import 'package:course_app/views/home_screen.dart';

import 'package:course_app/views/signup.dart';
import 'package:course_app/widgets/provider_widget.dart';
import 'package:flutter/material.dart';

class SidebarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
//    final logoHeight = screenHeight * 0.4;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(screenWidth * 0.4, 10),
            child: Transform.rotate(
              angle: -0.1,
              // child: SvgPicture.asset(
              //   logo,
              //   height: logoHeight,
              //   color: logoTintColor,
              // ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.menu, color: primaryTextColor),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                      ),
//                      Icon(
//                        Icons.search,
//                        color: primaryTextColor,
//                      ),
                      IconButton(
                        icon: Icon(Icons.undo),
                        onPressed: () async {
                          try {
                            AuthService auth = Provider.of(context).auth;
                            await auth.signOut();
                            print("Signed Out");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUP(
                                        authFormType: AuthFormType.signIn)));
                          } catch (e) {}
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            RoundedImageWidget(
                                imagePath: player1,
                                ranking: 39,
                                showRanking: true),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    FutureBuilder(
                                        future: Provider.of(context)
                                            .auth
                                            .getCurrentUser(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return displayUserInformation(context, snapshot);
                                          }else{
                                            return CircularProgressIndicator();
                                          }
                                        })
                                  ],
                                )
//                              RichText(
//                                text: TextSpan(
//                                  children: [
//                                    TextSpan(
//                                      text: 'Hello',
//                                      style: userNameTextStyle,
//                                    ),
//                                    TextSpan(text: '\n'),
//                                    TextSpan(text: "Jon Snow", style: userNameTextStyle),
//                                  ],
//                                ),
//                              ),
                                ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, bottom: 16, top: 16),
                        child: Material(
                          elevation: 4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                                bottom: 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "HOURS PLAYED",
                                      style: hoursPlayedLabelTextStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "297 Hours",
                                  style: hoursPlayedTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ContentHeadingWidget(heading: "Last View Tales"),
                      for (var i = 0; i < lastPlayedGames.length; i++)
                        LastPlayedGameTile(
                          lastPlayedGame: lastPlayedGames[i],
                          screenWidth: screenWidth,
                          gameProgress: lastPlayedGames[i].gameProgress,
                        ),
//                      ContentHeadingWidget(heading: "Friends"),
                    ],
                  ),
                ),
//                SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                  child: Padding(
//                    padding: const EdgeInsets.all(2.0),
//                    child: Row(
//                      children: <Widget>[
//                        for (var i = 0; i < friends.length; i++)
//                          RoundedImageWidget(
//                            imagePath: friends[i].imagePath,
//                            isOnline: friends[i].isOnline,
//                            name: friends[i].name,
//                          ),
//                      ],
//                    ),
//                  ),
//                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget displayUserInformation(context, snapshot){
    final user =snapshot.data;
    return Column(
      children: <Widget>[
        RichText (
    text: TextSpan(
      children: [
        TextSpan(
          text: '${user.displayName}',
          style: userNameTextStyle,
        ),
        TextSpan(text: '\n'),
        TextSpan(text: "${user.email}", style: TextStyle(
          fontSize: 16,
          color: Color(0xFFA0A5BD),
        ),),
      ],
    ),
        )

      ],

    );


      Text("${user.displayName}");

  }



}
