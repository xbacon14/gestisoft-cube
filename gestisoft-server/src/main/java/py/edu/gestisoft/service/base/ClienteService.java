package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.mapper.base.ClienteMapper;
import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.repositories.base.ClienteRepository;
import py.edu.gestisoft.utils.sql.SQLUtils;

@Service
@Transactional(rollbackFor = Exception.class)
public class ClienteService {
//INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private ClienteRepository clienteRepository;

	@Autowired
	private ClienteMapper clienteMapper;

//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA CLIENTE 
	public ResponseEntity<?> save(Cliente cliente) {
		if (clienteRepository.findByciRuc(cliente.getCiRuc()) == null) {
			cliente.setEstado(true);
			return ResponseEntity.ok(clienteRepository.save(cliente));
		} else {
			return ResponseEntity.accepted().body(new Cliente());
		}
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

}
