package py.edu.gestisoft.service.base;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.repositories.base.ClienteRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class ClienteService {

	@Autowired
	private ClienteRepository clienteRepository;

	public Cliente save(Cliente cliente) {
		return clienteRepository.save(cliente);
	}

}
