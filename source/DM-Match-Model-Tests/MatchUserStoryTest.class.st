"
A MatchTest is a test class for testing the behavior of Match
"
Class {
	#name : #MatchUserStoryTest,
	#superclass : #PersistentSystemBasedUserStoryTest,
	#instVars : [
		'shobu',
		'knight',
		'match',
		'mana',
		'power'
	],
	#category : #'DM-Match-Model-Tests'
}

{ #category : #'private - asserting' }
MatchUserStoryTest >> assertTheOnlyElementIn: aCollection is: anExpectedObject [

	self
		withTheOnlyOneIn: aCollection
		do: [ :anObject | self assert: anObject equals: anExpectedObject ]
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> beatJockey [

	^ SingleRace ofTypeNamed: self beatJockeyName
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> beatJockeyName [

	^ 'Beat Jockey'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> calendar2016 [

	^ SingleRace ofTypeNamed: self calendar2016Name
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> calendar2016Name [

	^ '2016 Calendar'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> cardsInHandOf: aPlayer [

	^ match cardsInHandOf: aPlayer requestedBy: aPlayer
]

{ #category : #'private - processing' }
MatchUserStoryTest >> chargeShobuManaWithAll: aCardCollection [

	aCardCollection
		do: [ :aCard | 
			match
				chargeManaOf: shobu with: aCard;
				endTurnOf: shobu;
				endTurnOf: knight
			]
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> fireCivilization [

	^ ( rootSystem >> #CivilizationManagementSystemInterface ) fireCivilization
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> humanRace [

	^ SingleRace ofTypeNamed: self humanRaceTypeName
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> humanRaceTypeName [

	^ 'Human'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> immortalBaronVorg [

	^ CreatureCard
		named: 'Immortal Baron, Vorg'
		from: self fireCivilization
		and: self humanRace
		costing: ( self mana with: 2 )
		providing: ( self mana with: 1 )
		with: ( self power with: 2000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> intruder [

	^ 'Intruder'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> lightBringerRace [

	^ SingleRace ofTypeNamed: self lightBringerRaceName
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> lightBringerRaceName [

	^ 'Light Bringer'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> lightCivilization [

	^ ( rootSystem >> #CivilizationManagementSystemInterface ) lightCivilization
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> mana [

	^ mana
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> march [

	^ CreatureCard
		named: 'March'
		from: self lightCivilization
		and: self calendar2016
		costing: ( self mana with: 3 )
		providing: ( self mana with: 1 )
		with: ( self power with: 3000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> oneMana [

	^ self mana with: 1
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> power [

	^ power
]

{ #category : #running }
MatchUserStoryTest >> setUp [

	super setUp.

	shobu := 'Shobu'.
	knight := 'Knight'.
	match := Match between: shobu and: knight.

	self
		setUpUnits;
		startManagingCivilizations
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpRequirements [

	super setUpRequirements.
	self registerSubsystem: CivilizationManagementSystem new
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpUnits [

	mana := BaseUnit named: 'mana'.
	power := BaseUnit named: 'power'
]

{ #category : #'private - running' }
MatchUserStoryTest >> startManagingCivilizations [

	( rootSystem >> #CivilizationManagementSystemInterface )
		storeCivilization: ( SingleCivilization named: 'Fire' );
		storeCivilization: ( SingleCivilization named: 'Light' )
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test01PlayerCantSummonCreatureWithoutChargedMana [

	| tulkTheOracle |

	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match numberOfManaOf: shobu ) equals: self zeroMana;
		assert: ( tulkTheOracle costs: self oneMana );
		deny: ( match canBeSummoned: tulkTheOracle of: shobu );
		should: [ match summon: tulkTheOracle of: shobu tappingAll: #() ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You don''t have enough mana to summon Tulk, the Oracle.'
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test01PlayerChargesMana [

	| immortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaOf: shobu ) isEmpty.
	match chargeManaOf: shobu with: immortalBaronVorg.
	self
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		assert: ( match numberOfManaOf: shobu ) equals: self oneMana
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test01PlayerDrawsCard [

	self assert: ( self cardsInHandOf: knight ) size equals: 5.
	match
		endTurnOf: shobu;
		drawCardFor: knight.
	self assert: ( self cardsInHandOf: knight ) size equals: 6
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test01PlayersBeginTheMatchWithFiveCardsInHand [

	self
		assert: ( self cardsInHandOf: shobu ) size equals: 5;
		assert: ( self cardsInHandOf: knight ) size equals: 5
]

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test01PlayersTurnOrderIsCircular [

	self assert: ( match isTurnOf: shobu ).
	match endTurnOf: shobu.
	self assert: ( match isTurnOf: knight ).
	match endTurnOf: knight.
	self assert: ( match isTurnOf: shobu )
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test02PlayerCantChargeManaOnOpponentsTurn [

	| immortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	self
		assert: ( match isTurnOf: shobu );
		assert: ( match manaOf: knight ) isEmpty;
		should: [ match chargeManaOf: knight with: immortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t charge mana on your opponent''s turn.';
		assert: ( match manaOf: knight ) isEmpty
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test02PlayerCantDrawCardOnOpponentsTurn [

	self
		assert: ( match isTurnOf: shobu );
		assert: ( self cardsInHandOf: knight ) size equals: 5;
		should: [ match drawCardFor: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t draw a card on your opponent''s turn.';
		assert: ( self cardsInHandOf: knight ) size equals: 5
]

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test02PlayerCantEndOpponentsTurn [

	self
		assert: ( match isTurnOf: shobu );
		should: [ match endTurnOf: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t end your opponent''s turn.';
		assert: ( match isTurnOf: shobu )
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test02PlayerCantSummonCreatureWhenChargedManaIsNotFromTheSameCivilization [

	| immortalBaronVorg tulkTheOracle |

	immortalBaronVorg := self immortalBaronVorg.
	tulkTheOracle := self tulkTheOracle.

	self assert: ( match manaOf: shobu ) isEmpty.
	match chargeManaOf: shobu with: immortalBaronVorg.

	self
		assert: ( match numberOfManaOf: shobu ) equals: self oneMana;
		assert: ( tulkTheOracle costs: self oneMana );
		deny: ( match canBeSummoned: tulkTheOracle of: shobu );
		should: [ match summon: tulkTheOracle of: shobu tapping: immortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You don''t have mana from Light civilization to summon Tulk, the Oracle.'
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test02PlayersBeginTheMatchWithFiveShields [

	self
		assert: ( match shieldsOf: shobu ) size equals: 5;
		assert: ( match shieldsOf: knight ) size equals: 5
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test03PlayerCantChargeManaMoreThanOnceInTheSameTurn [

	| immortalBaronVorg anotherImmortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	anotherImmortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaOf: shobu ) isEmpty.
	match chargeManaOf: shobu with: immortalBaronVorg.
	self
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		should: [ match chargeManaOf: shobu with: anotherImmortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: 'Shobu: Mana can only be charged once per turn.';
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: immortalBaronVorg
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test03PlayerCantDrawMoreThanOneCardInTheSameTurn [

	self assert: ( self cardsInHandOf: knight ) size equals: 5.

	match
		endTurnOf: shobu;
		drawCardFor: knight.

	self
		assert: ( self cardsInHandOf: knight ) size equals: 6;
		should: [ match drawCardFor: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: Only one card can be drawn per turn.';
		assert: ( self cardsInHandOf: knight ) size equals: 6
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test03PlayerCantSummonCreatureWhenTheChargedManaIsNotEnoughEvenThoughIsFromTheSameCivilization [

	| immortalBaronVorg vocalMegahit |

	immortalBaronVorg := self immortalBaronVorg.
	vocalMegahit := self vocalMegahit.

	self assert: ( match manaOf: shobu ) isEmpty.
	match chargeManaOf: shobu with: vocalMegahit.

	self
		assert: ( match numberOfManaOf: shobu ) equals: self oneMana;
		assert: ( immortalBaronVorg costs: self twoManas );
		deny: ( match canBeSummoned: immortalBaronVorg of: shobu );
		should: [ match summon: immortalBaronVorg of: shobu tapping: vocalMegahit ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You don''t have enough mana to summon Immortal Baron, Vorg.'
]

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test03PlayerNotBelongingToMatchCantEndOpponentsTurn [

	| intruder |

	intruder := self intruder.

	self
		should: [ match endTurnOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test03PlayersBeginTheMatchWithoutChargedMana [

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match numberOfManaOf: shobu ) equals: self zeroMana;
		assert: ( match manaOf: knight ) isEmpty;
		assert: ( match numberOfManaOf: knight ) equals: self zeroMana
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test04PlayerCanChargeManaEveryTurn [

	| immortalBaronVorg anotherImmortalBaronVorg expectedChargedMana |

	immortalBaronVorg := self immortalBaronVorg.
	anotherImmortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: immortalBaronVorg.
	self assertTheOnlyElementIn: ( match manaOf: shobu ) is: immortalBaronVorg.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		chargeManaOf: shobu with: anotherImmortalBaronVorg.

	expectedChargedMana := Array with: immortalBaronVorg with: anotherImmortalBaronVorg.
	self assertCollection: ( match manaOf: shobu ) hasSameElements: expectedChargedMana
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test04PlayerCanDrawCardEveryTurn [

	self assert: ( self cardsInHandOf: shobu ) size equals: 5.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		drawCardFor: shobu.

	self assert: ( self cardsInHandOf: shobu ) size equals: 6.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		drawCardFor: shobu.

	self assert: ( self cardsInHandOf: shobu ) size equals: 7
]

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test04PlayerNotBelongingToMatchDontHaveTurn [

	| intruder |

	intruder := self intruder.

	self
		should: [ match isTurnOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test04PlayerSummonCreatureWithUnitaryManaCostAndOneManaChargedFromTheRequiredCivilization [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self assert: ( match manaOf: shobu ) isEmpty.
	match chargeManaOf: shobu with: march.

	self
		assert: ( match canBeSummoned: tulkTheOracle of: shobu );
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match summon: tulkTheOracle of: shobu tapping: march.
	self assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test04layersBeginTheMatchWithoutSummonedCreatures [

	self
		assert: ( match creaturesSummonedOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: knight ) isEmpty
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test05PlayerNotBelongingToMatchCantChargeMana [

	| intruder immortalBaronVorg |

	intruder := self intruder.
	immortalBaronVorg := self immortalBaronVorg.

	self
		should: [ match chargeManaOf: intruder with: immortalBaronVorg ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test05PlayerNotBelongingToMatchCantDrawCard [

	| intruder |

	intruder := self intruder.

	self
		should: [ match drawCardFor: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test05PlayerNotBelongingToMatchCantHaveCardsInHand [

	| intruder |

	intruder := self intruder.

	self
		should: [ self cardsInHandOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test05PlayerSummonCreatureWithUnitaryManaCostAndManyManaChargedFromDifferentCivilizations [

	| tulkTheOracle march expectedManaChargedCivilizations |

	tulkTheOracle := self tulkTheOracle.
	march := self march.

	self assert: ( match manaOf: shobu ) isEmpty.
	self chargeShobuManaWithAll: ( Array with: march with: self vocalMegahit ).

	expectedManaChargedCivilizations := Array with: self fireCivilization with: self lightCivilization.

	self
		assertCollection: ( match civilizationsOfManaOf: shobu )
			hasSameElements: expectedManaChargedCivilizations;
		assert: ( match canBeSummoned: tulkTheOracle of: shobu );
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match summon: tulkTheOracle of: shobu tapping: march.
	self assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test06InitialPlayerCantDrawCardInTheFirstTurn [

	self
		assert: ( self cardsInHandOf: shobu ) size equals: 5;
		should: [ match drawCardFor: shobu ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You can''t draw card in your first turn.';
		assert: ( self cardsInHandOf: shobu ) size equals: 5.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		drawCardFor: shobu.

	self assert: ( self cardsInHandOf: shobu ) size equals: 6
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test06PlayerNotBelongingToMatchCantHaveShields [

	| intruder |

	intruder := self intruder.

	self
		should: [ match shieldsOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test06PlayerSummonCreatureWithManyManaCostAndManyManaChargedFromDifferentCivilizations [

	| immortalBaronVorg expectedMana expectedManaChargedCivilizations |

	immortalBaronVorg := self immortalBaronVorg.
	expectedMana := Array with: self march with: self vocalMegahit.

	self assert: ( match manaOf: shobu ) isEmpty.
	self chargeShobuManaWithAll: expectedMana.

	expectedManaChargedCivilizations := Array with: self fireCivilization with: self lightCivilization.

	self
		assertCollection: ( match civilizationsOfManaOf: shobu )
			hasSameElements: expectedManaChargedCivilizations;
		assert: ( match canBeSummoned: immortalBaronVorg of: shobu );
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match summon: immortalBaronVorg of: shobu tappingAll: expectedMana.
	self assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: immortalBaronVorg
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test07PlayerNotBelongingToMatchCantHaveChargedMana [

	| intruder |

	intruder := self intruder.

	self
		should: [ match manaOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test07WhenPlayerSummonsCreatureWithUnitaryManaCostThenRequiredChargedManaIsTapped [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: march.

	self
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: march;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match canBeSummoned: tulkTheOracle of: shobu ).

	self assert: ( match creaturesSummonedOf: shobu ) isEmpty.
	match summon: tulkTheOracle of: shobu tapping: march.
	self
		assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle;
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyElementIn: ( match tappedManaOf: shobu ) is: march
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test08PlayerNotBelongingToMatchCantHaveNumberOfChargedMana [

	| intruder |

	intruder := self intruder.

	self
		should: [ match numberOfManaOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test08WhenPlayerSummonsCreatureWithManyManaCostThenRequiredChargedManaIsTapped [

	| vocalMegahit immortalBaronVorg tulkTheOracle expectedMana |

	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	tulkTheOracle := self tulkTheOracle.

	expectedMana := Array with: vocalMegahit with: tulkTheOracle.

	self chargeShobuManaWithAll: expectedMana.

	self
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match canBeSummoned: immortalBaronVorg of: shobu );
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match summon: immortalBaronVorg of: shobu tappingAll: expectedMana.

	self
		assertCollection: ( match tappedManaOf: shobu ) hasSameElements: expectedMana;
		assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: immortalBaronVorg
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test09PlayerCantSeeOpponentCardsInHand [

	self
		should: [ match cardsInHandOf: shobu requestedBy: knight ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t see the cards in your opponent''s hand.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test09PlayerCantSummonCreatureWhenTheRequiredManaHasNotBeenChargedAlthoughItHasEnoughManaFromTheCreatureCivilization [

	| march tulkTheOracle anotherTulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: anotherTulkTheOracle.

	self
		assert: ( match canBeSummoned: tulkTheOracle of: shobu );
		should: [ match summon: tulkTheOracle of: shobu tapping: march ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You can''t tap March because it isn''t in your mana zone.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test10PlayerCantSummonCreatureWithUnitaryManaCostAndOneManaChargedWhenTheLatterIsTapped [

	| march tulkTheOracle anotherTulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty;
		deny: ( match canBeSummoned: tulkTheOracle of: shobu ).

	match chargeManaOf: shobu with: march.

	self
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: march;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match canBeSummoned: tulkTheOracle of: shobu ).

	match summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyElementIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyElementIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle;
		deny: ( match canBeSummoned: anotherTulkTheOracle of: shobu );
		should: [ match summon: anotherTulkTheOracle of: shobu tapping: march ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You can''t tap March because it is already tapped.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test11PlayerCantSummonCreatureWithUnitaryManaCostAndManyManaChargedFromDifferentCivilizationButTheRequiredCivilizationIsTapped [

	| march tulkTheOracle anotherTulkTheOracle immortalBaronVorg |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.
	immortalBaronVorg := self immortalBaronVorg.

	self chargeShobuManaWithAll: ( Array with: march with: immortalBaronVorg ).

	self
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty;
		assert: ( match canBeSummoned: tulkTheOracle of: shobu );
		assert: ( match canBeSummoned: anotherTulkTheOracle of: shobu ).

	match summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyElementIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyElementIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle;
		deny: ( match canBeSummoned: anotherTulkTheOracle of: shobu )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> tulkTheOracle [

	^ CreatureCard
		named: 'Tulk, the Oracle'
		from: self lightCivilization
		and: self lightBringerRace
		costing: self oneMana
		providing: self oneMana
		with: ( self power with: 500 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> twoManas [

	^ self mana with: 2
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> vocalMegahit [

	^ CreatureCard
		named: 'Vocal Megahit'
		from: self fireCivilization
		and: self beatJockey
		costing: ( self mana with: 5 )
		providing: ( self mana with: 1 )
		with: ( self power with: 5000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> zeroMana [

	^ self mana nullMeasure
]
