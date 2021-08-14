"
A DuelistTest is a test class for testing the behavior of Duelist
"
Class {
	#name : #DuelistTest,
	#superclass : #TestCase,
	#category : #'DM-Match-Model-Tests'
}

{ #category : #'private - accessing' }
DuelistTest >> deck [

	^ ( ( 1 to: 40 ) collect: #asString ) asOrderedCollection
]

{ #category : #tests }
DuelistTest >> test01DuelistMustHaveName [

	| deck |

	deck := self deck.
	self
		should: [ Duelist named: '' using: deck ]
		raise: InstanceCreationFailed
		withMessageText: 'A duelist must have a name.'
]

{ #category : #tests }
DuelistTest >> test02DeckMustNotBeEmpty [

	self
		should: [ Duelist named: 'Shobu' using: #() ]
		raise: InstanceCreationFailed
		withMessageText: 'A duelist deck must have cards.'
]

{ #category : #tests }
DuelistTest >> test03InstanceCreationAndAccessing [

	| name deck duelist |

	name := 'Shobu'.
	deck := self deck.

	duelist := Duelist named: name using: deck.

	self
		assert: duelist name equals: name;
		assert: duelist deck equals: deck
]

{ #category : #tests }
DuelistTest >> test04PrintString [

	| name duelist |

	name := 'Shobu'.

	duelist := Duelist named: name using: self deck.

	self assert: duelist asString equals: name
]

{ #category : #tests }
DuelistTest >> test05DrawingCardMakesDeckToHaveOneLessCard [

	| numberOfCards duelist |

	duelist := Duelist named: 'Shobu' using: self deck.
	numberOfCards := duelist numberOfCardsInDeck.

	duelist drawCard.

	self assert: duelist numberOfCardsInDeck equals: numberOfCards - 1
]

{ #category : #tests }
DuelistTest >> test06DrawingFiveCardsMakesDeckToHaveFiveLessCards [

	| numberOfCards duelist cards |

	duelist := Duelist named: 'Shobu' using: self deck.
	numberOfCards := duelist numberOfCardsInDeck.

	cards := duelist drawFiveCards.

	self
		assert: cards size equals: 5;
		assert: duelist numberOfCardsInDeck equals: numberOfCards - 5
]
