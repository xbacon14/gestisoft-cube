package py.edu.gestisoft.mapper.operacional;

import java.util.List;

import py.edu.gestisoft.model.operacional.Venta;

public interface VentaMapper {

	Long findVentasPorCliente(Long idCliente);

	Long findVentasPorVendedor(Long idVendedor);

	Long findVentasPorProducto(Long idProducto);

	Long getProximoId();

	List<Venta> findVentaPorNombreCliente(String condition);

	List<Venta> findVentasPorFecha(String condition);
}
