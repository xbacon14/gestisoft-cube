package py.edu.gestisoft.controller.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.service.base.ClienteService;

@RestController
@CrossOrigin
@RequestMapping({ "/api/cliente" })
public class ClienteController {
//INYECTA EL SERVICE DEL MODULO CLIENTE
	@Autowired
	private ClienteService clienteService;

//	GUARDA LA ENTIDAD CLIENTE
	@PostMapping("/save")
	public ResponseEntity<Cliente> save(@RequestBody Cliente cliente) {
		cliente = clienteService.save(cliente);
		return ResponseEntity.ok(cliente);
	}

	@GetMapping("/findAll")
	public ResponseEntity<List<Cliente>> findAllClientes() {
		return ResponseEntity.ok(clienteService.findAllClientes());
	}
}
