Class {
	#name : #DMUnits,
	#superclass : #Object,
	#classInstVars : [
		'mana',
		'power'
	],
	#category : #'DM-Card-Model'
}

{ #category : #'class initialization' }
DMUnits class >> initialize [

	self
		initializeMana;
		initializePower
]

{ #category : #'class initialization' }
DMUnits class >> initializeMana [

	mana := BaseUnit named: 'mana'
]

{ #category : #'class initialization' }
DMUnits class >> initializePower [

	power := BaseUnit named: 'power'
]

{ #category : #accessing }
DMUnits class >> mana [

	^ mana
]

{ #category : #accessing }
DMUnits class >> power [

	^ power
]
