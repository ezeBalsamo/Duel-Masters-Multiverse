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

{ #category : #'private - parsing' }
NamedWikitextArgumentParser >> parseArgumentContentFrom: anArgumentNameAndContentCollection [

	^ ( WikitextContentParser toParse: anArgumentNameAndContentCollection second ) parse
]

{ #category : #'private - parsing' }
NamedWikitextArgumentParser >> parseArgumentNameFrom: anArgumentNameAndContentCollection [

	^ WikitextWhiteSpacesCleaner new
		clean: anArgumentNameAndContentCollection first
]

{ #category : #'private - parsing' }
NamedWikitextArgumentParser >> splitArgumentNameFromContent [

	^ wikitextArgumentToParse
		splitOnFirstOccurrenceOf: '='
		ifNone: [ "do nothing.- ebalsamo" ]
]
