package ai.boost.sql;

import org.hibernate.dialect.PostgreSQL9Dialect;

import java.sql.Types;

/**
 * Created by olav on 01.06.17.
 */
public class PgBoostDialect extends PostgreSQL9Dialect {

    public PgBoostDialect(){
        super();
        registerColumnType(Types.TIMESTAMP, "timestamp with time zone");
    }
}
