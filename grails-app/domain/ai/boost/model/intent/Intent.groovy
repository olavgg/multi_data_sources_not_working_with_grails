package ai.boost.model.intent

import org.grails.datastore.mapping.core.connections.ConnectionSource

import java.sql.Timestamp

class Intent {

    public Long id
    Intent parentIntent
    Boolean deactivated = false

    Timestamp dateCreated
    Timestamp lastUpdated

    static hasMany = [
            titles: IntentTitle
    ]

    static constraints = {
        parentIntent nullable: true
    }

    static mapping = {
        version false
        id generator:'sequence', params:[sequence: 'intent_seq']

        parentIntent index:'intent_parent_intent_idx'
        deactivated index:'intent_deactivated_idx'

        deactivated defaultValue: 'false'

        datasources([ConnectionSource.DEFAULT, 'qa'])
    }

    Long getId() {
        return id
    }

}
