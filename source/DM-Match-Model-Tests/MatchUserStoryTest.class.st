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
MatchUserStoryTest >> setUpFieldHavingCreatureLessPowerfulThanOpponentCreatureAndReadyToAttackIt [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.
	self summon: tulkTheOracle of: shobu tapping: march.
	match endTurnOf: shobu.

	match
		chargeManaOf: knight with: anotherMarch;
		endTurnOf: knight;
		endTurnOf: shobu.

	match
		chargeManaOf: knight with: vocalMegahit;
		summon: immortalBaronVorg of: knight tappingAll: ( Array with: anotherMarch with: vocalMegahit );
		endTurnOf: knight;
		endTurnOf: shobu.

	match
		directAttackFrom: immortalBaronVorg of: knight;
		endTurnOf: knight
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpFieldHavingCreatureMorePowerfulThanOpponentCreatureAndReadyToAttackIt [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	match
		chargeManaOf: shobu with: march;
		endTurnOf: shobu.

	match chargeManaOf: knight with: anotherMarch.
	self summon: tulkTheOracle of: knight tapping: anotherMarch.
	match endTurnOf: knight.

	match
		chargeManaOf: shobu with: vocalMegahit;
		summon: immortalBaronVorg of: shobu tappingAll: ( Array with: march with: vocalMegahit );
		endTurnOf: shobu;
		directAttackFrom: tulkTheOracle of: knight;
		endTurnOf: knight
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpFieldHavingCreaturesWithSamePower [

	| march vorgBrawlerOfHell darknessLeohl vocalMegahit tulkTheOracle immortalBaronVorg |

	march := self march.
	vorgBrawlerOfHell := self vorgBrawlerOfHell.
	darknessLeohl := self darknessLeohl.
	vocalMegahit := self vocalMegahit.
	tulkTheOracle := self tulkTheOracle.
	immortalBaronVorg := self immortalBaronVorg.

	match
		chargeManaOf: shobu with: march;
		endTurnOf: shobu.

	match
		chargeManaOf: knight with: vocalMegahit;
		endTurnOf: knight.

	match
		chargeManaOf: shobu with: vorgBrawlerOfHell;
		summon: darknessLeohl of: shobu tappingAll: ( Array with: march with: vorgBrawlerOfHell );
		endTurnOf: shobu.

	match
		chargeManaOf: knight with: tulkTheOracle;
		summon: immortalBaronVorg of: knight tappingAll: ( Array with: vocalMegahit with: tulkTheOracle );
		endTurnOf: knight.
		
	match
		endTurnOf: shobu;
		directAttackFrom: immortalBaronVorg of: knight;
		endTurnOf: knight
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

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test01NotSummonedCreatureCantAttack [

	| errorDescription |

	errorDescription := 'Shobu: Immortal Baron, Vorg it''s not summoned.'.

	self
		should: [ match directAttackFrom: self immortalBaronVorg of: shobu ]
			raise: IllegalPlay
			withMessageText: errorDescription;
		should: [ match attackFrom: self immortalBaronVorg of: shobu to: self march ]
			raise: IllegalPlay
			withMessageText: errorDescription
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test01PlayerCantSummonCreatureWithoutTappingMana [

	| tulkTheOracle |

	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	self
		should: [ match summon: tulkTheOracle of: shobu tappingAll: #() ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You haven''t selected cards to tap.'.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty
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

	self assert: ( match numberOfCardsInHandOf: knight ) equals: 5.
	match
		endTurnOf: shobu;
		drawCardFor: knight.
	self assert: ( match numberOfCardsInHandOf: knight ) equals: 6
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test01PlayersBeginTheMatchWithFiveCardsInHand [

	self
		assert: ( match numberOfCardsInHandOf: shobu ) equals: 5;
		assert: ( match numberOfCardsInHandOf: knight ) equals: 5
]

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test01PlayersTurnOrderIsCircular [

	self assert: ( match isTurnOf: shobu ).
	match endTurnOf: shobu.
	self assert: ( match isTurnOf: knight ).
	match endTurnOf: knight.
	self assert: ( match isTurnOf: shobu )
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test02PlayerCantAttackWithCreatureNotBelongingToHim [

	| march tulkTheOracle errorDescription |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.
	self summon: tulkTheOracle of: shobu tapping: march.
	match endTurnOf: shobu.

	errorDescription := 'Knight: You can''t attack with Tulk, the Oracle because it''s not on your side of the field.'.

	self
		should: [ match directAttackFrom: tulkTheOracle of: knight ]
			raise: IllegalPlay
			withMessageText: errorDescription;
		should: [ match attackFrom: tulkTheOracle of: knight to: self immortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: errorDescription
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
		assert: ( match numberOfCardsInHandOf: knight ) equals: 5;
		should: [ match drawCardFor: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t draw a card on your opponent''s turn.';
		assert: ( match numberOfCardsInHandOf: knight ) equals: 5
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
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	self
		should: [ self summon: tulkTheOracle of: shobu tapping: march ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You can''t tap March because it isn''t in your mana zone.'.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test02PlayersBeginTheMatchWithFiveShields [

	self
		assert: ( match shieldsOf: shobu ) size equals: 5;
		assert: ( match shieldsOf: knight ) size equals: 5
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test03PlayerCantAttackWithCreatureHavingSummoningSickness [

	| march tulkTheOracle errorDescription |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.
	self summon: tulkTheOracle of: shobu tapping: march.

	errorDescription := 'Shobu: You can''t attack with Tulk, the Oracle because it has summoning sickness.'.

	self
		should: [ match directAttackFrom: tulkTheOracle of: shobu ]
			raise: IllegalPlay
			withMessageText: errorDescription;
		should: [ match attackFrom: tulkTheOracle of: shobu to: self immortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: errorDescription
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

	self assert: ( match numberOfCardsInHandOf: knight ) equals: 5.

	match
		endTurnOf: shobu;
		drawCardFor: knight.

	self
		assert: ( match numberOfCardsInHandOf: knight ) equals: 6;
		should: [ match drawCardFor: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: Only one card can be drawn per turn.';
		assert: ( match numberOfCardsInHandOf: knight ) equals: 6
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
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	self summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle.

	self
		should: [ self summon: anotherTulkTheOracle of: shobu tapping: march ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You can''t tap March because it is already tapped.'.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle
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

	self assert: ( match numberOfCardsInHandOf: shobu ) equals: 5.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		drawCardFor: shobu.

	self assert: ( match numberOfCardsInHandOf: shobu ) equals: 6.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		drawCardFor: shobu.

	self assert: ( match numberOfCardsInHandOf: shobu ) equals: 7
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test04PlayerCantAttackOnOpponentsTurn [

	| errorDescription |

	self assert: ( match isTurnOf: shobu ).

	errorDescription := 'Knight: You can''t attack on your opponent''s turn.'.

	self
		should: [ match directAttackFrom: self tulkTheOracle of: knight ]
			raise: IllegalPlay
			withMessageText: errorDescription;
		should: [ match attackFrom: self tulkTheOracle of: knight to: self immortalBaronVorg ]
			raise: IllegalPlay
			withMessageText: errorDescription
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test04PlayerCantSummonSingleCivilizationCreatureWhenAtLeastOneCardToTapIsNotFromThatSameCivilization [

	| immortalBaronVorg tulkTheOracle |

	immortalBaronVorg := self immortalBaronVorg.
	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: immortalBaronVorg.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	self
		should: [ self summon: tulkTheOracle of: shobu tapping: immortalBaronVorg ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You don''t have Light civilization mana to summon Tulk, the Oracle.'.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: immortalBaronVorg;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty
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
MatchUserStoryTest >> test04PlayersBeginTheMatchWithoutSummonedCreatures [

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: knight ) isEmpty
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test05PlayerCantSummonCreatureWhenTheManaNumberOfCardsToTapIsLessThanCreatureManaCost [

	| immortalBaronVorg vocalMegahit |

	immortalBaronVorg := self immortalBaronVorg.
	vocalMegahit := self vocalMegahit.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: vocalMegahit.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: vocalMegahit;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	self
		should: [ self summon: immortalBaronVorg of: shobu tapping: vocalMegahit ]
		raise: IllegalPlay
		withMessageText:
			'Shobu: You have to tap cards whose sum of mana number equals the mana cost of Immortal Baron, Vorg.'.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: vocalMegahit;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty
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
MatchUserStoryTest >> test05PlayersBeginTheMatchWithoutCardsInGraveyard [

	self
		assert: ( match graveyardOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test05WhenPlayerAttacksDirectlyThenAttackingCreatureIsTappedAndOneOpponentsShieldIsBrokenAndGoesToOpponentsHand [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.
	self summon: tulkTheOracle of: shobu tapping: march.
	match
		endTurnOf: shobu;
		endTurnOf: knight.

	self
		assert: ( match shieldsOf: knight ) size equals: 5;
		assert: ( match numberOfCardsInHandOf: knight ) equals: 5;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty.

	match directAttackFrom: tulkTheOracle of: shobu.

	self
		assert: ( match shieldsOf: knight ) size equals: 4;
		assert: ( match numberOfCardsInHandOf: knight ) equals: 6;
		assertTheOnlyOneIn: ( match tappedCreaturesOf: shobu ) is: tulkTheOracle
]

{ #category : #'tests - drawing cards' }
MatchUserStoryTest >> test06InitialPlayerCantDrawCardInTheFirstTurn [

	self
		assert: ( match numberOfCardsInHandOf: shobu ) equals: 5;
		should: [ match drawCardFor: shobu ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You can''t draw card in your first turn.';
		assert: ( match numberOfCardsInHandOf: shobu ) equals: 5.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		drawCardFor: shobu.

	self assert: ( match numberOfCardsInHandOf: shobu ) equals: 6
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
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	expectedMana := Array with: march with: tulkTheOracle.

	self chargeShobuManaWithAll: expectedMana.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty.

	self
		should: [ match summon: vorgBrawlerOfHell of: shobu tappingAll: expectedMana ]
		raise: IllegalPlay
		withMessageText:
			'Shobu: You don''t have Fire civilization and Darkness civilization mana to summon Vorg, Brawler of Hell.'.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test06PlayerNotBelongingToMatchCantHaveCardsInHand [

	| intruder |

	intruder := self intruder.

	self
		should: [ match handOf: intruder requestedBy: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test06TappedCreatureCantAttack [

	| errorDescription |

	self
		test05WhenPlayerAttacksDirectlyThenAttackingCreatureIsTappedAndOneOpponentsShieldIsBrokenAndGoesToOpponentsHand.

	errorDescription := 'Shobu: You can''t attack with Tulk, the Oracle because is tapped.'.

	self
		withTheOnlyOneIn: ( match tappedCreaturesOf: shobu )
		do: [ :tappedCreature | 
			self
				should: [ match directAttackFrom: tappedCreature of: shobu ]
					raise: IllegalPlay
					withMessageText: errorDescription;
				should: [ match attackFrom: tappedCreature of: shobu to: self immortalBaronVorg ]
					raise: IllegalPlay
					withMessageText: errorDescription
			]
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test07PlayerNotBelongingToMatchCantHaveShields [

	| intruder |

	intruder := self intruder.

	self
		should: [ match shieldsOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test07TappedCreatureRemainsTappedUntilTheBeginningOfItsOwnerTurn [

	| tulkTheOracle |

	self
		test05WhenPlayerAttacksDirectlyThenAttackingCreatureIsTappedAndOneOpponentsShieldIsBrokenAndGoesToOpponentsHand.

	tulkTheOracle := self theOnlyOneIn: ( match tappedCreaturesOf: shobu ).

	self assert: ( match isTurnOf: shobu ).
	match endTurnOf: shobu.
	self
		assert: ( match isTurnOf: knight );
		assertTheOnlyOneIn: ( match tappedCreaturesOf: shobu ) is: tulkTheOracle.
	match endTurnOf: knight.
	self
		assert: ( match isTurnOf: shobu );
		assert: ( match tappedCreaturesOf: shobu ) isEmpty
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test07WhenPlayerSummonsSingleCivilizationCreatureThenCardsToTapAreTapped [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		assert: ( match manaOf: shobu ) isEmpty;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty.

	match chargeManaOf: shobu with: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty.

	self summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyOneIn: ( match manaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test08PlayerNotBelongingToMatchCantHaveChargedMana [

	| intruder |

	intruder := self intruder.

	self
		should: [ match manaOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test08WhenPlayerAttacksDirectlyAndOpponentHasNoShieldsLeftThenPlayerWinsTheMatch [

	| tulkTheOracle |

	self
		test05WhenPlayerAttacksDirectlyThenAttackingCreatureIsTappedAndOneOpponentsShieldIsBrokenAndGoesToOpponentsHand.

	tulkTheOracle := self theOnlyOneIn: ( match tappedCreaturesOf: shobu ).

	( match shieldsOf: knight ) size
		timesRepeat: [ match
				endTurnOf: shobu;
				endTurnOf: knight;
				directAttackFrom: tulkTheOracle of: shobu
			].

	self
		assert: ( match shieldsOf: knight ) isEmpty;
		deny: match hasEnded;
		should: [ match winner ]
			raise: Error
			withMessageText: 'Can''t know the winner until the game has ended.'.

	match
		endTurnOf: shobu;
		endTurnOf: knight;
		directAttackFrom: tulkTheOracle of: shobu.

	self
		assert: ( match shieldsOf: knight ) isEmpty;
		assert: match hasEnded;
		assert: match winner equals: shobu
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
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty.

	expectedMana := Array with: immortalBaronVorg with: darknessLeohl.

	self chargeShobuManaWithAll: expectedMana.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assert: ( match tappedManaOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty.

	match summon: vorgBrawlerOfHell of: shobu tappingAll: expectedMana.

	self
		assertCollection: ( match manaOf: shobu ) hasSameElements: expectedMana;
		assertCollection: ( match tappedManaOf: shobu ) hasSameElements: expectedMana;
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: vorgBrawlerOfHell;
		assert: ( match tappedCreaturesOf: shobu ) isEmpty
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test09PlayerCantAttackOpponentCreatureNotBelongingToOpponent [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.
	self summon: tulkTheOracle of: shobu tapping: march.
	match
		endTurnOf: shobu;
		endTurnOf: knight.

	self
		should: [ match attackFrom: tulkTheOracle of: shobu to: self immortalBaronVorg ]
		raise: IllegalPlay
		withMessageText: 'Shobu: Immortal Baron, Vorg it''s not summoned.'
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test09PlayerCantSeeOpponentCardsInHand [

	self
		should: [ match handOf: shobu requestedBy: knight ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t see the cards in your opponent''s hand.'
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

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test10CreaturesHaveSummoningSicknessOnTheTurnTheyAreSummoned [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: match creaturesHavingSummonedSickness isEmpty.

	self summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: match creaturesHavingSummonedSickness is: tulkTheOracle
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test10PlayerCantAttackOpponentCreatureWhenIsUntapped [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	match
		chargeManaOf: shobu with: march;
		endTurnOf: shobu.

	match chargeManaOf: knight with: anotherMarch.
	self summon: tulkTheOracle of: knight tapping: anotherMarch.
	match endTurnOf: knight.

	match
		chargeManaOf: shobu with: vocalMegahit;
		summon: immortalBaronVorg of: shobu tappingAll: ( Array with: march with: vocalMegahit );
		endTurnOf: shobu.

	self
		should: [ match attackFrom: tulkTheOracle of: knight to: immortalBaronVorg ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t attack Immortal Baron, Vorg because it''s untapped.'
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test11PlayerCantAttackCreatureBelongingToHim [

	| march tulkTheOracle anotherTulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.
	self summon: tulkTheOracle of: shobu tapping: march.
	match
		endTurnOf: shobu;
		endTurnOf: knight.
	self summon: anotherTulkTheOracle of: shobu tapping: march.

	self
		should: [ match attackFrom: tulkTheOracle of: shobu to: anotherTulkTheOracle ]
		raise: IllegalPlay
		withMessageText: 'Shobu: You can''t attack Tulk, the Oracle because it''s on your side of the field.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test11SummoningSicknessEndsWhenPlayerEndsTurn [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaOf: shobu with: march.

	self summon: tulkTheOracle of: shobu tapping: march.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: match creaturesHavingSummonedSickness is: tulkTheOracle.

	match endTurnOf: shobu.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assert: match creaturesHavingSummonedSickness isEmpty
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test12CreatureDestroysAnotherCreatureInBattleWhenItHasTheGreatestPower [

	| immortalBaronVorg tulkTheOracle |

	self setUpFieldHavingCreatureMorePowerfulThanOpponentCreatureAndReadyToAttackIt.
	
	immortalBaronVorg := self theOnlyOneIn: (match summonedCreaturesOf: shobu).
	tulkTheOracle := self theOnlyOneIn: (match summonedCreaturesOf: knight).

	self
		assert: ( match tappedCreaturesOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty.

	match attackFrom: immortalBaronVorg of: shobu to: tulkTheOracle.

	self
		assertTheOnlyOneIn: ( match tappedCreaturesOf: shobu ) is: immortalBaronVorg;
		assert: ( match summonedCreaturesOf: knight ) isEmpty;
		assertTheOnlyOneIn: ( match graveyardOf: knight ) is: tulkTheOracle
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test12PlayerCantSummonCreatureOnOpponentsTurn [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match
		chargeManaOf: shobu with: march;
		endTurnOf: shobu.

	self
		assert: ( match isTurnOf: knight );
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		should: [ self summon: tulkTheOracle of: shobu tapping: march ]
			raise: IllegalPlay
			withMessageText: 'Shobu: You can''t summon creatures on your opponent''s turn.';
		assert: ( match isTurnOf: knight );
		assert: ( match summonedCreaturesOf: shobu ) isEmpty
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test13CreatureIsDestroyedInBattleByAnotherCreatureWhenItHasLessPower [

	| tulkTheOracle immortalBaronVorg |

	self setUpFieldHavingCreatureLessPowerfulThanOpponentCreatureAndReadyToAttackIt.

	tulkTheOracle := self theOnlyOneIn: ( match summonedCreaturesOf: shobu ).
	immortalBaronVorg := self theOnlyOneIn: ( match summonedCreaturesOf: knight ).

	self
		assert: ( match tappedCreaturesOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty.

	match attackFrom: tulkTheOracle of: shobu to: immortalBaronVorg.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assertTheOnlyOneIn: ( match graveyardOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: ( match summonedCreaturesOf: knight ) is: immortalBaronVorg
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test14BothCreaturesAreDestroyedInBattleWhenTheyHaveTheSamePower [

	| darknessLeohl immortalBaronVorg |

	self setUpFieldHavingCreaturesWithSamePower.

	darknessLeohl := self theOnlyOneIn: ( match summonedCreaturesOf: shobu ).
	immortalBaronVorg := self theOnlyOneIn: ( match summonedCreaturesOf: knight ).

	self
		assert: ( match tappedCreaturesOf: shobu ) isEmpty;
		assert: ( match graveyardOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty.

	match attackFrom: darknessLeohl of: shobu to: immortalBaronVorg.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: knight ) isEmpty;
		assertTheOnlyOneIn: ( match graveyardOf: shobu ) is: darknessLeohl;
		assertTheOnlyOneIn: ( match graveyardOf: knight ) is: immortalBaronVorg
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
