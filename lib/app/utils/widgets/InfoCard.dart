import 'package:flutter/material.dart';

/// @Author Airsado
/// @Date 2023-09-10 17:13
/// @Version 1.0
/// @Description 信息卡片

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, this.title = "信息标题", this.content = "信息内容"});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.5))),
      height: 50,
      // width: 90,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 13)),
            Text(content,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
