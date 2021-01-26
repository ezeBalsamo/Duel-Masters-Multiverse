Class {
	#name : #Race,
	#superclass : #Object,
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #testing }
Race >> isGeneric [

	^false
]

{ #category : #testing }
Race >> isOfTypeNamed: aPotentialTypeName [

	self subclassResponsibility
]
