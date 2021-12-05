Class {
	#name : #ChargeManaStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
ChargeManaStep >> allowedActions [

	^ { ChargeManaRequest actionDescription }
]

{ #category : #'private - accessing' }
ChargeManaStep >> stepName [

	^ 'Charge Mana'
]
