Class {
	#name : #WikitextArgument,
	#superclass : #Object,
	#instVars : [
		'content',
		'nameBinding'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
WikitextArgument class >> named: aName content: aContent [

	^ self namedBinding: ( Binding to: aName ) withContent: aContent
]

{ #category : #'instance creation' }
WikitextArgument class >> namedBinding: aNameBinding withContent: aContent [

	^ self new initializeNamedBinding: aNameBinding withContent: aContent
]

{ #category : #accessing }
WikitextArgument class >> notDefinedNameMessageText [

	^ 'No se definió un nombre.'
]

{ #category : #'instance creation' }
WikitextArgument class >> unnamedWithContent: aContent [

	^ self
		namedBinding: ( Binding undefinedExplainedBy: self notDefinedNameMessageText raising: Error )
		withContent: aContent
]

{ #category : #accessing }
WikitextArgument >> content [

	^ content
]

{ #category : #initialization }
WikitextArgument >> initializeNamedBinding: aNameBinding withContent: aContent [

	nameBinding := aNameBinding.
	content := aContent
]

{ #category : #accessing }
WikitextArgument >> name [

	^ nameBinding content
]
