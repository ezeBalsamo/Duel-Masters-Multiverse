Class {
	#name : #NamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
NamedWikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	^ ( self isUnnamedArgumentWithTemplateContent: aWikitextArgumentToParse ) not
		and: [ self isNamed: aWikitextArgumentToParse ]
]

{ #category : #parsing }
NamedWikitextArgumentParser >> parse [

	| argumentNameAndContentSplitted argumentName argumentContent |

	argumentNameAndContentSplitted := self splitArgumentNameFromContent.
	argumentName := self parseArgumentNameFrom: argumentNameAndContentSplitted.
	argumentContent := self parseArgumentContentFrom: argumentNameAndContentSplitted.

	^ WikitextArgument named: argumentName withContent: argumentContent
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> parseArgumentContentFrom: anArgumentNameAndContentCollection [

	^ ( WikitextContentParser toParse: anArgumentNameAndContentCollection second ) parse
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> parseArgumentNameFrom: anArgumentNameAndContentCollection [

	^ anArgumentNameAndContentCollection first trimBoth
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> splitArgumentNameFromContent [

	^ wikitextArgumentToParse
		splitOnFirstOccurrenceOf: '='
		ifNone: [ "do nothing.- ebalsamo" ]
]
