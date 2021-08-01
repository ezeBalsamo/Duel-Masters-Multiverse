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

{ #category : #'private - accessing' }
MatchUserStoryTest >> alien [

	^ SingleRace ofTypeNamed: 'Alien'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> beatJockey [

	^ SingleRace ofTypeNamed: 'Beat Jockey'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> calendar2016 [

	^ SingleRace ofTypeNamed: '2016 Calendar'
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

{ #category : #'private - system accessing' }
MatchUserStoryTest >> civilizationManagementSystem [

	^ rootSystem >> #CivilizationManagementSystemInterface
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> darkMonster [

	^ SingleRace ofTypeNamed: 'Dark Monster'
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> darknessLeohl [

	^ CreatureCard
		named: 'Darkness Leohl'
		from: self civilizationManagementSystem darknessCivilization
		ofType: self darkMonster
		costing: ( self mana with: 2 )
		providing: self oneMana
		with: ( self power with: 2000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> human [

	^ SingleRace ofTypeNamed: 'Human'
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> immortalBaronVorg [

	^ CreatureCard
		named: 'Immortal Baron, Vorg'
		from: self civilizationManagementSystem fireCivilization
		ofType: self human
		costing: ( self mana with: 2 )
		providing: self oneMana
		with: ( self power with: 2000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> intruder [

	^ 'Intruder'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> lightBringer [

	^ SingleRace ofTypeNamed: 'Light Bringer'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> mana [

	^ mana
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> march [

	^ CreatureCard
		named: 'March'
		from: self civilizationManagementSystem lightCivilization
		ofType: self calendar2016
		costing: ( self mana with: 3 )
		providing: self oneMana
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
		storeCivilization: ( Civilization named: 'Fire' );
		storeCivilization: ( Civilization named: 'Water' );
		storeCivilization: ( Civilization named: 'Nature' );
		storeCivilization: ( Civilization named: 'Light' );
		storeCivilization: ( Civilization named: 'Darkness' )
]

{ #category : #'private - processing' }
MatchUserStoryTest >> summon: aCreatureCard of: aPotentialPlayer tapping: aCard [

	match summon: aCreatureCard of: aPotentialPlayer tappingAll: {aCard}
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test01PlayerCantSummonCreatureWithoutTappingMana [

	| tulkTheOracle |

	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self
		should: [ match summon: tulkTheOracle of: shobu tappingAll: #() ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You haven''t selected cards to tap.'.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test01PlayerChargesMana [

	| immortalBaronVorg |

	immortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaOf: shobu ) isEmpty.
	match chargeManaOf: shobu with: immortalBaronVorg.
	self assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg
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
MatchUserStoryTest >> test02PlayerCantSummonCreatureWhenAtLeastOneCardToTapDoesNotBelongToPlayerMana [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self
		should: [ self summon: tulkTheOracle of: shobu tapping: march ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You can''t tap March because it isn''t in your mana zone.'.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty
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
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		should: [ match chargeManaOf: shobu with: anotherImmortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: 'Shobu: Mana can only be charged once per turn.';
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg
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
MatchUserStoryTest >> test03PlayerCantSummonCreatureWhenAtLeastOneCardToTapIsAlreadyTapped [

	| march tulkTheOracle anotherTulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle.

	self
		should: [ self summon: anotherTulkTheOracle of: shobu tapping: march ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You can''t tap March because it is already tapped.'.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle
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
		assert: ( match manaOf: knight ) isEmpty
]

{ #category : #'tests - mana charge' }
MatchUserStoryTest >> test04PlayerCanChargeManaEveryTurn [

	| immortalBaronVorg anotherImmortalBaronVorg expectedChargedMana |

	immortalBaronVorg := self immortalBaronVorg.
	anotherImmortalBaronVorg := self immortalBaronVorg.
	self assert: ( match manaOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: immortalBaronVorg.
	self assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg.

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

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test04PlayerCantSummonSingleCivilizationCreatureWhenAtLeastOneCardToTapIsNotFromThatSameCivilization [

	| immortalBaronVorg tulkTheOracle |

	immortalBaronVorg := self immortalBaronVorg.
	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: immortalBaronVorg.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self
		should: [ self summon: tulkTheOracle of: shobu tapping: immortalBaronVorg ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You don''t have Light civilization mana to summon Tulk, the Oracle.'.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty
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

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test04layersBeginTheMatchWithoutSummonedCreatures [

	self
		assert: ( match creaturesSummonedOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: knight ) isEmpty
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test05PlayerCantSummonCreatureWhenTheManaNumberOfCardsToTapIsLessThanCreatureManaCost [

	| immortalBaronVorg vocalMegahit |

	immortalBaronVorg := self immortalBaronVorg.
	vocalMegahit := self vocalMegahit.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: vocalMegahit.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: vocalMegahit;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self
		should: [ self summon: immortalBaronVorg of: shobu tapping: vocalMegahit ]
		raise: IllegalPlay
		withMessageText:
			'Shobu: You have to tap cards whose sum of mana number equals the mana cost of Immortal Baron, Vorg.'.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: vocalMegahit;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty
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

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test06PlayerCantSummonMultipleCivilizationCreatureWhenNoneCardsToTapAreFromTheRequiredCivilization [

	| march tulkTheOracle vorgBrawlerOfHell expectedMana |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	vorgBrawlerOfHell := self vorgBrawlerOfHell.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	expectedMana := Array with: march with: tulkTheOracle.

	self chargeShobuManaWithAll: expectedMana.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self
		should: [ match summon: vorgBrawlerOfHell of: shobu tappingAll: expectedMana ]
		raise: IllegalPlay
		withMessageText:
			'Shobu: You don''t have Fire civilization and Darkness civilization mana to summon Vorg, Brawler of Hell.'.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty
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
MatchUserStoryTest >> test07WhenPlayerSummonsSingleCivilizationCreatureThenCardsToTapAreTapped [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	self summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match creaturesSummonedOf: shobu ) is: tulkTheOracle
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test08PlayerCantSeeOpponentCardsInHand [

	self
		should: [ match cardsInHandOf: shobu requestedBy: knight ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t see the cards in your opponent''s hand.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test08WhenPlayerSummonsMultipleCivilizationCreatureThenCardsToTapAreTapped [

	| immortalBaronVorg darknessLeohl vorgBrawlerOfHell expectedMana |

	immortalBaronVorg := self immortalBaronVorg.
	darknessLeohl := self darknessLeohl.
	vorgBrawlerOfHell := self vorgBrawlerOfHell.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	expectedMana := Array with: immortalBaronVorg with: darknessLeohl.

	self chargeShobuManaWithAll: expectedMana.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match creaturesSummonedOf: shobu ) isEmpty.

	match summon: vorgBrawlerOfHell of: shobu tappingAll: expectedMana.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assertCollection: ( match tappedManaOf: shobu ) hasSameElements: expectedMana;
		assertTheOnlyOneIn: ( match creaturesSummonedOf: shobu ) is: vorgBrawlerOfHell
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test09TappedManaIsUntappedAtTheBeginningOfThePlayerTurn [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self assert: ( match tappedManaOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: march.

	self
		summon: tulkTheOracle of: shobu tapping: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march.

	match endTurnOf: shobu.

	self assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march.

	match endTurnOf: knight.

	self assert: ( match tappedManaOf: shobu ) isEmpty
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> tulkTheOracle [

	^ CreatureCard
		named: 'Tulk, the Oracle'
		from: self civilizationManagementSystem lightCivilization
		ofType: self lightBringer
		costing: self oneMana
		providing: self oneMana
		with: ( self power with: 500 )
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> vocalMegahit [

	^ CreatureCard
		named: 'Vocal Megahit'
		from: self civilizationManagementSystem fireCivilization
		ofType: self beatJockey
		costing: ( self mana with: 5 )
		providing: self oneMana
		with: ( self power with: 5000 )
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> vorgBrawlerOfHell [

	^ CreatureCard
		named: 'Vorg, Brawler of Hell'
		fromAll:
			( Array
				with: self civilizationManagementSystem fireCivilization
				with: self civilizationManagementSystem darknessCivilization )
		ofType: ( MultipleRace conformedByAll: ( Array with: self human with: self beatJockey with: self alien ) )
		costing: ( self mana with: 2 )
		providing: self oneMana
		with: ( self power with: 4000 )
]
