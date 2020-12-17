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

	^ content = aPotentialContent
]

{ #category : #'testing - private' }
WikitextArgument >> hasEquivalentNamingWith: aPotentialWikitextArgument [

	^ nameOptional
		withContentDo: [ :name | aPotentialWikitextArgument isNamed: name ]
		ifUnused: [ aPotentialWikitextArgument isUnnamed ]
]

{ #category : #initialization }
WikitextArgument >> initializeNamedOptional: aNameOptional withContent: aContent [

	nameOptional := aNameOptional.
	content := aContent
]

{ #category : #testing }
WikitextArgument >> isEquivalentTo: aPotentialWikitextArgument [

	^ ( aPotentialWikitextArgument hasContent: content )
		and:
			[ self hasEquivalentNamingWith: aPotentialWikitextArgument ]
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

	aStream nextPutAll: 'Wikitext argument '.
	self printNameOptionalOn: aStream.

	aStream
		nextPutAll: ' with ';
		nextPutAll: content
]
