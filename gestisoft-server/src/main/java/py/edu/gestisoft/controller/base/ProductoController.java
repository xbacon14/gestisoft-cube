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
}
