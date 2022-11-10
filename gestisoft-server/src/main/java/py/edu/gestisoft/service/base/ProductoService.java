package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.mapper.base.ProductoMapper;
import py.edu.gestisoft.mapper.operacional.VentaMapper;
import py.edu.gestisoft.model.base.Producto;
import py.edu.gestisoft.repositories.base.ProductoRepository;
import py.edu.gestisoft.utils.reporte.CreaReporte;
import py.edu.gestisoft.utils.text.FiltroUtil;

@Service
@Transactional(rollbackFor = Exception.class)
public class ProductoService {

	@Autowired
	private ProductoRepository productoRepository;

	@Autowired
	private ProductoMapper productoMapper;

	@Autowired
	private CreaReporte creaReporte;

	@Autowired
	private VentaMapper ventaMapper;

//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA PRODUCTO
	public Producto save(Producto producto) {
		return productoRepository.save(producto);
	}

//	DEVUELVE TODOS LOS PRODUCTOS DE LA TABLA PRODUCTOS
	public List<Producto> findAllProductos() {
		return productoRepository.findAll();
	}

	public List<Producto> findByNombre(String condition) {
		if (condition.isEmpty() || condition == null) {
			return findAllProductos();
		}
		return productoMapper.findByNombre(condition);

	}

	public Boolean deleteProductoById(Long idProducto) {
		Long cantidadVentas = ventaMapper.findVentasPorProducto(idProducto);
		if (cantidadVentas == 0 || cantidadVentas == null) {
			productoRepository.deleteById(idProducto);
			return true;
		} else {
			return false;
		}
	}

	public ResponseEntity<?> generaReporteCliente(String filtroDesde, String filtroHasta, boolean verInactivos,
			String orderByCondition, boolean verPdf) {
		String nombreReporte = "ReporteProducto";
		String condition = "1=1";
		String order = "ORDER BY p.NOMBRE";
		if (!orderByCondition.isEmpty()) {
			if (orderByCondition.compareTo("Codigo") == 0) {
				order = "ORDER BY p.ID_PRODUCTO";
			} else {
				order = "ORDER BY p." + orderByCondition;
			}
		}
		if (filtroDesde != null && !filtroDesde.isEmpty() && filtroHasta != null && !filtroHasta.isEmpty()) {
			condition = FiltroUtil.geraConditionRelatorio("p", filtroDesde, filtroHasta, orderByCondition,
					verInactivos);
		}
		String filtro = FiltroUtil.geraFiltroRelatorioPessoas(filtroDesde, filtroHasta, nombreReporte);
		List<Producto> productosReporte = productoMapper.findProductosReporte(condition, order);

		if (verPdf == true) {
			return creaReporte.generaReporte(filtro, nombreReporte, productosReporte);
		} else {
			return creaReporte.generaXLS(filtro, nombreReporte, productosReporte);
		}
	}

}
