package py.edu.gestisoft.model.base;

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
@Table(name = "CLIENTE")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
// CAMBIAR NOMBRE PARA EMPRESA NOMAS?
public class DatosEmpresa {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_DATOS_EMPRESA")
	private Long id;

	@NonNull
	@Column(name = "NOMBRE")
	private String nombre;

	@Column(name = "CI_RUC")
	private String ciRuc;

	@Column(name = "CORREO_ELECTRONICO")
	private String correoElectronico;

	@Column(name = "NUMERO_CELULAR")
	private String numeroCelular;

	@Column(name = "NUMERO_LINEA_BAJA")
	private String numeroLineaBaja;

	@Column(name = "DIRECCION")
	private String direccion;

	@Column(name = "OBSERVACION")
	private String observacion;

	@Column(name = "CIUDAD")
	private String ciudad;

	@Column(name = "FECHA_REGISTRO")
	private LocalDateTime fechaRegistro;

	@PrePersist
	void setFechaRegistro() {
		this.fechaRegistro = LocalDateTime.now();
	}
}
