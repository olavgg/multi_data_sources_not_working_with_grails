package ai.boost.model.intent

import ai.boost.model.common.Language
import org.grails.datastore.mapping.core.connections.ConnectionSource

import java.sql.Timestamp

class IntentTitle {

    public Long id
    String title
    Language language

    Timestamp dateCreated
    Timestamp lastUpdated

    static belongsTo = [intent: Intent]

    static constraints = {
        intent nullable: false
        title nullable: false
        language nullable: false
    }

    static mapping = {
        version false
        id generator:'sequence', params:[sequence: 'intent_title_seq']
        datasources([ConnectionSource.DEFAULT, 'qa'])
    }

    Long getId() {
        return id
    }

}
