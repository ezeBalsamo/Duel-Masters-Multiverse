Class {
	#name : #Duelist,
	#superclass : #Object,
	#instVars : [
		'name',
		'deck'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
Duelist class >> named: aName using: aDeck [

	AssertionCheckerBuilder new
		raising: InstanceCreationFailed;
		checking: [ :asserter | 
			asserter
				refuse: [ aName isEmpty ] because: 'A duelist must have a name.';
				refuse: [ aDeck isEmpty ] because: 'A duelist deck must have cards.'
			];
		buildAndCheck.

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
