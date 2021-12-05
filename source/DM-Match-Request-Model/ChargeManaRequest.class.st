Class {
	#name : #ChargeManaRequest,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #'instance creation' }
ChargeManaRequest class >> chargingManaWith: aCard [

	^ self new initializeChargingManaWith: aCard
]

{ #category : #accessing }
ChargeManaRequest >> actionDescription [

	^ 'Charge Mana'
]

{ #category : #initialization }
ChargeManaRequest >> initializeChargingManaWith: aCard [

	card := aCard
]
