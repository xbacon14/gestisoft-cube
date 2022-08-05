import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:window_manager/window_manager.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final typography = FluentTheme.of(context).typography;
    return ScaffoldPage(
      header: PageHeader(
        leading: null,
        title: Center(
          child: kReleaseMode
              ? Text(
                  "J.P. MORGAN DISTRIBUIDORA",
                  style: typography.subtitle,
                )
              : Text(
                  Modular.to.path,
                  style: typography.subtitle,
                ),
        ),
      ),
      content: Acrylic(
        elevation: 1.0,
        luminosityAlpha: 1.0,
        tintAlpha: 0.1,
        child: Container(
          color: Colors.red.withOpacity(.12),
          width: size.width,
          height: size.height,
          child: widget.body,
        ),
      ),
      bottomBar: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          const Text("GESTISOFT v0.1")
        ],
      ),
    );
  }
}
