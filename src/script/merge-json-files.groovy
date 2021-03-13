import static groovy.io.FileType.FILES

import groovy.json.JsonOutput;
import groovy.json.JsonSlurper

def sourceFolder =  new File(properties['sourceFolder'])
def output =  new File(properties['outputFile'])

println "Merging json files found in $sourceFolder"

def jsonOuput = []
def jsonSlurper = new JsonSlurper()
sourceFolder.eachFileRecurse(FILES) {
    if(it.name.endsWith('.json')) {
        jsonOuput << jsonSlurper.parse(it)
        println "Merging $it"
    }
}

def json = JsonOutput.toJson(jsonOuput)
if(output.exists()) {
    output.delete()
}
output.parentFile.mkdirs()
if(output.createNewFile()) {
    output.write(json)
    println "Wrote merged json result to $output"
}
