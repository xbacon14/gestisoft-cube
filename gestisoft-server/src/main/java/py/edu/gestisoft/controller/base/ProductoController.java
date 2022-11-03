package py.edu.gestisoft.controller.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import py.edu.gestisoft.model.base.Producto;
import py.edu.gestisoft.service.base.ProductoService;

@RestController
@CrossOrigin
@RequestMapping({ "/api/producto" })
public class ProductoController {
//	INYECTA EL SERVICIO DEL MODULO PRODUCTO
	@Autowired
	private ProductoService productoService;

//	GUARDA UN PRODUCTO
	@PostMapping("/save")
	public ResponseEntity<Producto> save(@RequestBody Producto producto) {
		producto = productoService.save(producto);
		return ResponseEntity.ok(producto);
	}

//	DEVUELVE TODOS LOS PRODUCTOS DE LA TABLA PRODUCTOS
	@GetMapping("/findAll")
	public ResponseEntity<List<Producto>> findAllProductos() {
		return ResponseEntity.ok(productoService.findAllProductos());
	}

	@GetMapping("/findByNombre")
	public ResponseEntity<List<Producto>> findByNombre(@RequestParam String condition) {

		return ResponseEntity.ok(productoService.findByNombre(condition));

	}

	@GetMapping("/findByNombreOCodigo")
	public ResponseEntity<List<Producto>> findByNombreOCodigo(@RequestParam String condition) {
		return ResponseEntity.ok(productoService.findByNombre(condition));

	}

	@GetMapping("/generaReporte")
	public ResponseEntity<?> generaReporte(@RequestParam String filtroDesde, @RequestParam String filtroHasta,
			@RequestParam String orderByCondition, @RequestParam boolean verInactivos, @RequestParam boolean verPdf) {
		return ResponseEntity.ok(
				productoService.generaReporteCliente(filtroDesde, filtroHasta, verInactivos, orderByCondition, verPdf));
	}
}
