package py.edu.gestisoft.model.sistema;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

@Entity
@Table(name = "DATOS_EMPRESA")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class DatosEmpresa {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_DATOS_EMPRESA")
	private Long id;

	@NonNull
	@Column(name = "NOMBRE")
	private String nombre;

	@NonNull
	@Column(name = "RUC")
	private String ruc;

	@Column(name = "CELULAR")
	private String celular;

	@Column(name = "LINEA_BAJA")
	private String lineaBaja;

	@Column(name = "EMAIL")
	private String email;

	@Column(name = "CIUDAD")
	private String ciudad;

	@Column(name = "DIRECCION")
	private String direccion;

	@Column(name = "OBSERVACION")
	private String observacion;

	@Column(name = "FECHA_REGISTRO")
	private LocalDateTime fechaRegistro;

	@Column(name = "BO_CONFIGURACION_EFECTUADA")
	private Boolean configuracionEfectuada;

	@PrePersist
	void setFechaRegistro() {
		this.fechaRegistro = LocalDateTime.now();
	}

}
