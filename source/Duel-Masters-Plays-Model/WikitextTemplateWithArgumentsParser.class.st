Class {
	#name : #WikitextTemplateWithArgumentsParser,
	#superclass : #WikitextTemplateParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextTemplateWithArgumentsParser class >> canHandle: aWikitextTemplateToParse [

	^ ( self isNamed: aWikitextTemplateToParse ) and: [ self hasArguments: aWikitextTemplateToParse ]
]

{ #category : #parsing }
WikitextTemplateWithArgumentsParser >> parse [

	| templateNameAndArgumentsSplitted templateName arguments |

	templateNameAndArgumentsSplitted := self splitTemplateNameFromArguments.

	templateName := self parseTemplateNameFrom: templateNameAndArgumentsSplitted.
	arguments := self parseWikitextArgumentsFrom: templateNameAndArgumentsSplitted.

	^ WikitextTemplate named: templateName withArguments: arguments
]

{ #category : #'parsing - private' }
WikitextTemplateWithArgumentsParser >> parseTemplateNameFrom: aTemplateNameAndArgumentsCollection [

	^ aTemplateNameAndArgumentsCollection first trimBoth
]

{ #category : #'parsing - private' }
WikitextTemplateWithArgumentsParser >> parseWikitextArgumentFrom: aWikitextArgumentToParse [

	^ ( WikitextArgumentParser toParse: aWikitextArgumentToParse ) parse
]

{ #category : #'parsing - private' }
WikitextTemplateWithArgumentsParser >> parseWikitextArgumentsFrom: aTemplateNameAndArgumentsCollection [

	^ ( self splittedWikitextArgumentsIn: aTemplateNameAndArgumentsCollection second )
		collect: [ :aWikitextArgumentToParse | self parseWikitextArgumentFrom: aWikitextArgumentToParse ]
]

{ #category : #'parsing - private' }
WikitextTemplateWithArgumentsParser >> splitTemplateNameFromArguments [

	^ wikitextTemplateToParse splitOnFirstOccurrenceOf: '|'
]

{ #category : #parsing }
WikitextTemplateWithArgumentsParser >> splittedWikitextArgumentsIn: aWikitextArgumentCollectionToSplit [

	^ ( WikitextArgumentsSplitter splitting: aWikitextArgumentCollectionToSplit ) split
]
