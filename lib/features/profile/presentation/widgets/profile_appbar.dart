import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_image.dart';
import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [MyColor.accentColor, MyColor.primaryColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35))),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: MediaQuery.of(context).padding.top + 10,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                                width: 2, color: MyColor.accentColor),
                          ),
                          child: Icon(Icons.arrow_back_ios, size: 18),
                        ),
                      ),
                      Text("Profile"),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                                width: 2, color: MyColor.accentColor),
                          ),
                          child: Icon(Icons.more_vert, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(MyImage.trainerImg),
                      ),
                      Spacer(),
                      ...[
                        Column(
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('Post'),
                          ],
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(color: MyColor.accentColor),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              '20K',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('Followers'),
                          ],
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(color: MyColor.accentColor),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              '12',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('Following'),
                          ],
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'SOSO',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text('British short hair'),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text('Male · '),
                      Text('3 years old · '),
                      Text('5 lbs'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
