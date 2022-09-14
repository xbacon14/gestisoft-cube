import 'package:fluent_ui/fluent_ui.dart';

class LoadingRender extends StatefulWidget {
  const LoadingRender({Key? key}) : super(key: key);

  @override
  State<LoadingRender> createState() => _LoadingRenderState();
}

class _LoadingRenderState extends State<LoadingRender> {
  @override
  Widget build(BuildContext context) {
    return const ProgressRing();
  }
}
