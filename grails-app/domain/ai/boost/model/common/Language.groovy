package ai.boost.model.common

import org.grails.datastore.mapping.core.connections.ConnectionSource

class Language {

    public Long id

    String description
    String i18nCode

    // IETF BCP 47 specification
    String localeTag

    static constraints = {
        description nullable: false
        i18nCode nullable: false
        localeTag nullable: false
    }

    static mapping = {
        version false
        id generator:'sequence', params:[sequence: 'language_seq']
        datasources([ConnectionSource.DEFAULT, 'qa'])
    }

    Long getId() {
        return id
    }

}
