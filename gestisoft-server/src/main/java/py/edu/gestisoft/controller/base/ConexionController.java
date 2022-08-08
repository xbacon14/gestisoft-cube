package py.edu.gestisoft.controller.base;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import py.edu.gestisoft.model.base.Cliente;

@RestController
@CrossOrigin
@RequestMapping({ "/api/configuracion" })
public class ConexionController {

	@GetMapping("/verificar_conexion")
	public ResponseEntity<Boolean> findAllClientes() {
		return ResponseEntity.ok(true);
	}
}
