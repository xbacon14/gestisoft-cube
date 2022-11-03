import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/repositories/producto_repository.dart';
import 'package:mobx/mobx.dart';

part 'producto_controller.g.dart';

class ProductoController = _ProductoControllerBase with _$ProductoController;

abstract class _ProductoControllerBase with Store {
  final ProductoRepository productoRepository;
  _ProductoControllerBase(this.productoRepository);

  @observable
  int selected = 0;

  @observable
  List<String> values = [
    "METROS CÚBICOS",
    "UNIDADES",
  ];

  @observable
  Producto currentRecord = Producto.nuevo();

  @observable
  bool processando = false;

  @observable
  bool listaVacia = false;

  // REPORTE
  @observable
  Uint8List? pdf;

  @observable
  File pdfFile = File('');

  @observable
  bool verInactivos = false;

  ObservableList<Producto> productos = ObservableList();

  ObservableList<Producto> dataProvider = ObservableList();

  Future<void> findAllProductos() async {
    processando = true;
    final response = await productoRepository
        .findAllProductos()
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      productos.clear();
      productos.addAll(
          response.data.map<Producto>((p) => Producto.fromJson(p)).toList());
      resolveListaVacia();
    }
  }

  Future<void> save() async {
    processando = true;
    final response = await productoRepository
        .save(currentRecord)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      debugPrint(
          "El cliente ${currentRecord.nombre} ha sido guardado con exito");
      currentRecord = Producto.nuevo();
    } else {
      debugPrint("No se ha podido guardar el cliente");
    }
  }

  Future<void> eliminaProductoById(BuildContext context, int idProducto) async {
    processando = true;
    final response = await productoRepository
        .eliminarProductoById(idProducto)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      String message = response.data;
      if (message.startsWith("Producto")) {
        Alert.show(context: context, message: message, type: 0);
      } else {
        Alert.show(context: context, message: message, type: 2);
      }
    }
  }

  resolveListaVacia() {
    if (dataProvider.isEmpty) {
      listaVacia = true;
    } else if (productos.isEmpty) {
      listaVacia = true;
    } else {
      listaVacia = false;
    }
  }

  Future<List<Producto>> findByNombreOCodigo(String condition) async {
    processando = true;
    List<Producto> lista = [];
    final response = await productoRepository
        .findByNombreOCodigo(condition)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      dataProvider.clear();
      dataProvider.addAll(
          response.data.map<Producto>((c) => Producto.fromJson(c)).toList());
      lista = dataProvider;
      resolveListaVacia();
    } else {
      debugPrint("no se pudieron consultar los clientes");
    }
    return lista;
  }

  Future<Uint8List> geraRelatorio({
    required BuildContext context,
    String? filtroDesde,
    String? filtroHasta,
    String? orderBy,
    required bool isPdf,
  }) async {
    processando = true;
    final response = await productoRepository
        .geraRelatorio(
            filtroDesde: filtroDesde,
            filtroHasta: filtroHasta,
            orderBy: orderBy,
            verInactivos: verInactivos,
            isPdf: isPdf)
        .whenComplete(() => processando = false);
    if (response.compareTo('error') == 0) {
      Alert.show(
          context: context,
          message: "Error, no se pudo generar el reporte",
          type: 2);
      throw Error();
    } else {}
    return base64.decode(response);
  }
}
