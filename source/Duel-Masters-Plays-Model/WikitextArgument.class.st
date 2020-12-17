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

{ #category : #'accessing-testing' }
WikitextArgument >> hasContent: aPotentialContent [

	^ content = aPotentialContent
]

{ #category : #initialization }
WikitextArgument >> initializeNamedOptional: aNameOptional withContent: aContent [

	nameOptional := aNameOptional.
	content := aContent
]

{ #category : #'accessing-testing' }
WikitextArgument >> isNamed: aPotentialArgumentName [

	^ nameOptional withContentDo: [ :name | name = aPotentialArgumentName ] ifUnused: [ false ]
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
