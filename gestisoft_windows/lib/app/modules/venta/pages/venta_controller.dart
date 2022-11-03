import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/text_utils/number_formatter.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/repositories/cliente_repository.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta_detalle.dart';
import 'package:gestisoft_windows/app/modules/venta/repositories/venta_repository.dart';
import 'package:mobx/mobx.dart';

part 'venta_controller.g.dart';

class VentaController = _VentaControllerBase with _$VentaController;

abstract class _VentaControllerBase with Store {
  final VentaRepository ventaRepository;
  final ClienteRepository clienteRepository;
  _VentaControllerBase({
    required this.ventaRepository,
    required this.clienteRepository,
  });
  @observable
  ObservableList<Venta> dataProvider = ObservableList();
  @observable
  TextEditingController idVentaET = TextEditingController();
  @observable
  TextEditingController docNroET = TextEditingController(text: "001-001-000");
  @observable
  TextEditingController fechaET = TextEditingController();
  @observable
  TextEditingController choferET = TextEditingController();
  @observable
  TextEditingController vehiculoET = TextEditingController();
  @observable
  TextEditingController descripcionET = TextEditingController();
  @observable
  TextEditingController precioVentaET = TextEditingController();
  @observable
  TextEditingController cantET = TextEditingController();

  @observable
  DateTimeRange filtroPeriod =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @observable
  bool listaVacia = true;
  @observable
  bool processando = true;
  @observable
  bool produtoSeleccionado = false;

  @observable
  Venta currentRecord = Venta().nuevo();

  @observable
  VentaDetalle detalleActual = VentaDetalle.nuevo();

// REPORTE
  @observable
  Uint8List? pdf;

  @observable
  File pdfFile = File('');

  @action
  setCliente({required Cliente cliente}) {
    currentRecord.cliente = cliente;
  }

  @action
  setVendedor({required Vendedor vendedor}) async {
    currentRecord.vendedor = vendedor;
  }

  @action
  setProducto({required Producto producto}) async {
    producto = producto;
  }

  @action
  setCantidadActual({required double cantActual}) {
    detalleActual.cantidad = cantActual;
  }

  @action
  setPrecioActual({required double precioActual}) {
    detalleActual.precio = precioActual;
  }

  @action
  addItemProducto({required VentaDetalle item}) async {
    currentRecord.detalles?.add(item);

    listaVacia = false;
  }

  @action
  void limpiarCampos() {
    docNroET.text = "001-001-000";
    fechaET.text = DateUtil.formatDateTimeToDate(DateTime.now());
    choferET.clear();
    vehiculoET.clear();
    descripcionET.clear();
    precioVentaET.clear();
    cantET.clear();
    currentRecord = Venta().nuevo();
    listaVacia = true;
  }

  String vlTotalListaDetalle() {
    double result = 0;
    if (currentRecord.detalles != null) {
      for (VentaDetalle element in currentRecord.detalles!) {
        result += element.precio! * element.cantidad!;
      }
    }
    return NumberFormater.format(result, 0);
  }

  @action
  Future<void> getProximoCodigo() async {
    await ventaRepository.getProximoId().then((value) {
      currentRecord.id = value.data;
      idVentaET.text = value.data.toString();
    });
  }

  Future<void> guardarVenta(BuildContext context) async {
    // debugPrint("valido");
    // debugPrint(currentRecord.toString());
    processando = true;
    final response = await ventaRepository
        .saveVenta(venta: currentRecord)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      Alert.show(
          context: context,
          message: "Se ha guardado exito con éxito la venta",
          type: 0);
    } else {
      Alert.show(
          context: context, message: "No se ha guardar la venta", type: 2);
    }
  }

  Future<void> findAllVentas(BuildContext context) async {
    processando = true;
    final response =
        await ventaRepository.findAll().whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      dataProvider.clear();
      dataProvider
          .addAll(response.data.map<Venta>((v) => Venta.fromJson(v)).toList());
      if (dataProvider.isEmpty) {
        listaVacia = true;
      } else {
        listaVacia = false;
      }
    } else {
      Alert.show(
          context: context,
          message: "No se ha logrado consultar las ventas",
          type: 2);
    }
  }

  Future<void> findVentasPorNombreCliente(
      BuildContext context, String condition) async {
    processando = true;
    final response = await ventaRepository
        .findVentasPorNombreCliente(condition)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      dataProvider.clear();
      dataProvider
          .addAll(response.data.map<Venta>((v) => Venta.fromJson(v)).toList());
      if (dataProvider.isEmpty) {
        listaVacia = true;
      } else {
        listaVacia = false;
      }
    } else {
      Alert.show(
          context: context,
          message: "No se ha logrado consultar las ventas",
          type: 2);
    }
  }

  Future<void> cancelarVenta(BuildContext context, int idVenta) async {
    processando = true;
    final response = await ventaRepository
        .cancelaVentaById(idVenta)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      Alert.show(
          context: context,
          message: "La venta ha sido cancelada exitosamente",
          type: 0);
    } else {
      Alert.show(
          context: context,
          message: "La venta no se ha podido cancelar",
          type: 1);
    }
  }

  Future<Uint8List> geraRelatorio({
    required BuildContext context,
    String? docNro,
    required bool isPdf,
  }) async {
    processando = true;
    final response = await ventaRepository
        .geraRelatorio(
            dtInicio:
                DateUtil.sqlDateFormat(filtroPeriod.start.toIso8601String()),
            dtFinal: DateUtil.sqlDateFormat(filtroPeriod.end.toIso8601String()),
            isPdf: isPdf)
        .whenComplete(() => processando = false);
    if (response.compareTo('error') == 0) {
      Alert.show(
          context: context,
          message: "Error, no se pudo generar el reporte",
          type: 2);
      throw Error();
    } else {
      return base64.decode(response);
    }
  }
}
