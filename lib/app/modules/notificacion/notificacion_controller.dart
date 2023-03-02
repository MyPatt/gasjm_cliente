import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/notificacion_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/notificacion_repository.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificacionController extends GetxController {
  //Repositorios
  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();
  final _notificacionRepository = Get.find<NotificacionRepository>();

  //Variable para dsatos del pedido
  PedidoModel? pedido;

  //Lista observable que muestra las notificaciones del pedido, inicializado sin notificaciones.
  // En caso de que haya notificaciones se carga los datos
  final RxList<String> _notificaciones =
      ["Sin notificaciones, ,En este momento"].obs;
  RxList<String> get notificaciones => _notificaciones;

  //METODOS PROPIOS GETX
  @override
  void onInit() {
    super.onInit();
    //Obtener  datos del pedido  realizado
    pedido = Get.arguments;
    _cargarListaNotificaciones();
  }

  Future<void> _cargarListaNotificaciones() async {
    try {
      //CARGAR DATOS DEL PEDIDO
      List<Notificacion> aux = await _notificacionRepository
          .getNotificacionesPorIdPedido(idPedido: pedido!.idPedido!);
    
      if (aux.length.toInt() > 0) {
        _notificaciones.clear();

        for (var element in aux) {
          _notificaciones.add(
              "${element.tituloNotificacion}, por ${element.textoNotificacion},${formatoHoraFecha(element.fechaNotificacion)}");
        }
      }
    } catch (e) {
      //
      Exception('Error, inténtalo más tarde.');
    }
  }

//
  RxBool cargandoDetalle = false.obs;
  final Rx<EstadoDelPedido> _estadoPedido1 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  final Rx<EstadoDelPedido> _estadoPedido3 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  Rx<EstadoDelPedido> get estadoPedido1 => _estadoPedido1;
  Rx<EstadoDelPedido> get estadoPedido3 => _estadoPedido3;

  //El estadoPedido2 se usa por el repartidor
  Future<void> cargarDetalle() async {
    PedidoModel? pedidoAux = pedido;

    //Limpiar datos
    _estadoPedido1.value = EstadoDelPedido(
        idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "");
    _estadoPedido3.value = EstadoDelPedido(
        idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "");
//
    try {
      cargandoDetalle.value = true;
      //
      var aux1 = await _pedidoRepository.getEstadoPedidoPorField(
          uid: pedidoAux!.idPedido!, field: "estadoPedido1");
      var aux3 = await _pedidoRepository.getEstadoPedidoPorField(
          uid: pedidoAux.idPedido!, field: "estadoPedido3");

      if (aux1 != null) {
        aux1.nombreEstado = await _getNombreEstado(aux1.idEstado);
        aux1.nombreUsuario = await _personaRepository.getNombresPersonaPorUid(
            uid: aux1.idPersona);
        _estadoPedido1.value = aux1;
      }

      if (aux3 != null) {
        aux3.nombreEstado = await _getNombreEstado(aux3.idEstado);
        aux3.nombreUsuario = await _personaRepository.getNombresPersonaPorUid(
            uid: aux3.idPersona);
        _estadoPedido3.value = aux3;
      }

      //
      _cargarPaginaDetalle(pedidoAux);
    } catch (e) {
      Exception("Error al cargar detalle del pedido");
    }
    cargandoDetalle.value = false;
  }

//
  void _cargarPaginaDetalle(PedidoModel pedido) {
    Get.to(
        DetalleHistorial(
          pedido: pedido,
          cargandoDetalle: cargandoDetalle,
          formatoHoraFecha: formatoHoraFecha,
          estadoPedido1: estadoPedido1,
          estadoPedido3: estadoPedido3,
        ),
        routeName: 'detalle');
  }

  //Metodo para encontrar el  nombre del estado
  Future<String> _getNombreEstado(String idEstado) async {
    final nombre =
        await _pedidoRepository.getNombreEstadoPedidoPorId(idEstado: idEstado);
    return nombre ?? 'Pedido';
  }

  String formatoHoraFecha(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoHora $formatoFecha";
  }
}
