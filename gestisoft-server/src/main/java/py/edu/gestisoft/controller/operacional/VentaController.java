package py.edu.gestisoft.controller.operacional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	@GetMapping("/getProximoId")
	public ResponseEntity<Long> getProximoId() {
		return ResponseEntity.ok(ventaService.getProximoId());
	}

	@GetMapping("/findByNombre")
	public ResponseEntity<List<Venta>> findByNombre(@RequestParam String condition) {

		return ResponseEntity.ok(ventaService.findByNombre(condition));

	}

	@PutMapping("/cancelar")
	public ResponseEntity<Venta> cancelaVenta(@RequestParam Long venta) {
		return ResponseEntity.ok(ventaService.cancelaVenta(venta));
	}

	@GetMapping("/generaReporte")
	public ResponseEntity<?> generaReporte(@RequestParam Long cliente, @RequestParam String docNro,
			@RequestParam String dtInicio, @RequestParam String dtFinal, @RequestParam boolean verPdf) {
		return ResponseEntity.ok(ventaService.generaReporteVenta(cliente, docNro, dtInicio, dtFinal, verPdf));
	}
}
