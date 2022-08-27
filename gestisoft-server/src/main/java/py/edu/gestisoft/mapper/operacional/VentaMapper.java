package py.edu.gestisoft.mapper.operacional;

public interface VentaMapper {

	Long findVentasPorCliente(Long idCliente);

	Long findVentasPorVendedor(Long idVendedor);

	Long findVentasPorProducto(Long idProducto);

	Long getProximoId();
}
