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
		'power',
		'cards'
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

	aCardCollection do: [ :aCard | 
		match
			chargeManaWith: aCard;
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
		costing: ( DMUnits mana with: 2 )
		providing: self oneMana
		with: ( DMUnits power with: 2000 )
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
		costing: ( DMUnits mana with: 2 )
		providing: self oneMana
		with: ( DMUnits power with: 2000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> intruder [

	^ 'Intruder'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> knightDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> lightBringer [

	^ SingleRace ofTypeNamed: 'Light Bringer'
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> march [

	^ CreatureCard
		named: 'March'
		from: self civilizationManagementSystem lightCivilization
		ofType: self calendar2016
		costing: ( DMUnits mana with: 3 )
		providing: self oneMana
		with: ( DMUnits power with: 3000 )
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> oneMana [

	^ DMUnits mana with: 1
]

{ #category : #running }
MatchUserStoryTest >> setUp [

	super setUp.

	shobu := Duelist named: 'Shobu' using: self shobuDeck.
	knight := Duelist named: 'Knight' using: self knightDeck.
	match := Match between: shobu and: knight.

	self startManagingCivilizations
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpFieldHavingCreatureLessPowerfulThanOpponentCreatureAndReadyToAttackIt [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaWith: march.
	self summon: tulkTheOracle tapping: march.
	match endTurnOf: shobu.

	match
		chargeManaWith: anotherMarch;
		endTurnOf: knight;
		endTurnOf: shobu.

	match
		chargeManaWith: vocalMegahit;
		summon: immortalBaronVorg tappingAll: ( Array with: anotherMarch with: vocalMegahit );
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
		chargeManaWith: march;
		endTurnOf: shobu.

	match chargeManaWith: anotherMarch.
	self summon: tulkTheOracle tapping: anotherMarch.
	match endTurnOf: knight.

	match
		chargeManaWith: vocalMegahit;
		summon: immortalBaronVorg tappingAll: ( Array with: march with: vocalMegahit );
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
		chargeManaWith: march;
		endTurnOf: shobu.

	match
		chargeManaWith: vocalMegahit;
		endTurnOf: knight.

	match
		chargeManaWith: vorgBrawlerOfHell;
		summon: darknessLeohl tappingAll: ( Array with: march with: vorgBrawlerOfHell );
		endTurnOf: shobu.

	match
		chargeManaWith: tulkTheOracle;
		summon: immortalBaronVorg tappingAll: ( Array with: vocalMegahit with: tulkTheOracle );
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

{ #category : #'private - accessing' }
MatchUserStoryTest >> shobuDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
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
MatchUserStoryTest >> summon: aCreatureCard tapping: aCard [

	match summon: aCreatureCard tappingAll: { aCard }
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

{ #category : #'tests - winning conditions' }
MatchUserStoryTest >> test01WhenPlayerDrawsHisLastCardThenLosesTheMatch [

	match
		endTurnOf: shobu;
		endTurnOf: knight.

	shobu numberOfCardsInDeck - 1 timesRepeat: [ 
		match
			drawCard;
			endTurnOf: shobu;
			endTurnOf: knight
		].

	self
		assert: shobu numberOfCardsInDeck equals: 1;
		deny: match hasEnded.

	match drawCard.

	self
		assert: shobu numberOfCardsInDeck isNothing;
		assert: match hasEnded;
		assert: match winner equals: knight
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test02PlayerCantAttackWithCreatureNotBelongingToHim [

	| march tulkTheOracle errorDescription |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaWith: march.
	self summon: tulkTheOracle tapping: march.
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

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test02PlayerCantEndOpponentsTurn [

	self
		assert: ( match isTurnOf: shobu );
		should: [ match endTurnOf: knight ]
			raise: IllegalPlay
			withMessageText: 'Knight: You can''t end your opponent''s turn.';
		assert: ( match isTurnOf: shobu )
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

	match chargeManaWith: march.
	self summon: tulkTheOracle tapping: march.

	errorDescription := 'Shobu: You can''t attack with Tulk, the Oracle because it has summoning sickness.'.

	self
		should: [ match directAttackFrom: tulkTheOracle of: shobu ]
		raise: IllegalPlay
		withMessageText: errorDescription;
		should: [ match attackFrom: tulkTheOracle of: shobu to: self immortalBaronVorg ]
		raise: IllegalPlay
		withMessageText: errorDescription
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

	match chargeManaWith: march.
	self summon: tulkTheOracle tapping: march.
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

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test09PlayerCantAttackOpponentCreatureNotBelongingToOpponent [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaWith: march.
	self summon: tulkTheOracle tapping: march.
	match
		endTurnOf: shobu;
		endTurnOf: knight.

	self should: [ match attackFrom: tulkTheOracle of: shobu to: self immortalBaronVorg ]
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

	match chargeManaWith: march.

	self
		summon: tulkTheOracle tapping: march;
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

	match chargeManaWith: march.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: match creaturesHavingSummoningSickness isEmpty.

	self summon: tulkTheOracle tapping: march.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: match creaturesHavingSummoningSickness is: tulkTheOracle
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
		chargeManaWith: march;
		endTurnOf: shobu.

	match chargeManaWith: anotherMarch.
	self summon: tulkTheOracle tapping: anotherMarch.
	match endTurnOf: knight.

	match
		chargeManaWith: vocalMegahit;
		summon: immortalBaronVorg tappingAll: ( Array with: march with: vocalMegahit );
		endTurnOf: shobu.

	self should: [ match attackFrom: tulkTheOracle of: knight to: immortalBaronVorg ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t attack Immortal Baron, Vorg because it''s untapped.'
]

{ #category : #'tests - attacking' }
MatchUserStoryTest >> test11PlayerCantAttackCreatureBelongingToHim [

	| march tulkTheOracle anotherTulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.

	match chargeManaWith: march.
	self summon: tulkTheOracle tapping: march.
	match
		endTurnOf: shobu;
		endTurnOf: knight.
	self summon: anotherTulkTheOracle tapping: march.

	self should: [ match attackFrom: tulkTheOracle of: shobu to: anotherTulkTheOracle ]
		raise: IllegalPlay
		withMessageText:
		'Shobu: You can''t attack Tulk, the Oracle because it''s on your side of the field.'
]

{ #category : #'tests - summoning creatures' }
MatchUserStoryTest >> test11SummoningSicknessEndsWhenPlayerEndsTurn [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	match chargeManaWith: march.

	self summon: tulkTheOracle tapping: march.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: match creaturesHavingSummoningSickness is: tulkTheOracle.

	match endTurnOf: shobu.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assert: match creaturesHavingSummoningSickness isEmpty
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
		with: ( DMUnits power with: 500 )
]

{ #category : #'private - creature accessing' }
MatchUserStoryTest >> vocalMegahit [

	^ CreatureCard
		named: 'Vocal Megahit'
		from: self civilizationManagementSystem fireCivilization
		ofType: self beatJockey
		costing: ( DMUnits mana with: 5 )
		providing: self oneMana
		with: ( DMUnits power with: 5000 )
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
		costing: ( DMUnits mana with: 2 )
		providing: self oneMana
		with: ( DMUnits power with: 4000 )
]
