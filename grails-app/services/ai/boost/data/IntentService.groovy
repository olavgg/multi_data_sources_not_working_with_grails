package ai.boost.data

import ai.boost.model.intent.Intent
import grails.gorm.transactions.Transactional

@Transactional(connection = 'qa')
class IntentService {

    def readIntent() {
        Intent intent = Intent.get(1)
        intent.titles.each{
            println it.title
        }
    }
}
