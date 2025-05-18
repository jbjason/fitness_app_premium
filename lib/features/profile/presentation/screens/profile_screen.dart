// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
      ),
      bottomNavigationBar: ProfileNavbar(),
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

// class CustomNavBar extends StatelessWidget {
//   const CustomNavBar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Icon(Icons.home, color: Colors.amber),
//           Icon(Icons.store, color: Colors.grey),
//           CircleAvatar(
//             backgroundColor: Colors.amber,
//             child: Icon(Icons.pets, color: Colors.white),
//           ),
//           Icon(Icons.chat, color: Colors.grey),
//           Icon(Icons.person, color: Colors.grey),
//         ],
//       ),
//     );
//   }
// }

class ProfileNavbar extends StatelessWidget {
  const ProfileNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight * 1.9,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background with Custom Painter
          Positioned(
            bottom: -5,
            top: 0,
            left: 6,
            right: 6,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  kBottomNavigationBarHeight * 1.8),
              painter: BottomNavPainter(
                  color: MyColor.accentColor, style: PaintingStyle.stroke),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  kBottomNavigationBarHeight * 1.8),
              painter: BottomNavPainter(
                  color: Colors.grey[850]!, style: PaintingStyle.fill),
            ),
          ),
          // Icons
          Positioned(
            bottom: 30,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home, color: Colors.grey, size: 30),
                Icon(Icons.store, color: Colors.grey, size: 30),
                SizedBox(width: 60), // Space for the central button
                Icon(Icons.chat, color: Colors.grey, size: 30),
                Icon(Icons.person, color: Colors.grey, size: 30),
              ],
            ),
          ),
          // Center Circular Button
          Positioned(
            bottom: 25,
            child: Container(
              height: 75,
              width: 75,
              padding: EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: MyColor.bluePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.pets, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  final Color color;
  final PaintingStyle style;
  const BottomNavPainter({required this.color, required this.style});

  @override
  void paint(Canvas canvas, Size size) {
    double h = size.height, w = size.width;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = style;

    final path = Path();
    path.moveTo(0, h / 2);
    path.cubicTo(0, -h * .3, w * .35, h * .35, w * .5, h * .27);
    path.cubicTo(w * .65, h * .32, w, -h * .3, w, h / 2);
    path.cubicTo(w, h * 1.15, w * .8, h * .85, w * .5, h * .85);
    path.cubicTo(w * .3, h * .8, 0, h * 1.15, 0, h / 2);
    path.close();
    canvas.drawPath(path, paint);

    // h = size.height;
    // w = size.width;
    // final paint2 = Paint()
    //   ..color = Colors.orange
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.stroke;
    // final path2 = Path();
    // path2.moveTo(0, h / 2);
    // path2.cubicTo(0, -h * .3, w * .35, h * .35, w * .5, h * .27);
    // path2.cubicTo(w * .65, h * .32, w, -h * .3, w, h / 2);
    // path2.cubicTo(w, h * 1.15, w * .8, h * .85, w * .5, h * .85);
    // path2.cubicTo(w * .3, h * .8, 0, h * 1.15, 0, h / 2);
    // path2.close();
    // canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
