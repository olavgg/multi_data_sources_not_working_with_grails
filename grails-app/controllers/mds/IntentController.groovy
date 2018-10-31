package mds

import ai.boost.data.IntentService
import grails.core.GrailsApplication

class IntentController {

    GrailsApplication grailsApplication
    IntentService intentService

    def index() { redirect action: 'showIntentTitles' }

    def showIntentTitles(){

        grailsApplication
            .mainContext
            .beanDefinitionNames
            .findAll{
                it.contains( 'dataSource' )
            }.each{
                println it
            }

        intentService.readIntent()

        render "ok"
    }
}
