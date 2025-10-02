import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/home/widgets/articale_card.dart';

class ArticaleCardList extends StatelessWidget {
  const ArticaleCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ArticaleCard(title: 'news'),
          ArticaleCard(title: 'explore'),
          ArticaleCard(title: 'technology'),
          ArticaleCard(title: 'sport'),
          ArticaleCard(title: 'travel'),
          ArticaleCard(title: 'business'),
          ArticaleCard(title: 'science'),
          ArticaleCard(title: 'health'),
          ArticaleCard(title: 'entertainment'),
        ],
      ),
    );
  }
}


/**
 * 
          ArticaleCard(title: 'general'),
          ArticaleCard(title: 'business'),
          ArticaleCard(title: 'technology'),
          ArticaleCard(title: 'sports'),
          ArticaleCard(title: 'science'),
          ArticaleCard(title: 'health'),
          ArticaleCard(title: 'entertainment'),
 */