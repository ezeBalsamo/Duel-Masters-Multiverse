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

{ #category : #'private - test support' }
MatchUserStoryTest >> attack: anOpponentCreatureCard with: aCreatureCard [

	match execute: ( AttackCreatureRequest attacking: anOpponentCreatureCard with: aCreatureCard )
		requestedBy: self turnPlayer
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> beatJockey [

	^ SingleRace ofTypeNamed: 'Beat Jockey'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> calendar2016 [

	^ SingleRace ofTypeNamed: '2016 Calendar'
]

{ #category : #'private - test support' }
MatchUserStoryTest >> changeCurrentStepTo: aTurnStep [

	match execute: ( ChangeCurrentStepRequest changingTo: aTurnStep ) requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchUserStoryTest >> chargeManaWith: aCard [

	match execute: ( ChargeManaRequest chargingManaWith: aCard ) requestedBy: self turnPlayer
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

{ #category : #'private - test support' }
MatchUserStoryTest >> directAttackFrom: aCreatureCard [

	match execute: ( DirectAttackRequest attackingWith: aCreatureCard ) requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchUserStoryTest >> drawCard [

	match execute: DrawCardRequest new requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchUserStoryTest >> endTurn [

	match endTurnOf: self turnPlayer
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
MatchUserStoryTest >> setUpBattleZoneInWhichTheTurnPlayerHasOneTappedCreatureDueToDirectAttack [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: tulkTheOracle
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpFieldHavingCreatureLessPowerfulThanOpponentCreatureAndReadyToAttackIt [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: anotherMarch;
		endTurn;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vocalMegahit;
		changeCurrentStepTo: MainStep new;
		summon: immortalBaronVorg tappingAll: ( Array with: anotherMarch with: vocalMegahit );
		endTurn;
		endTurn.

	self
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: immortalBaronVorg;
		endTurn
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpFieldHavingCreatureMorePowerfulThanOpponentCreatureAndReadyToAttackIt [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		chargeManaWith: march;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: anotherMarch;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: anotherMarch;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vocalMegahit;
		changeCurrentStepTo: MainStep new;
		summon: immortalBaronVorg tappingAll: ( Array with: march with: vocalMegahit );
		endTurn;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: tulkTheOracle;
		endTurn
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

	self
		chargeManaWith: march;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vocalMegahit;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vorgBrawlerOfHell;
		changeCurrentStepTo: MainStep new;
		summon: darknessLeohl tappingAll: ( Array with: march with: vorgBrawlerOfHell );
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: tulkTheOracle;
		changeCurrentStepTo: MainStep new;
		summon: immortalBaronVorg tappingAll: ( Array with: vocalMegahit with: tulkTheOracle );
		endTurn.

	self
		endTurn;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: immortalBaronVorg;
		endTurn
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

{ #category : #'private - test support' }
MatchUserStoryTest >> summon: aCreatureCard tapping: aCard [

	self summon: aCreatureCard tappingAll: { aCard }
]

{ #category : #'private - test support' }
MatchUserStoryTest >> summon: aCreatureCard tappingAll: aCardCollection [

	match execute: ( SummonCreatureRequest summoning: aCreatureCard tappingAll: aCardCollection )
		requestedBy: self turnPlayer
]

{ #category : #'tests - battle' }
MatchUserStoryTest >> test01AttackingCreatureDestroysInBattleAnotherCreatureWhenItHasTheGreatestPower [

	| immortalBaronVorg tulkTheOracle |

	self setUpFieldHavingCreatureMorePowerfulThanOpponentCreatureAndReadyToAttackIt.

	immortalBaronVorg := self theOnlyOneIn: ( match summonedCreaturesOf: shobu ).
	tulkTheOracle := self theOnlyOneIn: ( match summonedCreaturesOf: knight ).

	self
		assert: ( match tappedCreaturesOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty.

	self
		changeCurrentStepTo: AttackStep new;
		attack: tulkTheOracle with: immortalBaronVorg.

	self
		assertTheOnlyOneIn: ( match tappedCreaturesOf: shobu ) is: immortalBaronVorg;
		assert: ( match summonedCreaturesOf: knight ) isEmpty;
		assertTheOnlyOneIn: ( match graveyardOf: knight ) is: tulkTheOracle
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test01PlayersBeginTheMatchWithFiveCardsInHand [

	self
		assert: ( match numberOfCardsInHandOf: shobu ) equals: 5;
		assert: ( match numberOfCardsInHandOf: knight ) equals: 5
]

{ #category : #'tests - turn order' }
MatchUserStoryTest >> test01PlayersTurnOrderIsCircular [

	self
		assert: ( match isTurnOf: shobu );
		endTurn;
		assert: ( match isTurnOf: knight );
		endTurn;
		assert: ( match isTurnOf: shobu )
]

{ #category : #'tests - card conditions' }
MatchUserStoryTest >> test01TappedManaIsUntappedAtTheBeginningOfThePlayerTurn [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self assertEmpty: ( match tappedManaOf: shobu ).

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march.

	self endTurn.

	self assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march.

	self endTurn.

	self assertEmpty: ( match tappedManaOf: shobu )
]

{ #category : #'tests - winning conditions' }
MatchUserStoryTest >> test01WhenPlayerDrawsHisLastCardThenLosesTheMatch [

	self
		endTurn;
		endTurn.

	shobu numberOfCardsInDeck - 1 timesRepeat: [ 
		self
			drawCard;
			endTurn;
			endTurn
		].

	self
		assert: shobu numberOfCardsInDeck equals: 1;
		deny: match hasEnded.

	self drawCard.

	self
		assert: shobu numberOfCardsInDeck isNothing;
		assert: match hasEnded;
		assert: match winner equals: knight
]

{ #category : #'tests - battle' }
MatchUserStoryTest >> test02AttackingCreatureIsDestroyedInBattleByAnotherCreatureWhenItHasLessPower [

	| tulkTheOracle immortalBaronVorg |

	self setUpFieldHavingCreatureLessPowerfulThanOpponentCreatureAndReadyToAttackIt.

	tulkTheOracle := self theOnlyOneIn: ( match summonedCreaturesOf: shobu ).
	immortalBaronVorg := self theOnlyOneIn: ( match summonedCreaturesOf: knight ).

	self
		assert: ( match tappedCreaturesOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty.

	self
		changeCurrentStepTo: AttackStep new;
		attack: immortalBaronVorg with: tulkTheOracle.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assertTheOnlyOneIn: ( match graveyardOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: ( match summonedCreaturesOf: knight ) is: immortalBaronVorg
]

{ #category : #'tests - card conditions' }
MatchUserStoryTest >> test02CreaturesHaveSummoningSicknessOnTheTurnTheyAreSummoned [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self chargeManaWith: march.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: match creaturesThatHaveSummoningSickness isEmpty.

	self
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: match creaturesThatHaveSummoningSickness is: tulkTheOracle
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

{ #category : #'tests - winning conditions' }
MatchUserStoryTest >> test02WhenPlayerAttacksDirectlyAndOpponentHasNoShieldsLeftThenPlayerWinsTheMatch [

	| tulkTheOracle |

	self
		test05WhenPlayerAttacksDirectlyThenAttackingCreatureIsTappedAndOneOpponentsShieldIsBrokenAndGoesToOpponentsHand.

	tulkTheOracle := self theOnlyOneIn: ( match tappedCreaturesOf: shobu ).

	( match shieldsOf: knight ) size timesRepeat: [ 
		self
			endTurn;
			endTurn;
			changeCurrentStepTo: AttackStep new;
			directAttackFrom: tulkTheOracle
		].

	self
		assert: ( match shieldsOf: knight ) isEmpty;
		deny: match hasEnded;
		should: [ match winner ]
		raise: Error
		withMessageText: 'Can''t know the winner until the game has ended.'.

	self
		endTurn;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: tulkTheOracle.

	self
		assertEmpty: ( match shieldsOf: knight );
		assert: match hasEnded;
		assert: match winner equals: shobu
]

{ #category : #'tests - battle' }
MatchUserStoryTest >> test03BothCreaturesAreDestroyedInBattleWhenTheyHaveTheSamePower [

	| darknessLeohl immortalBaronVorg |

	self setUpFieldHavingCreaturesWithSamePower.

	darknessLeohl := self theOnlyOneIn: ( match summonedCreaturesOf: shobu ).
	immortalBaronVorg := self theOnlyOneIn: ( match summonedCreaturesOf: knight ).

	self
		assert: ( match tappedCreaturesOf: shobu ) isEmpty;
		assert: ( match graveyardOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty.

	self
		changeCurrentStepTo: AttackStep new;
		attack: immortalBaronVorg with: darknessLeohl.

	self
		assert: ( match summonedCreaturesOf: shobu ) isEmpty;
		assert: ( match summonedCreaturesOf: knight ) isEmpty;
		assertTheOnlyOneIn: ( match graveyardOf: shobu ) is: darknessLeohl;
		assertTheOnlyOneIn: ( match graveyardOf: knight ) is: immortalBaronVorg
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

{ #category : #'tests - card conditions' }
MatchUserStoryTest >> test03SummoningSicknessEndsWhenPlayerEndsTurn [

	| march tulkTheOracle |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assertTheOnlyOneIn: match creaturesThatHaveSummoningSickness is: tulkTheOracle.

	self endTurn.

	self
		assertTheOnlyOneIn: ( match summonedCreaturesOf: shobu ) is: tulkTheOracle;
		assert: match creaturesThatHaveSummoningSickness isEmpty
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

{ #category : #'tests - card conditions' }
MatchUserStoryTest >> test04TappedCreatureRemainsTappedUntilTheBeginningOfItsOwnerTurn [

	| tulkTheOracle |

	self setUpBattleZoneInWhichTheTurnPlayerHasOneTappedCreatureDueToDirectAttack.

	tulkTheOracle := self theOnlyOneIn: ( match tappedCreaturesOf: shobu ).

	self
		assert: ( match isTurnOf: shobu );
		endTurn;
		assert: ( match isTurnOf: knight );
		assertTheOnlyOneIn: ( match tappedCreaturesOf: shobu ) is: tulkTheOracle;
		endTurn;
		assert: ( match isTurnOf: shobu );
		assertEmpty: ( match tappedCreaturesOf: shobu )
]

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test05PlayersBeginTheMatchWithoutCardsInGraveyard [

	self
		assert: ( match graveyardOf: shobu ) isEmpty;
		assert: ( match graveyardOf: knight ) isEmpty
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

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test07PlayerNotBelongingToMatchCantHaveShields [

	| intruder |

	intruder := self intruder.

	self
		should: [ match shieldsOf: intruder ]
		raise: Error
		withMessageText: 'Intruder is not a valid player in this match.'
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

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test09PlayerCantSeeOpponentCardsInHand [

	self
		should: [ match handOf: shobu requestedBy: knight ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t see the cards in your opponent''s hand.'
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

{ #category : #'private - accessing' }
MatchUserStoryTest >> turnPlayer [

	^ match currentPlayer
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
