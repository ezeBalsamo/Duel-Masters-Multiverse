Class {
	#name : #SummonCreatureRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
SummonCreatureRequestTest >> test01NonTurnPlayerCantSummonCreature [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer );
		should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Summon a creature on your opponent''s turn.';
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test02TurnPlayerCantSummonCreatureBeforeDrawingCard [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	match endTurnOf: self turnPlayer.

	self
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature in the Draw Card Step.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test03TurnPlayerCantSummonCreatureInTheChargeManaStep [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature in the Charge Mana Step.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test04TurnPlayerCantSummonCreatureWithoutTappingMana [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		changeCurrentStepTo: MainStep new;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature without tapping mana.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test05TurnPlayerCantSummonCreatureWhenAtLeastOneCardToTapDoesNotBelongToMana [

	| request |

	request := SummonCreatureRequest summoning: self tulkTheOracle tapping: self march.

	self
		changeCurrentStepTo: MainStep new;
		assertEmpty: ( match manaOf: self turnPlayer );
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t tap March because it isn''t in your mana zone.';
		assertEmpty: ( match manaOf: self turnPlayer );
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test06TurnPlayerCantSummonSingleCivilizationCreatureWhenAtLeastOneCardToTapIsNotFromThatCivilization [

	| march request |

	march := self march.

	request := SummonCreatureRequest summoning: self tulkTheOracle tapping: march.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		assertTheOnlyOneIn: ( match manaOf: self turnPlayer ) is: march;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because:
			'You can''t summon Tulk, the Oracle without tapping at least one card from Light civilization from your mana zone.';
		assertTheOnlyOneIn: ( match manaOf: self turnPlayer ) is: march;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test07TurnPlayerCantSummonMultipleCivilizationCreatureWhenAtLeastOneOfItsCivilizationsIsntIncludedInThoseOfCardsToTap [

	| march tulkTheOracle vorgBrawlerOfHell cardsToTap request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.
	vorgBrawlerOfHell := self vorgBrawlerOfHell.

	cardsToTap := Array with: march with: tulkTheOracle.

	request := SummonCreatureRequest summoning: vorgBrawlerOfHell tappingAll: cardsToTap.

	self
		chargeManaWithAll: cardsToTap;
		changeCurrentStepTo: MainStep new;
		assertCollection: ( match manaOf: self turnPlayer ) hasSameElements: cardsToTap;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because:
			'You can''t summon Vorg, Brawler of Hell without tapping at least one card from Fire civilization and Darkness civilization from your mana zone.';
		assertCollection: ( match manaOf: self turnPlayer ) hasSameElements: cardsToTap;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test08TurnPlayerCantSummonCreatureWhenTheManaNumberOfCardsToTapIsLessThanCreatureManaCost [

	| immortalBaronVorg vocalMegahit request |

	immortalBaronVorg := self immortalBaronVorg.
	vocalMegahit := self vocalMegahit.

	request := SummonCreatureRequest summoning: immortalBaronVorg tapping: vocalMegahit.

	self
		chargeManaWith: vocalMegahit;
		changeCurrentStepTo: MainStep new;
		assertTheOnlyOneIn: ( match untappedManaOf: self turnPlayer ) is: vocalMegahit;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because:
			'You have to tap cards whose sum of mana number equals the mana cost of Immortal Baron, Vorg.';
		assertTheOnlyOneIn: ( match untappedManaOf: self turnPlayer ) is: vocalMegahit;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]
