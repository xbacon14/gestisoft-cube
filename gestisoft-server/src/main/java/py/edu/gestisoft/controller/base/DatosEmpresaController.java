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

import py.edu.gestisoft.model.sistema.DatosEmpresa;
import py.edu.gestisoft.service.sistema.DatosEmpresaService;

@RestController
@CrossOrigin
@RequestMapping({ "/api/empresa" })
public class DatosEmpresaController {
	@Autowired
	private DatosEmpresaService datosEmpresaService;

	@PostMapping("/save")
	public ResponseEntity<DatosEmpresa> save(@RequestBody DatosEmpresa datosEmpresa) {
		datosEmpresa = datosEmpresaService.save(datosEmpresa);
		return ResponseEntity.ok(datosEmpresa);
	}

	@GetMapping("/findAll")
	public ResponseEntity<List<DatosEmpresa>> findAllEmpresas() {
		return ResponseEntity.ok(datosEmpresaService.findAllDatosEmpresa());
	}
}
