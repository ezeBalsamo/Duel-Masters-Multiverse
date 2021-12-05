Class {
	#name : #ChargeManaRequest,
	#superclass : #MatchRequest,
	#instVars : [
		'card'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
ChargeManaRequest class >> actionDescription [

	^ 'Charge Mana'
]

{ #category : #'instance creation' }
ChargeManaRequest class >> chargingManaWith: aCard [

	^ self new initializeChargingManaWith: aCard
]

{ #category : #initialization }
ChargeManaRequest >> initializeChargingManaWith: aCard [

	card := aCard
]
