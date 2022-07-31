package py.edu.gestisoft.controller.operacional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import py.edu.gestisoft.model.operacional.Venta;
import py.edu.gestisoft.service.operacional.VentaService;

@RestController
@CrossOrigin
@RequestMapping({ "/api/venta" })
public class VentaController {
	// INYECTA EL SERVICE DEL MODULO VENTA
	@Autowired
	private VentaService ventaService;

//	GUARDA LA ENTIDAD VENTA
	@PostMapping("/save")
	public ResponseEntity<Venta> save(@RequestBody Venta venta) {
		venta = ventaService.save(venta);
		return ResponseEntity.ok(venta);
	}

	@GetMapping("/findAll")
	public ResponseEntity<List<Venta>> findAllVentas() {
		return ResponseEntity.ok(ventaService.findAllVentas());
	}

}
