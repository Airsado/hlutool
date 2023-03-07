import 'package:flutter/material.dart';

import '../../theme/values/AppSize.dart';

/// @Author Airsado
/// @Date 2023-09-10 22:42
/// @Version 1.0
/// @Description TODO
class ProjectItem extends StatefulWidget {
  const ProjectItem(
      {super.key,
      this.title = '标题',
      this.content = '副标',
      required this.icon,
      this.onTap});

  final String title;

  final String content;
  final IconData? icon;
  final void Function()? onTap;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool isEnter = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (even) => setState(() {
        isEnter = true;
      }),
      onExit: (even) => setState(() {
        isEnter = false;
      }),
      child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x80BCF3DE),
                          offset: Offset(4, 3),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ],
                    color: isEnter ? const Color(0xF3F7F9FF) : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(color: Colors.black, width: 0.01),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: AppSize.Spacing20),
                        Icon(widget.icon),
                        const SizedBox(width: AppSize.Spacing20),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(widget.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              Text(widget.content,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12))
                            ])),
                        const Icon(Icons.keyboard_arrow_right),
                        const SizedBox(width: AppSize.Spacing20),
                      ])))),
    );
  }
}
