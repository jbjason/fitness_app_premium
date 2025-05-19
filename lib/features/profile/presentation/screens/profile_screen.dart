// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          // Header Profile Section
          ProfileAppbar(),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.amber, Colors.orange],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          //   child: Column(
          //     children: [
          //       CircleAvatar(
          //         radius: 40,
          //         backgroundImage: AssetImage(MyImage.trainerImg),
          //       ),
          //       SizedBox(height: 10),
          //       Text('SOSO',
          //           style: TextStyle(
          //               fontSize: 22,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white)),
          //       Text('British short hair',
          //           style: TextStyle(color: Colors.white70)),
          //       SizedBox(height: 5),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text('Male · ', style: TextStyle(color: Colors.white70)),
          //           Text('3 years old · ',
          //               style: TextStyle(color: Colors.white70)),
          //           Text('5 lbs', style: TextStyle(color: Colors.white70)),
          //         ],
          //       ),
          //       SizedBox(height: 20),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Column(
          //             children: [
          //               Text('2',
          //                   style: TextStyle(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white)),
          //               Text('Post', style: TextStyle(color: Colors.white70)),
          //             ],
          //           ),
          //           Column(
          //             children: [
          //               Text('20K',
          //                   style: TextStyle(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white)),
          //               Text('Followers',
          //                   style: TextStyle(color: Colors.white70)),
          //             ],
          //           ),
          //           Column(
          //             children: [
          //               Text('12',
          //                   style: TextStyle(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white)),
          //               Text('Following',
          //                   style: TextStyle(color: Colors.white70)),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // Tab Bar
          TabBarSection(),
          // Post Section
          Expanded(child: PostSection()),
          // Bottom Navigation Bar
        ],
   
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TabButton(title: 'Activity', isActive: true),
          TabButton(title: 'Tags', isActive: false),
          TabButton(title: 'About', isActive: false),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  const TabButton({super.key, required this.title, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.amber : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Post Card
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              ListTile(
                title: Text('This adorable cat with its guitar...'),
                subtitle: Text('2 Days ago'),
              ),
              Image.asset(
                MyImage.maleModelImg,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 5),
                        Text('450'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, color: Colors.grey),
                        SizedBox(width: 5),
                        Text('146'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

