Class {
	#name : #ChargeManaRequest,
	#superclass : #Object,
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

{ #category : #accessing }
ChargeManaRequest >> actionDescription [

	^ self class actionDescription
]

{ #category : #initialization }
ChargeManaRequest >> initializeChargingManaWith: aCard [

	card := aCard
]

{ #category : #testing }
ChargeManaRequest >> isAllowedIn: aStep [

	^ aStep allows: self
]
