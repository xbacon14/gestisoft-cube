package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.mapper.base.ClienteMapper;
import py.edu.gestisoft.mapper.operacional.VentaMapper;
import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.repositories.base.ClienteRepository;
import py.edu.gestisoft.utils.reporte.CreaReporte;
import py.edu.gestisoft.utils.sql.SQLUtils;
import py.edu.gestisoft.utils.text.FiltroUtil;

@Service
@Transactional(rollbackFor = Exception.class)
public class ClienteService {
//INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private ClienteRepository clienteRepository;

	@Autowired
	private ClienteMapper clienteMapper;

	@Autowired
	private VentaMapper ventaMapper;

	@Autowired
	private CreaReporte creaReporte;

//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA CLIENTE 
	public ResponseEntity<?> save(Cliente cliente) {
		cliente.setEstado(true);
		return ResponseEntity.ok(clienteRepository.save(cliente));
	}

//	DEVUELVE TODOS LOS CLIENTES DE LA TABLA CLIENTE
	public List<Cliente> findAllClientes() {
		return clienteRepository.findAll();
	}

	public List<Cliente> findClientePorNombreODocumento(String condition) {
		if (condition.isEmpty() || condition == null) {
			return findAllClientes();
		}
		return clienteMapper.findClientesPorNombreODocumento(SQLUtils.like(condition));

	}

	public Boolean revisarExistenciaCi(String documento) {
		Cliente cliente = clienteRepository.findByciRuc(documento);
		if (cliente == null) {
			return false;
		} else {
			return true;
		}
	}

	public Boolean deleteClienteById(Long idCliente) {
		Long cantidadVentas = ventaMapper.findVentasPorCliente(idCliente);
		if (cantidadVentas == 0 || cantidadVentas == null) {
			clienteRepository.deleteById(idCliente);
			return true;
		} else {
			return false;
		}
	}

	public Long getProximoId() {
		return clienteMapper.getProximoId();
	}

	public ResponseEntity<?> generaReporteCliente(String filtroDesde, String filtroHasta, boolean verInactivos,
			String orderByCondition, boolean verPdf) {
		String nombreReporte = "ReporteCliente";
		String condition = "1=1";
		String order = "ORDER BY c.NOMBRE";
		if (!orderByCondition.isEmpty()) {
			if (orderByCondition.compareTo("Codigo") == 0) {
				order = "ORDER BY c.ID_CLIENTE";
			} else if (orderByCondition.compareTo("Documento") == 0) {
				order = "ORDER BY c.CI_RUC";
			} else {
				order = "ORDER BY c." + orderByCondition;
			}
		}
		if (filtroDesde != null && !filtroDesde.isEmpty() && filtroHasta != null && !filtroHasta.isEmpty()) {
			condition = FiltroUtil.geraConditionRelatorio("c", filtroDesde, filtroHasta, orderByCondition,
					verInactivos);
		}
		String filtro = FiltroUtil.geraFiltroRelatorioPessoas(filtroDesde, filtroHasta, nombreReporte);
		List<Cliente> clientesReporte = clienteMapper.findClientesReporte(condition, order);

		if (verPdf == true) {
			return creaReporte.generaReporte(filtro, nombreReporte, clientesReporte);
		} else {
			return creaReporte.generaXLS(filtro, nombreReporte, clientesReporte);
		}
	}
}
