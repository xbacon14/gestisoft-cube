package py.edu.gestisoft.controller.base;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import py.edu.gestisoft.model.sistema.DatosEmpresa;
import py.edu.gestisoft.service.base.ConfiguracionService;

@RestController
@CrossOrigin
@RequestMapping({ "/api/configuracion" })
public class ConfiguracionController {

	@Autowired
	private ConfiguracionService configuracionService;

	@GetMapping("/configuracion_efectuada")
	public ResponseEntity<?> verificarConfiguracionEfectuada() {
		DatosEmpresa e = configuracionService.verificarConfiguracionEfectuada();
		if (e == null) {
			return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
		}
		return ResponseEntity.ok(e);
	}

	@PutMapping("/truncate")
	public ResponseEntity<Boolean> truncateTables() {
		return ResponseEntity.ok(configuracionService.truncateTables());
	}

	@GetMapping("/verificar_conexion")
	public ResponseEntity<Boolean> findAllClientes() {
		return ResponseEntity.ok(true);
	}

}
