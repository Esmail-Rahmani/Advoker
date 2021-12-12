import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ylc/models/local/category_model.dart';
import 'package:ylc/values/colors.dart';
import 'package:ylc/values/images.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel model;
  final VoidCallback onTap;
  final isSelected;


  const CategoryCard({Key key, this.model, this.onTap, this.isSelected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _random = Random();

    return LayoutBuilder(
      builder: (_, constraints) => InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? Colors.green : Colors.grey[100], width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  GeneralImages.category_corner,
                  color: Color.fromARGB(
                      _random.nextInt(256),
                      _random.nextInt(256),
                      _random.nextInt(256),
                      _random.nextInt(256)
                  ),
                  width: 70,

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(7.0,19,8,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(model.image ,
                      height: 50,
                    ) ,
                    Spacer(),
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: Text(
                        model.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = YlcColors.categoryForeGround.withOpacity(0.5);

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.07, size.height * 0.71,
        size.width * 0.1, size.height * 0.69);
    path.lineTo(size.height * 0.7, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CategoryPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CategoryPainter oldDelegate) => false;
}
