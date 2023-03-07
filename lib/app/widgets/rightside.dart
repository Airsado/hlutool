import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';

class RightSide extends StatefulWidget {
  RightSide({Key? key, required this.chill}) : super(key: key);
  Widget chill;

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(child: MoveWindow()),
              MinimizeWindowButton(),
              CloseWindowButton()
            ],
          ),
        ),
        Expanded(child: widget.chill)
        // widget.chill
      ],
    );
  }
}
