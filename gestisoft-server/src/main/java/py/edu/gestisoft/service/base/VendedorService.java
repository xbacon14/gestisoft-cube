package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.mapper.base.VendedorMapper;
import py.edu.gestisoft.mapper.operacional.VentaMapper;
import py.edu.gestisoft.model.base.Vendedor;
import py.edu.gestisoft.utils.reporte.CreaReporte;
import py.edu.gestisoft.utils.sql.SQLUtils;
import py.edu.gestisoft.utils.text.FiltroUtil;

@Service
@Transactional(rollbackFor = Exception.class)
public class VendedorService {
	// INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private VendedorRepository vendedorRepository;

	@Autowired
	private VendedorMapper vendedorMapper;

	@Autowired
	private VentaMapper ventaMapper;

	@Autowired
	private CreaReporte creaReporte;

//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA VENDEDOR
	public Vendedor save(Vendedor vendedor) {
		return vendedorRepository.save(vendedor);
	}

//	DEVUELVE TODOS LOS VENDEDORES DE LA TABLA VENDEDOR
	public List<Vendedor> findAllVendedores() {
		return vendedorRepository.findAll();
	}

	public List<Vendedor> findVendedorByNombreODocumento(String condition) {
		if (condition.isEmpty() || condition == null) {
			return findAllVendedores();
		}
		return vendedorMapper.findVendedorByNombreODocumento(SQLUtils.like(condition));

	}

//	REVISA SI YA EXISTE ALGUN VENDEDOR CON ESE CI
	public Boolean revisarExistenciaCi(String documento) {
		Vendedor vendedor = vendedorRepository.findByCi(documento);
		if (vendedor == null) {
			return false;
		} else {
			return true;
		}
	}

//	ELIMINA EL VENDEDOR CASO NO TENGA NINGUN VINCULO CON VENTAS
	public Boolean deleteById(Long idVendedor) {
		Long cantidadVentas = ventaMapper.findVentasPorVendedor(idVendedor);
		if (cantidadVentas == 0 || cantidadVentas == null) {
			vendedorRepository.deleteById(idVendedor);
			return true;
		} else {
			return false;
		}
	}

	public ResponseEntity<?> generaReporteVendedores(String filtroDesde, String filtroHasta, boolean verInactivos,
			String orderByCondition, boolean verPdf) {
		String nombreReporte = "ReporteVendedor";
		String condition = "1=1";
		String order = "ORDER BY v.NOMBRE";
		if (!orderByCondition.isEmpty()) {
			if (orderByCondition.compareTo("Codigo") == 0) {
				order = "ORDER BY v.ID_VENDEDOR";
			} else if (orderByCondition.compareTo("Documento") == 0) {
				order = "ORDER BY v.CI";
			} else {
				order = "ORDER BY v." + orderByCondition;
			}
		}
		if (filtroDesde != null && !filtroDesde.isEmpty() && filtroHasta != null && !filtroHasta.isEmpty()) {
			condition = FiltroUtil.geraConditionRelatorio("v", filtroDesde, filtroHasta, orderByCondition,
					verInactivos);
		}
		String filtro = FiltroUtil.geraFiltroRelatorioPessoas(filtroDesde, filtroHasta, nombreReporte);
		List<Vendedor> vendedoresReporte = vendedorMapper.findVendedorReporte(condition, order);

		if (verPdf == true) {
			return creaReporte.generaReporte(filtro, nombreReporte, vendedoresReporte);
		} else {
			return creaReporte.generaXLS(filtro, nombreReporte, vendedoresReporte);
		}
	}
}
