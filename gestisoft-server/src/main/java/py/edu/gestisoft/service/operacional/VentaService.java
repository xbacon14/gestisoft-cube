package py.edu.gestisoft.service.operacional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.mapper.operacional.VentaMapper;
import py.edu.gestisoft.model.operacional.Venta;
import py.edu.gestisoft.model.operacional.VentaDetalle;
import py.edu.gestisoft.repositories.operacional.VentaDetalleRepository;
import py.edu.gestisoft.repositories.operacional.VentaRepository;
import py.edu.gestisoft.utils.reporte.CreaReporte;
import py.edu.gestisoft.utils.sql.SQLUtils;
import py.edu.gestisoft.utils.text.FiltroUtil;

@Service
@Transactional(rollbackFor = Exception.class)
public class VentaService {
	// INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private VentaRepository ventaRepository;

	@Autowired
	private VentaDetalleRepository ventaDetalleRepository;

	@Autowired
	private VentaMapper ventaMapper;

	@Autowired
	private CreaReporte creaReporte;

//		PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA CLIENTE 
	public Venta save(Venta venta) {
		venta.setFecha();
		Venta ventaPersist = ventaRepository.save(venta);
		BigDecimal total = BigDecimal.ZERO;
		for (VentaDetalle detalle : venta.getDetalles()) {
			BigDecimal valorItem = BigDecimal.ZERO;
			detalle.setVenta(new Venta(ventaPersist.getId()));
			valorItem = valorItem.add(detalle.getPrecio().multiply(detalle.getCantidad()));
			total = total.add(valorItem);
			ventaDetalleRepository.save(detalle);
		}
		ventaPersist.setTotal(total);
		return ventaRepository.save(ventaPersist);
	}

//		DEVUELVE TODOS LOS CLIENTES DE LA TABLA CLIENTE
	public List<Venta> findAllVentas() {
		return ventaRepository.findAll();
	}

	public Long getProximoId() {
		return ventaMapper.getProximoId() + 1l;
	}

	public List<Venta> findByNombre(String condition) {
		if (condition.isEmpty() || condition == null) {
			return findAllVentas();
		}
		return ventaMapper.findVentaPorNombreCliente(SQLUtils.like(condition));

	}

	public Venta cancelaVenta(Long venta) {
		Venta v = ventaRepository.findById(venta).get();
		v.setEstado(false);
		v = ventaRepository.save(v);
		return v;
	}

	public ResponseEntity<?> generaReporteVenta(Long cliente, String docNro, String dtInicio, String dtFinal,
			boolean verPdf) {
		String nombreReporte = "ReporteVenta";
		String condition = "1=1";
		if (!dtInicio.isEmpty() && !dtFinal.isEmpty() && dtInicio != null && dtFinal != null) {
			condition = "DATE(v.FECHA) " + FiltroUtil.toBetween(dtInicio, dtFinal);
		}
		if (cliente != 0) {
			condition += " AND c.ID_CLIENTE = " + cliente;
		}
		if (docNro != null && !docNro.isEmpty()) {
			condition = "v.DOC_NRO = " + FiltroUtil.stringToChar(docNro);
		}
		String filtro = FiltroUtil.geraFiltroRelatorio(dtInicio, dtFinal, nombreReporte);
		List<Venta> ventasReporte = ventaMapper.findVentasPorFecha(condition);

		if (verPdf == true) {
			return creaReporte.generaReporte(filtro, nombreReporte, ventasReporte);
		} else {
			return creaReporte.generaXLS(filtro, nombreReporte, ventasReporte);
		}

	}

}
