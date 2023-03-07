import 'package:fluent_ui/fluent_ui.dart';
import '../../views/navigation_view.dart';

class StateWidget extends StatefulWidget {
  const StateWidget({Key? key}) : super(key: key);

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '校园网自动登录的状态',
      child: Button(
        child: ListTile(
          leading: const Icon(FluentIcons.plug_connected),
          title: const Text('校园网状态'),
          trailing: FutureBuilder(
              future: loginfuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Icon(FluentIcons.airplane);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SizedBox(
                      width: 20, height: 20, child: ProgressRing());
                }
                if (snapshot.hasData) {
                  if (snapshot.data == 2) {
                    return Icon(FluentIcons.accept, color: Colors.green);
                  } else {
                    return Icon(FluentIcons.error_badge, color: Colors.red);
                  }
                } else if (snapshot.hasError) {
                  return Icon(FluentIcons.error_badge, color: Colors.red);
                } else {
                  return const SizedBox(
                      width: 20, height: 20, child: ProgressRing());
                }
              }),
        ),
        onPressed: () {},
      ),
    );
  }
}
