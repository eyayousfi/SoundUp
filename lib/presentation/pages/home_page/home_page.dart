import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sptify/presentation/pages/home_page/widgets/news_songs.dart';
import 'package:sptify/presentation/pages/home_page/widgets/play_list.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../profile/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const ProfilePage()),
            );
          },
          icon: const Icon(Icons.person ,color: Color (0xFFFF3EA5) ),
        ),
      ),
      body: Container(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _headerText("New Songs"),
                const SizedBox(height: 20),
                const NewsSongs(), // Display new songs list
                const SizedBox(height: 30),
                _headerText("Playlists"),
                const SizedBox(height: 5),
                const PlayList(),   // Display playlist
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
