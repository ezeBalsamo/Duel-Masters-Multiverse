Class {
	#name : #WikitextArgument,
	#superclass : #Object,
	#instVars : [
		'content',
		'nameOptional'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
WikitextArgument class >> named: aName content: aContent [

	^ self namedOptional: ( Optional containing: aName ) withContent: aContent
]

{ #category : #'instance creation' }
WikitextArgument class >> namedOptional: aNameBinding withContent: aContent [

	^ self new initializeNamedOptional: aNameBinding withContent: aContent
]

{ #category : #'instance creation' }
WikitextArgument class >> unnamedWithContent: aContent [

	^ self namedOptional: Optional unused withContent: aContent
]

{ #category : #testing }
WikitextArgument >> hasContent: aPotentialContent [

	^ ( WikitextArgumentContentEquivalenceAnalyzer
		analyzingEquivalenceBetween: content
		and: aPotentialContent ) areEquivalents
]

{ #category : #'testing-private' }
WikitextArgument >> hasEquivalentNamingThan: aPotentialWikitextArgument [

	^ nameOptional
		withContentDo: [ :name | aPotentialWikitextArgument isNamed: name ]
		ifUnused: [ aPotentialWikitextArgument isUnnamed ]
]

{ #category : #testing }
WikitextArgument >> hasSameContentThan: aWikitextArgument [

	^ aWikitextArgument hasContent: content
]

{ #category : #testing }
WikitextArgument >> hasSameNameThan: aWikitextArgument [

	^ nameOptional withContentDo: [ :name | aWikitextArgument isNamed: name ] ifUnused: [ false ]
]

{ #category : #initialization }
WikitextArgument >> initializeNamedOptional: aNameOptional withContent: aContent [

	nameOptional := aNameOptional.
	content := aContent
]

{ #category : #testing }
WikitextArgument >> isEquivalentTo: aWikitextArgument [

	^ ( self hasSameContentThan: aWikitextArgument )
		and: [ self hasEquivalentNamingThan: aWikitextArgument ]
]

{ #category : #testing }
WikitextArgument >> isNamed: aPotentialName [

	^ nameOptional withContentDo: [ :name | name = aPotentialName ] ifUnused: [ false ]
]

{ #category : #testing }
WikitextArgument >> isUnnamed [

	^ nameOptional withContentDo: [ :name | false ] ifUnused: [ true ]
]

{ #category : #printing }
WikitextArgument >> printNameOptionalOn: aStream [

	nameOptional
		withContentDo: [ :aName | 
			aStream
				nextPutAll: 'named ';
				nextPutAll: aName
			]
		ifUnused: [ aStream nextPutAll: 'unnamed' ]
]

{ #category : #printing }
WikitextArgument >> printOn: aStream [

	aStream nextPutAll: 'Wikitext Argument '.
	self printNameOptionalOn: aStream.

	aStream nextPutAll: ' with '.
	content printOn: aStream
]
