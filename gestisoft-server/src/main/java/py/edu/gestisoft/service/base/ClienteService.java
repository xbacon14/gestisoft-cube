package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.repositories.base.ClienteRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class ClienteService {
//INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private ClienteRepository clienteRepository;

//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA CLIENTE 
	public Cliente save(Cliente cliente) {
		cliente.setEstado(true);
		return clienteRepository.save(cliente);
	}

//	DEVUELVE TODOS LOS CLIENTES DE LA TABLA CLIENTE
	public List<Cliente> findAllClientes() {
		return clienteRepository.findAll();
	}

}
