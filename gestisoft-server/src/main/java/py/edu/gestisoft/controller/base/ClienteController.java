package py.edu.gestisoft.controller.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ResponseEntity<?> save(@RequestBody Cliente cliente) {
		return clienteService.save(cliente);
	}

	@GetMapping("/findAll")
	public ResponseEntity<List<Cliente>> findAllClientes() {
		return ResponseEntity.ok(clienteService.findAllClientes());
	}

	@GetMapping("/findByNombreODocumento")
	public ResponseEntity<List<Cliente>> findByNombreODocumento(@RequestParam String condition) {

		return ResponseEntity.ok(clienteService.findClientePorNombreODocumento(condition));
	}

	@GetMapping("/revisarExistenciaCi")
	public ResponseEntity<Boolean> revisarExistenciaCi(@RequestParam String documento) {

		return ResponseEntity.ok(clienteService.revisarExistenciaCi(documento));
	}

	@DeleteMapping("/deleteCliente/{id}")
	public ResponseEntity<?> deleteClienteById(@PathVariable Long id) {
		Boolean response = clienteService.deleteClienteById(id);
		if (response == true) {
			return ResponseEntity.ok("Cliente eliminado satisfactoriamente");
		} else {
			return ResponseEntity.ok("No se ha podido eliminar el cliente");
		}
	}

	@GetMapping("/getProximoId")
	public ResponseEntity<Long> getProximoId() {
		return ResponseEntity.ok(clienteService.getProximoId());
	}

	@GetMapping("/generaReporte")
	public ResponseEntity<?> generaReporte(@RequestParam String filtroDesde, @RequestParam String filtroHasta,
			@RequestParam String orderByCondition, @RequestParam boolean verInactivos, @RequestParam boolean verPdf) {
		return ResponseEntity.ok(
				clienteService.generaReporteCliente(filtroDesde, filtroHasta, verInactivos, orderByCondition, verPdf));
	}
}
