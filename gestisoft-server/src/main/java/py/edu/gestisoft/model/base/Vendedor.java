package py.edu.gestisoft.model.base;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

@Entity
@Table(name = "VENDEDOR")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Vendedor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_VENDEDOR")
	private Long id;

	@NonNull
	@Column(name = "ESTADO")
	private Boolean estado;

	@NonNull
	@Column(name = "NOMBRE")
	private String nombre;

	@Column(name = "CI_RUC")
	private String ciRuc;

	@Column(name = "NUMERO_CELULAR")
	private String numeroCelular;

	@Column(name = "NUMERO_LINEA_BAJA")
	private String numeroLineaBaja;

	@Column(name = "CIUDAD")
	private String ciudad;

	@Column(name = "DIRECCION")
	private String direccion;

	@Column(name = "OBSERVACION")
	private String observacion;

	@Column(name = "FECHA_ALTA")
	private LocalDateTime fechaAlta;
}
