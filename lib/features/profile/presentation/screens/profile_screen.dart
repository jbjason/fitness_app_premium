import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:fitness_app_premium/features/profile/presentation/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';

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
              Image.asset(MyImage.maleModelImg,height: 200,),
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
    return Container(
      color: Colors.red,
      height: kBottomNavigationBarHeight*2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background with Custom Painter
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 80),
              painter: BottomNavPainter(),
            ),
          ),
          // Icons
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
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
            bottom: 35,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(Icons.pets, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.4, 0);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width * 0.5, 20);
    path.arcToPoint(
      Offset(size.width * 0.6, 20),
      radius: Radius.circular(20),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.75, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
