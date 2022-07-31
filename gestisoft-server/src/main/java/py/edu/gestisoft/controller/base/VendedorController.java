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

import py.edu.gestisoft.model.base.Vendedor;
import py.edu.gestisoft.service.base.VendedorService;

@RestController
@CrossOrigin
@RequestMapping({ "/api/vendedor" })
public class VendedorController {
	// INYECTA EL SERVICE DEL MODULO VENDEDOR
	@Autowired
	private VendedorService vendedorService;

//		GUARDA LA ENTIDAD VENDEDOR
	@PostMapping("/save")
	public ResponseEntity<Vendedor> save(@RequestBody Vendedor vendedor) {
		vendedor = vendedorService.save(vendedor);
		return ResponseEntity.ok(vendedor);
	}

	@GetMapping("/findAll")
	public ResponseEntity<List<Vendedor>> findAllVendedor() {
		return ResponseEntity.ok(vendedorService.findAllClientes());
	}

}
