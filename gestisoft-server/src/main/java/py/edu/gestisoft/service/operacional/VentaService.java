package py.edu.gestisoft.service.operacional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.operacional.Venta;
import py.edu.gestisoft.model.operacional.VentaDetalle;
import py.edu.gestisoft.repositories.operacional.VentaDetalleRepository;
import py.edu.gestisoft.repositories.operacional.VentaRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class VentaService {
	// INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private VentaRepository ventaRepository;

	@Autowired
	private VentaDetalleRepository ventaDetalleRepository;

//		PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA CLIENTE 
	public Venta save(Venta venta) {
		venta = ventaRepository.save(venta);
		Long total = 0l;
		for (VentaDetalle detalle : venta.getDetalles()) {
			detalle.setVenta(new Venta(venta.getId()));
			total += detalle.getPrecio();
			ventaDetalleRepository.save(detalle);
		}
		venta.setTotal(total);
		return venta;
	}

//		DEVUELVE TODOS LOS CLIENTES DE LA TABLA CLIENTE
	public List<Venta> findAllVentas() {
		return ventaRepository.findAll();
	}

}
