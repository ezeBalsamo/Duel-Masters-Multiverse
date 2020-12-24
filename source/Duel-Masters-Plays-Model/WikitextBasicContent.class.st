Class {
	#name : #WikitextBasicContent,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
WikitextBasicContent class >> being: aContent [

	^ self new initializeBeing: aContent
]

{ #category : #testing }
WikitextBasicContent >> hasContent: aPotentialContent [

	^ content = aPotentialContent
]

{ #category : #intialization }
WikitextBasicContent >> initializeBeing: aContent [

	content := aContent
]

{ #category : #testing }
WikitextBasicContent >> isEquivalentTo: aWikitextBasicContent [

	^ aWikitextBasicContent hasContent: content
]

{ #category : #printing }
WikitextBasicContent >> printOn: aStream [

	aStream
		nextPutAll: 'Basic Content: ';
		nextPutAll: content
]
