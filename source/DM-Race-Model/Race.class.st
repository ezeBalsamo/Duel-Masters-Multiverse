Class {
	#name : #Race,
	#superclass : #Object,
	#category : #'DM-Race-Model'
}

{ #category : #testing }
Race >> isGeneric [

	self subclassResponsibility
]

{ #category : #testing }
Race >> isOfTypeNamed: aPotentialTypeName [

	self subclassResponsibility
]
