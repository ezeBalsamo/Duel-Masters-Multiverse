"
A MatchTest is a test class for testing the behavior of Match
"
Class {
	#name : #MatchTest,
	#superclass : #TestCase,
	#instVars : [
		'shobu',
		'knight',
		'match'
	],
	#category : #'DM-Match-Model-Tests'
}

{ #category : #asserting }
MatchTest >> assertTheOnlyElementIn: aCollection is: anExpectedObject [

	self
		withTheOnlyOneIn: aCollection
		do: [ :anObject | self assert: anObject equals: anExpectedObject ]
]

{ #category : #accessing }
MatchTest >> fireCivilization [

	^ SingleCivilization named: self fireCivilizationName
]

{ #category : #accessing }
MatchTest >> fireCivilizationName [

	^ 'Fire'
]

{ #category : #accessing }
MatchTest >> humanRace [

	^ SingleRace ofTypeNamed: self humanRaceTypeName
]

{ #category : #accessing }
MatchTest >> humanRaceTypeName [

	^ 'Human'
]

{ #category : #accessing }
MatchTest >> immortalBaronVorg [

	^ CreatureCard
		named: 'Immortal Baron, Vorg'
		from: self fireCivilization
		and: self humanRace
		costing: ( self mana with: 2 )
		providing: ( self mana with: 1 )
		with: ( self power with: 2000 )
]

{ #category : #accessing }
MatchTest >> intruder [

	^ 'Intruder'
]

{ #category : #accessing }
MatchTest >> mana [

	^ BaseUnit named: 'mana'
]

{ #category : #accessing }
MatchTest >> power [

	^ BaseUnit named: 'power'
]

{ #category : #running }
MatchTest >> setUp [

	super setUp.

	shobu := 'Shobu'.
	knight := 'Knight'.
	match := Match between: shobu and: knight
]

{ #category : #'tests - mana charge' }
MatchTest >> test01PlayerChargesMana [

	| immortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaChargedBy: shobu ) isEmpty.
	match chargeManaOf: shobu with: immortalBaronVorg.
	self assertTheOnlyElementIn: ( match manaChargedBy: shobu ) is: immortalBaronVorg
]

{ #category : #'tests - drawing cards' }
MatchTest >> test01PlayerDrawsCard [

	self assert: ( match cardsInHandOf: shobu ) size equals: 5.
	match drawCardFor: shobu.
	self assert: ( match cardsInHandOf: shobu ) size equals: 6
]

{ #category : #'tests - field setup' }
MatchTest >> test01PlayersBeginTheMatchWithFiveCardsInHand [

	self
		assert: ( match cardsInHandOf: shobu ) size equals: 5;
		assert: ( match cardsInHandOf: knight ) size equals: 5
]

{ #category : #'tests - turn order' }
MatchTest >> test01PlayersTurnOrderIsCircular [

	self assert: ( match isTurnOf: shobu ).
	match endTurnOf: shobu.
	self assert: ( match isTurnOf: knight ).
	match endTurnOf: knight.
	self assert: ( match isTurnOf: shobu )
]

{ #category : #'tests - mana charge' }
MatchTest >> test02PlayerCantChargeManaOnOpponentsTurn [

	| immortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	self
		assert: ( match isTurnOf: shobu );
		assert: ( match manaChargedBy: knight ) isEmpty;
		should: [ match chargeManaOf: knight with: immortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t charge mana on your opponent''s turn.';
		assert: ( match manaChargedBy: knight ) isEmpty
]

{ #category : #'tests - drawing cards' }
MatchTest >> test02PlayerCantDrawCardOnOpponentsTurn [

	self
		assert: ( match isTurnOf: shobu );
		assert: ( match cardsInHandOf: knight ) size equals: 5;
		should: [ match drawCardFor: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t draw a card on your opponent''s turn.';
		assert: ( match cardsInHandOf: knight ) size equals: 5
]

{ #category : #'tests - turn order' }
MatchTest >> test02PlayerCantEndOpponentsTurn [

	self
		assert: ( match isTurnOf: shobu );
		should: [ match endTurnOf: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t end your opponent''s turn.';
		assert: ( match isTurnOf: shobu )
]

{ #category : #'tests - field setup' }
MatchTest >> test02PlayersBeginTheMatchWithFiveShields [

	self
		assert: ( match shieldsOf: shobu ) size equals: 5;
		assert: ( match shieldsOf: knight ) size equals: 5
]

{ #category : #'tests - mana charge' }
MatchTest >> test03PlayerCantChargeManaMoreThanOnceInTheSameTurn [

	| immortalBaronVorg anotherImmortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	anotherImmortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaChargedBy: shobu ) isEmpty.
	match chargeManaOf: shobu with: immortalBaronVorg.
	self
		assertTheOnlyElementIn: ( match manaChargedBy: shobu ) is: immortalBaronVorg;
		should: [ match chargeManaOf: shobu with: anotherImmortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: 'Shobu: Mana can only be charged once per turn.';
		assertTheOnlyElementIn: ( match manaChargedBy: shobu ) is: immortalBaronVorg
]

{ #category : #'tests - drawing cards' }
MatchTest >> test03PlayerCantDrawMoreThanOneCardInTheSameTurn [

	self assert: ( match cardsInHandOf: shobu ) size equals: 5.
	match drawCardFor: shobu.
	self
		assert: ( match cardsInHandOf: shobu ) size equals: 6;
		should: [ match drawCardFor: shobu ]
			raise: IllegalPlay
			withMessageText: 'Shobu: Only one card can be drawn per turn.';
		assert: ( match cardsInHandOf: shobu ) size equals: 6
]

{ #category : #'tests - turn order' }
MatchTest >> test03PlayerNotBelongingToMatchCantEndOpponentsTurn [

	| intruder |

	intruder := self intruder.

	self
		should: [ match endTurnOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - field setup' }
MatchTest >> test03PlayersBeginTheMatchWithoutChargedMana [

	self
		assert: ( match manaChargedBy: shobu ) isEmpty;
		assert: ( match manaChargedBy: knight ) isEmpty
]

{ #category : #'tests - mana charge' }
MatchTest >> test04PlayerCanChargeManaEveryTurn [

	| immortalBaronVorg anotherImmortalBaronVorg expectedChargedMana |

	immortalBaronVorg := self immortalBaronVorg.
	anotherImmortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaChargedBy: shobu ) isEmpty.

	match chargeManaOf: shobu with: immortalBaronVorg.
	self assertTheOnlyElementIn: ( match manaChargedBy: shobu ) is: immortalBaronVorg.

	match
		endTurn;
		endTurn;
		chargeManaOf: shobu with: anotherImmortalBaronVorg.

	expectedChargedMana := Array with: immortalBaronVorg with: anotherImmortalBaronVorg.
	self assertCollection: ( match manaChargedBy: shobu ) hasSameElements: expectedChargedMana
]

{ #category : #'tests - drawing cards' }
MatchTest >> test04PlayerCanDrawCardEveryTurn [

	self assert: ( match cardsInHandOf: shobu ) size equals: 5.
	match drawCardFor: shobu.
	self assert: ( match cardsInHandOf: shobu ) size equals: 6.

	match
		endTurn;
		endTurn;
		drawCardFor: shobu.

	self assert: ( match cardsInHandOf: shobu ) size equals: 7
]

{ #category : #'tests - field setup' }
MatchTest >> test04PlayerNotBelongingToMatchCantHaveCardsInHand [

	| intruder |

	intruder := self intruder.

	self
		should: [ match cardsInHandOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - turn order' }
MatchTest >> test04PlayerNotBelongingToMatchDontHaveTurn [

	| intruder |

	intruder := self intruder.

	self
		should: [ match isTurnOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - mana charge' }
MatchTest >> test05PlayerNotBelongingToMatchCantChargeMana [

	| intruder immortalBaronVorg |

	intruder := self intruder.
	immortalBaronVorg := self immortalBaronVorg.

	self
		should: [ match chargeManaOf: intruder with: immortalBaronVorg ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - drawing cards' }
MatchTest >> test05PlayerNotBelongingToMatchCantDrawCard [

	| intruder |

	intruder := self intruder.

	self
		should: [ match drawCardFor: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - field setup' }
MatchTest >> test05PlayerNotBelongingToMatchCantHaveShields [

	| intruder |

	intruder := self intruder.

	self
		should: [ match shieldsOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - field setup' }
MatchTest >> test06PlayerNotBelongingToMatchCantHaveChargedMana [

	| intruder |

	intruder := self intruder.

	self
		should: [ match manaChargedBy: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]
