Class {
	#name : #Civilizations,
	#superclass : #Object,
	#category : #'Duel-Masters-Card-Model'
}

{ #category : #accessing }
Civilizations class >> all [

	^ Array
		with: Civilization fire
		with: Civilization water
		with: Civilization nature
		with: Civilization light
		with: Civilization darkness
]
