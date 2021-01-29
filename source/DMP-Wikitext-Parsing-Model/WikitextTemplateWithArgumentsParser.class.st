Class {
	#name : #WikitextTemplateWithArgumentsParser,
	#superclass : #WikitextTemplateParser,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
WikitextTemplateWithArgumentsParser class >> canHandle: aWikitextTemplateToParse [

	^ self hasArguments: aWikitextTemplateToParse
]

{ #category : #parsing }
WikitextTemplateWithArgumentsParser >> parse [

	| templateNameAndArgumentsSplitted templateName arguments |

	templateNameAndArgumentsSplitted := self splitTemplateNameFromArguments.

	templateName := self parseTemplateNameFrom: templateNameAndArgumentsSplitted.
	arguments := self parseWikitextArgumentsFrom: templateNameAndArgumentsSplitted.

	^ WikitextTemplate named: templateName withArguments: arguments
]

{ #category : #'private - parsing' }
WikitextTemplateWithArgumentsParser >> parseTemplateNameFrom: aTemplateNameAndArgumentsCollection [

	^ WikitextWhiteSpacesCleaner new
		clean: aTemplateNameAndArgumentsCollection first
]

{ #category : #'private - parsing' }
WikitextTemplateWithArgumentsParser >> parseWikitextArgumentFrom: aWikitextArgumentToParse [

	^ ( WikitextArgumentParser toParse: aWikitextArgumentToParse ) parse
]

{ #category : #'private - parsing' }
WikitextTemplateWithArgumentsParser >> parseWikitextArgumentsFrom: aTemplateNameAndArgumentsCollection [

	^ ( self splittedWikitextArgumentsIn: aTemplateNameAndArgumentsCollection second )
		collect: [ :aWikitextArgumentToParse | self parseWikitextArgumentFrom: aWikitextArgumentToParse ]
]

{ #category : #'private - parsing' }
WikitextTemplateWithArgumentsParser >> splitTemplateNameFromArguments [

	^ wikitextTemplateToParse
		splitOnFirstOccurrenceOf: '|'
		ifNone: [ "do nothing.- ebalsamo" ]
]

{ #category : #parsing }
WikitextTemplateWithArgumentsParser >> splittedWikitextArgumentsIn: aWikitextArgumentCollectionToSplit [

	^ ( WikitextArgumentsSplitter splitting: aWikitextArgumentCollectionToSplit ) split
]
