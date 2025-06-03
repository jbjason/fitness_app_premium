import 'package:fitness_app_premium/config/extension/media_query_extension.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar(
      {super.key, required this.currentPage, required this.onPageChange});
  final int currentPage;
  final Function onPageChange;

  @override
  Widget build(BuildContext context) {
    final navItemTitles = ['Home', 'Report', "", 'Schedule', 'Profile'];
    final navItemImages = [
      MyImage.homeIconImg,
      MyImage.appointmentIconImg,
      "",
      MyImage.patientIconImg,
      MyImage.profileIconImg
    ];
    final navItemSelectedImages = [
      MyImage.homeIconFillImg,
      MyImage.appointmentIconFillImg,
      "",
      MyImage.patientIconFillImg,
      MyImage.profileIconFillImg
    ];
    return SizedBox(
      height: kBottomNavigationBarHeight * 1.5,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // orange border
          Positioned(
            bottom: 0,
            top: -5,
            left: 2,
            right: 2,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  kBottomNavigationBarHeight * 1.5),
              painter: BottomNavPainter(
                  color: MyColor.accentColor, style: PaintingStyle.stroke),
            ),
          ),
          // black border
          Positioned(
            top: 0,
            bottom: 5,
            left: 5,
            right: 5,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  kBottomNavigationBarHeight * 1.3),
              painter: BottomNavPainter(
                  color: Colors.grey[850]!, style: PaintingStyle.fill),
            ),
          ),
          // nav-Icons
          Positioned(
            bottom: 22,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                navItemTitles.length,
                (i) => i == 2
                    ? SizedBox(width: 20)
                    : _getNavBarItem(
                        index: i,
                        color: currentPage == i
                            ? Colors.white
                            : Colors.grey,
                        img: currentPage == i
                            ? navItemSelectedImages[i]
                            : navItemImages[i],
                        imgWidth: 21,
                        title: navItemTitles[i],
                        width: context.screenWidth-30 / navItemTitles.length,
                      ),
              ),
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
                  color: MyColor.accentColor,
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

  Widget _getNavBarItem({
    required int index,
    required Color color,
    required String img,
    required double imgWidth,
    required String title,
    required double width
  }) =>
      GestureDetector(
        onTap: () => onPageChange(index),
        child: Container(
          // width: width,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(img, width: imgWidth, color: color),
              const SizedBox(height: 3),
              FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                      color: color, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
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
    path.cubicTo(-10, -h * .3, w * .35, h * .25, w * .5, h * .2);
    path.cubicTo(w * .65, h * .32, w, -h * .3, w, h / 2);
    path.cubicTo(w, h * 1.15, w * .8, h * .85, w * .5, h * .85);
    path.cubicTo(w * .3, h * .8, -10, h * 1.2, 0, h / 2);
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
