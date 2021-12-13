Class {
	#name : #AttackCreatureRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
AttackCreatureRequestTest >> test01NonTurnPlayerCantAttackCreature [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Attack a creature on your opponent''s turn.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test02TurnPlayerCantAttackCreatureBeforeDrawingCard [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self endTurn.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack a creature in the Draw Card Step.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test03TurnPlayerCantAttackCreatureInTheChargeManaStep [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack a creature in the Charge Mana Step.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test04TurnPlayerCantAttackCreatureInTheMainStep [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self
		changeCurrentStepTo: MainStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack a creature in the Main Step.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test05TurnPlayerCantAttackCreatureWithNotSummonedCreature [

	| request |

	request := AttackCreatureRequest attacking: self vocalMegahit with: self immortalBaronVorg.

	self
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Immortal Baron, Vorg because it''s not summoned.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test06TurnPlayerCantAttackCreatureWithNonBelongingCreature [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: self vocalMegahit with: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Tulk, the Oracle because it''s not yours.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test07TurnPlayerCantAttackCreatureWithCreatureThatHasSummoningSickness [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: self vocalMegahit with: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Tulk, the Oracle because it has summoning sickness.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test08TurnPlayerCantAttackCreatureWhenIsNotSummoned [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: self vocalMegahit with: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack Vocal Megahit because it''s not summoned.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test09TurnPlayerCantAttackCreatureWhenItDoesntBelongToOpponent [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: tulkTheOracle with: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack Tulk, the Oracle because it''s yours.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test10TurnPlayerCantAttackCreatureWhenIsUntapped [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle request |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: immortalBaronVorg with: tulkTheOracle.

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
		changeCurrentStepTo: AttackStep new.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack Immortal Baron, Vorg because it''s untapped.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test11TurnPlayerAttacksCreature [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle request |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: tulkTheOracle with: immortalBaronVorg.

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
		endTurn.

	self
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: tulkTheOracle;
		endTurn.

	self
		assertEmpty: ( match tappedCreaturesOf: self turnPlayer );
		assertEmpty: ( match graveyardOf: self nonTurnPlayer );
		changeCurrentStepTo: AttackStep new.

	match execute: request requestedBy: self turnPlayer.

	self
		assertTheOnlyOneIn: ( match tappedCreaturesOf: self turnPlayer ) is: immortalBaronVorg;
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer );
		assertTheOnlyOneIn: ( match graveyardOf: self nonTurnPlayer ) is: tulkTheOracle
]

{ #category : #tests }
AttackCreatureRequestTest >> test12TurnPlayerCantAttackCreatureWithTappedCreature [

	| march vocalMegahit immortalBaronVorg anotherMarch tulkTheOracle anotherTulkTheOracle firstAttackRequest secondAttackRequest |

	march := self march.
	vocalMegahit := self vocalMegahit.
	immortalBaronVorg := self immortalBaronVorg.
	anotherMarch := self march.
	tulkTheOracle := self tulkTheOracle.
	anotherTulkTheOracle := self tulkTheOracle.

	firstAttackRequest := AttackCreatureRequest attacking: tulkTheOracle with: immortalBaronVorg.
	secondAttackRequest := AttackCreatureRequest attacking: anotherTulkTheOracle
		                       with: immortalBaronVorg.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: anotherMarch;
		endTurn.

	self
		changeCurrentStepTo: MainStep new;
		summon: anotherTulkTheOracle tapping: march;
		endTurn.

	self
		changeCurrentStepTo: ChargeManaStep new;
		chargeManaWith: vocalMegahit;
		changeCurrentStepTo: MainStep new;
		summon: immortalBaronVorg tappingAll: ( Array with: anotherMarch with: vocalMegahit );
		endTurn.

	self
		changeCurrentStepTo: AttackStep new;
		directAttackFrom: tulkTheOracle;
		directAttackFrom: anotherTulkTheOracle;
		endTurn.

	self changeCurrentStepTo: AttackStep new.
	match execute: firstAttackRequest requestedBy: self turnPlayer.

	self
		assertTheOnlyOneIn: ( match tappedCreaturesOf: self turnPlayer ) is: immortalBaronVorg;
		assertTheOnlyOneIn: ( match graveyardOf: self nonTurnPlayer ) is: tulkTheOracle.

	self should: [ match execute: secondAttackRequest requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Immortal Baron, Vorg because it''s tapped.'.

	self
		assertTheOnlyOneIn: ( match tappedCreaturesOf: self turnPlayer ) is: immortalBaronVorg;
		assertTheOnlyOneIn: ( match graveyardOf: self nonTurnPlayer ) is: tulkTheOracle
]
