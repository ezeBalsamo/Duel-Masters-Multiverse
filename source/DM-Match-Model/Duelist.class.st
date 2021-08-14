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

	^ ( self drawNumberOfCards: 1 ) anyOne
]

{ #category : #accessing }
Duelist >> drawFiveCards [

	^ self drawNumberOfCards: 5
]

{ #category : #accessing }
Duelist >> drawNumberOfCards: aNumberOfCards [

	| cards |

	cards := deck first: aNumberOfCards.
	deck removeFirst: aNumberOfCards.
	^ cards
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

{ #category : #accessing }
Duelist >> numberOfCardsInDeck [

	^ deck size
]

{ #category : #printing }
Duelist >> printOn: aStream [

	aStream nextPutAll: name
]
