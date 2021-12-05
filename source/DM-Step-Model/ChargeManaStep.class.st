Class {
	#name : #ChargeManaStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
ChargeManaStep >> allowedActionDescriptions [

	^ { PlayerActionDescriptions chargeMana }
]

{ #category : #'private - accessing' }
ChargeManaStep >> stepName [

	^ 'Charge Mana'
]
