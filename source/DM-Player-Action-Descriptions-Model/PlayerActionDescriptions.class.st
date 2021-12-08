Class {
	#name : #PlayerActionDescriptions,
	#superclass : #Object,
	#category : #'DM-Player-Action-Descriptions-Model'
}

{ #category : #accessing }
PlayerActionDescriptions class >> attack [

	^ 'Attack'
]

{ #category : #accessing }
PlayerActionDescriptions class >> attackCreature [

	^ 'Attack a creature'
]

{ #category : #accessing }
PlayerActionDescriptions class >> changeCurrentStep [

	^ 'Change current step'
]

{ #category : #accessing }
PlayerActionDescriptions class >> chargeMana [

	^ 'Charge mana'
]

{ #category : #accessing }
PlayerActionDescriptions class >> drawCard [

	^ 'Draw a card'
]

{ #category : #accessing }
PlayerActionDescriptions class >> summonCreature [

	^ 'Summon a creature'
]
