Class {
	#name : #ChargeManaStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
ChargeManaStep >> allowedActionDescriptions [

	^ super allowedActionDescriptions
		  add: PlayerActionDescriptions chargeMana;
		  yourself
]

{ #category : #'private - accessing' }
ChargeManaStep >> stepName [

	^ 'Charge Mana'
]
