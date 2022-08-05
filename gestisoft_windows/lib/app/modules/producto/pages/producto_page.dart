import 'package:flutter/material.dart';
import './producto_controller.dart';

class ProductoPage extends StatelessWidget {

    final ProductoController _controller;

    const ProductoPage({ 
        Key? key,
        required ProductoController controller,
      }) : _controller = controller;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('ProductoPage'),),
            body: Container(),
        );
    }
}