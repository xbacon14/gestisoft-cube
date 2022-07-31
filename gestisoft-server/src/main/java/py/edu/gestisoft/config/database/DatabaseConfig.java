package py.edu.gestisoft.config.database;

import javax.sql.DataSource;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DatabaseConfig {

	@Bean
	public DataSource getDataSource() {
		DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
		// dataSourceBuilder.driverClassName("com.mysql.jdbc.Driver");
		dataSourceBuilder
				.url("jdbc:mysql://localhost:3306/gestisoft_db?useSSL=false&useUnicode=true&serverTimezone=UTC");
//		dataSourceBuilder.url("jdbc:mysql://localhost:3307/saas_salao?useSSL=false&useUnicode=true&serverTimezone=UTC");
		dataSourceBuilder.username("root");
		dataSourceBuilder.password("84125497");
		return dataSourceBuilder.build();
	}

}