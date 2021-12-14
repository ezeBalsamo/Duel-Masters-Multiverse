"
A MatchTest is a test class for testing the behavior of Match
"
Class {
	#name : #MatchUserStoryTest,
	#superclass : #PersistentSystemBasedUserStoryTest,
	#traits : 'TestCreatureCardProvider + RequestExecutionTestAssistant',
	#classTraits : 'TestCreatureCardProvider classTrait + RequestExecutionTestAssistant classTrait',
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
MatchUserStoryTest >> knightDeck [

	^ ( ( 1 to: 40 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> match [

	^ match
]

{ #category : #'private - providing creatures' }
MatchUserStoryTest >> oneMana [

	^ DMUnits mana with: 1
]

{ #category : #running }
MatchUserStoryTest >> setUp [

	super setUp.

	shobu := Duelist named: 'Shobu' using: self shobuDeck.
	knight := Duelist named: 'Knight' using: self knightDeck.
	match := Match between: shobu and: knight
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpBattleZoneInWhichBothPlayersHaveCreaturesWithTheSamePower [

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
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vocalMegahit;
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vorgBrawlerOfHell;
		changeCurrentStepTo: MainStep new;
		summon: darknessLeohl tappingAll: ( Array with: march with: vorgBrawlerOfHell );
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: tulkTheOracle;
		changeCurrentStepTo: MainStep new;
		summon: immortalBaronVorg tappingAll: ( Array with: vocalMegahit with: tulkTheOracle );
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: immortalBaronVorg;
		endTurn;
		changeCurrentStepTo: DrawCardStep new;
		drawCard
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
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: MainStep new;
		endTurn;
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: tulkTheOracle
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpBattleZoneInWhichTurnPlayerHasOneCreatureLessPowerfulThanOpponentCreatureAndIsReadyToAttackIt [

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
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: anotherMarch;
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vocalMegahit;
		changeCurrentStepTo: MainStep new;
		summon: immortalBaronVorg tappingAll: ( Array with: anotherMarch with: vocalMegahit );
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		endTurn.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: immortalBaronVorg;
		endTurn;
		changeCurrentStepTo: DrawCardStep new;
		drawCard
]

{ #category : #'private - running' }
MatchUserStoryTest >> setUpBattleZoneInWhichTurnPlayerHasOneCreatureMorePowerfulThanOpponentCreatureAndIsReadyToAttackIt [

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
MatchUserStoryTest >> setUpRequirements [

	super setUpRequirements.
	self registerSubsystem: CivilizationManagementSystem new
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> shobuDeck [

	^ ( ( 1 to: 40 ) collect: #asString ) asOrderedCollection
]

{ #category : #'tests - battle' }
MatchUserStoryTest >> test01AttackingCreatureDestroysInBattleAnotherCreatureWhenItHasTheGreatestPower [

	| immortalBaronVorg tulkTheOracle |

	self
		setUpBattleZoneInWhichTurnPlayerHasOneCreatureMorePowerfulThanOpponentCreatureAndIsReadyToAttackIt.

	immortalBaronVorg := self theOnlyOneIn: ( match summonedCreaturesOf: shobu ).
	tulkTheOracle := self theOnlyOneIn: ( match summonedCreaturesOf: knight ).

	self
		assertEmpty: ( match tappedCreaturesOf: shobu );
		assertEmpty: ( match graveyardOf: knight ).

	self
		changeCurrentStepTo: AttackStep new;
		attack: tulkTheOracle with: immortalBaronVorg.

	self
		assertTheOnlyOneIn: ( match tappedCreaturesOf: shobu ) is: immortalBaronVorg;
		assertEmpty: ( match summonedCreaturesOf: knight );
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
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
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
		assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march;
		endTurn.

	self assertTheOnlyOneIn: ( match tappedManaOf: shobu ) is: march.

	self
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		endTurn.

	self assertEmpty: ( match tappedManaOf: shobu )
]

{ #category : #'tests - winning conditions' }
MatchUserStoryTest >> test01WhenPlayerDrawsHisLastCardThenLosesTheMatch [

	shobu numberOfCardsInDeck + knight numberOfCardsInDeck - 2 timesRepeat: [ 
		self
			endTurn;
			changeCurrentStepTo: DrawCardStep new;
			drawCard;
			changeCurrentStepTo: ChargeManaStep new
		].

	self
		assert: knight numberOfCardsInDeck equals: 1;
		deny: match hasEnded.

	self
		endTurn;
		changeCurrentStepTo: DrawCardStep new;
		drawCard.

	self
		assert: knight numberOfCardsInDeck isNothing;
		assert: match hasEnded;
		assert: match winner equals: shobu
]

{ #category : #'tests - battle' }
MatchUserStoryTest >> test02AttackingCreatureIsDestroyedInBattleByAnotherCreatureWhenItHasLessPower [

	| tulkTheOracle immortalBaronVorg |

	self
		setUpBattleZoneInWhichTurnPlayerHasOneCreatureLessPowerfulThanOpponentCreatureAndIsReadyToAttackIt.

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

{ #category : #'tests - field setup' }
MatchUserStoryTest >> test02PlayersBeginTheMatchWithFiveShields [

	self
		assert: ( match shieldsOf: shobu ) size equals: 5;
		assert: ( match shieldsOf: knight ) size equals: 5
]

{ #category : #'tests - winning conditions' }
MatchUserStoryTest >> test02WhenPlayerAttacksDirectlyAndOpponentHasNoShieldsLeftThenPlayerWinsTheMatch [

	| tulkTheOracle attackingBlock |

	self setUpBattleZoneInWhichTheTurnPlayerHasOneTappedCreatureDueToDirectAttack.

	tulkTheOracle := self theOnlyOneIn: ( match tappedCreaturesOf: shobu ).

	attackingBlock := [ 
	                  self
		                  endTurn;
		                  changeCurrentStepTo: DrawCardStep new;
		                  drawCard;
		                  changeCurrentStepTo: ChargeManaStep new;
		                  endTurn;
		                  changeCurrentStepTo: DrawCardStep new;
		                  drawCard;
		                  changeCurrentStepTo: AttackStep new;
		                  directAttackFrom: tulkTheOracle
	                  ].

	( match shieldsOf: knight ) size timesRepeat: attackingBlock.

	self
		assertEmpty: ( match shieldsOf: knight );
		deny: match hasEnded;
		should: [ match winner ]
		raise: Error
		withMessageText: 'Can''t know the winner until the game has ended.'.

	attackingBlock value.

	self
		assertEmpty: ( match shieldsOf: knight );
		assert: match hasEnded;
		assert: match winner equals: shobu
]

{ #category : #'tests - battle' }
MatchUserStoryTest >> test03BothCreaturesAreDestroyedInBattleWhenTheyHaveTheSamePower [

	| darknessLeohl immortalBaronVorg |

	self setUpBattleZoneInWhichBothPlayersHaveCreaturesWithTheSamePower.

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
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
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
MatchUserStoryTest >> test06PlayerCantSeeOpponentCardsInHand [

	self
		should: [ match handOf: shobu requestedBy: knight ]
		raise: IllegalPlay
		withMessageText: 'Knight: You can''t see the cards in your opponent''s hand.'
]

{ #category : #'private - accessing' }
MatchUserStoryTest >> turnPlayer [

	^ match currentPlayer
]
