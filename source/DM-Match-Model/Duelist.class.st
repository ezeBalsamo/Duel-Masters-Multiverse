Class {
	#name : #Duelist,
	#superclass : #Object,
	#instVars : [
		'name',
		'deck'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'private - preconditions' }
Duelist class >> assertNotEmpty: aPotentialDuelistName [

	AssertionChecker
		enforce: [ aPotentialDuelistName notEmpty ]
		because: 'A duelist must have a name.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
Duelist class >> named: aName using: aDeck [

	self assertNotEmpty: aName.

	^ self new initializeNamed: aName using: aDeck
]

{ #category : #accessing }
Duelist >> deck [

	^ deck
]

{ #category : #accessing }
Duelist >> drawCard [

	^ deck first
]

{ #category : #accessing }
Duelist >> drawFiveCards [

	^ deck first: 5
]

{ #category : #initialization }
Duelist >> initializeNamed: aName using: aDeck [

	name := aName.
	deck := aDeck
]

{ #category : #accessing }
Duelist >> name [

	^ name
]

{ #category : #printing }
Duelist >> printOn: aStream [

	aStream nextPutAll: name
]
