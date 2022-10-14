package py.edu.gestisoft.mapper.operacional;

import java.util.List;

import py.edu.gestisoft.model.operacional.VentaDetalle;

public interface VentaDetalleMapper {

	List<VentaDetalle> findDetalleByVenta(Long venta);

}
