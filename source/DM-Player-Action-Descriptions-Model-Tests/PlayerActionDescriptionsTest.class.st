"
A PlayerActionDescriptionsTest is a test class for testing the behavior of PlayerActionDescriptions
"
Class {
	#name : #PlayerActionDescriptionsTest,
	#superclass : #TestCase,
	#category : #'DM-Player-Action-Descriptions-Model-Tests'
}

{ #category : #tests }
PlayerActionDescriptionsTest >> testActionDescriptions [

	self
		assert: PlayerActionDescriptions changeCurrentStep equals: 'Change current step';
		assert: PlayerActionDescriptions drawCard equals: 'Draw a card';
		assert: PlayerActionDescriptions chargeMana equals: 'Charge mana';
		assert: PlayerActionDescriptions summonCreature equals: 'Summon a creature'
]
