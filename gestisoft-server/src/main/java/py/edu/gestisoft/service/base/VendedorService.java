package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.model.base.Vendedor;
import py.edu.gestisoft.repositories.base.ClienteRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class VendedorService {
	// INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private VendedorRepository vendedorRepository;

//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA VENDEDOR
	public Vendedor save(Vendedor vendedor) {
		return vendedorRepository.save(vendedor);
	}

//	DEVUELVE TODOS LOS VENDEDORES DE LA TABLA VENDEDOR
	public List<Vendedor> findAllClientes() {
		return vendedorRepository.findAll();
	}
}
