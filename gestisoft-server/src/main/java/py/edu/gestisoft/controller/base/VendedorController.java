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
		return ResponseEntity.ok(vendedorService.findAllVendedores());
	}

	@GetMapping("/findByNombreODocumento")
	public ResponseEntity<List<Vendedor>> findByNombreODocumento(@RequestParam String condition) {

		return ResponseEntity.ok(vendedorService.findVendedorByNombreODocumento(condition));
	}

	@GetMapping("/revisarExistenciaCi")
	public ResponseEntity<Boolean> revisarExistenciaCi(@RequestParam String documento) {

		return ResponseEntity.ok(vendedorService.revisarExistenciaCi(documento));
	}

	@DeleteMapping("/delete/{id}")
	public ResponseEntity<?> deleteClienteById(@PathVariable Long id) {
		Boolean response = vendedorService.deleteById(id);
		if (response == true) {
			return ResponseEntity.ok("Vendedor eliminado satisfactoriamente");
		} else {
			return ResponseEntity.ok("No se ha podido eliminar el vendedor");
		}
	}

	@GetMapping("/generaReporte")
	public ResponseEntity<?> generaReporte(@RequestParam String filtroDesde, @RequestParam String filtroHasta,
			@RequestParam String orderByCondition, @RequestParam boolean verInactivos, @RequestParam boolean verPdf) {
		return ResponseEntity.ok(vendedorService.generaReporteVendedores(filtroDesde, filtroHasta, verInactivos,
				orderByCondition, verPdf));
	}
}
