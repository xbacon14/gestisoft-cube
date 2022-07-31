package py.edu.gestisoft.controller.base;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
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

	@Autowired
	private ClienteService clienteService;

//	GUARDA LA ENTIDAD CLIENTE
	@PostMapping("/save")
	public ResponseEntity<Cliente> save(@RequestBody Cliente cliente) {
		cliente = clienteService.save(cliente);
		return ResponseEntity.ok(cliente);
	}

}
