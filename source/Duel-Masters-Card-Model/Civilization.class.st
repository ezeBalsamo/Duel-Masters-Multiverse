Class {
	#name : #Civilization,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #'instance creation' }
Civilization class >> darkness [

	^self ofType: 'Darkness'
]

{ #category : #'instance creation' }
Civilization class >> fire [

	^ self ofType: 'Fire'
]

{ #category : #'instance creation' }
Civilization class >> light [

	^self ofType: 'Light'
]

{ #category : #'instance creation' }
Civilization class >> nature [

	^self ofType: 'Nature'
]

{ #category : #'private - instance creation' }
Civilization class >> ofType: aCivilizationType [

	^ self new initializeOfType: aCivilizationType
]

{ #category : #'instance creation' }
Civilization class >> water [

	^ self ofType: 'Water'
]

{ #category : #initialization }
Civilization >> initializeOfType: aCivilizationType [

	type := aCivilizationType
]

{ #category : #testing }
Civilization >> isEquivalentTo: aCivilization [

	^ aCivilization isOfType: type
]

{ #category : #'private - testing' }
Civilization >> isOfType: aPotentialType [

	^ type = aPotentialType
]

{ #category : #printing }
Civilization >> printOn: aStream [

	aStream
		nextPutAll: type;
		space;
		nextPutAll: self class name asLowercase
]
