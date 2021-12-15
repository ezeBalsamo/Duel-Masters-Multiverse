Trait {
	#name : #TestCreatureCardProvider,
	#instVars : [
		'lightCivilization',
		'fireCivilization',
		'darknessCivilization'
	],
	#category : #'DM-Match-Tests-Support'
}

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> darknessLeohl [

	^ CreatureCard named: 'Darkness Leohl'
		  from: darknessCivilization
		  ofType: ( SingleRace ofTypeNamed: 'Dark Monster' )
		  costing: ( DMUnits mana with: 2 )
		  providing: self oneMana
		  with: ( DMUnits power with: 2000 )
]

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> immortalBaronVorg [

	^ CreatureCard named: 'Immortal Baron, Vorg'
		  from: fireCivilization
		  ofType: ( SingleRace ofTypeNamed: 'Human' )
		  costing: ( DMUnits mana with: 2 )
		  providing: self oneMana
		  with: ( DMUnits power with: 2000 )
]

{ #category : #initialization }
TestCreatureCardProvider >> initialize [

	super initialize.
	self initializeCivilizations
]

{ #category : #initialization }
TestCreatureCardProvider >> initializeCivilizations [

	lightCivilization := Civilization named: 'Light'.
	fireCivilization := Civilization named: 'Fire'.
	darknessCivilization := Civilization named: 'Darkness'
]

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> march [

	^ CreatureCard named: 'March'
		  from: lightCivilization
		  ofType: ( SingleRace ofTypeNamed: '2016 Calendar' )
		  costing: ( DMUnits mana with: 3 )
		  providing: self oneMana
		  with: ( DMUnits power with: 3000 )
]

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> oneMana [

	^ DMUnits mana with: 1
]

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> tulkTheOracle [

	^ CreatureCard named: 'Tulk, the Oracle'
		  from: lightCivilization
		  ofType: ( SingleRace ofTypeNamed: 'Light Bringer' )
		  costing: self oneMana
		  providing: self oneMana
		  with: ( DMUnits power with: 500 )
]

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> vocalMegahit [

	^ CreatureCard named: 'Vocal Megahit'
		  from: fireCivilization
		  ofType: ( SingleRace ofTypeNamed: 'Beat Jockey' )
		  costing: ( DMUnits mana with: 5 )
		  providing: self oneMana
		  with: ( DMUnits power with: 5000 )
]

{ #category : #'private - providing creatures' }
TestCreatureCardProvider >> vorgBrawlerOfHell [

	^ CreatureCard
		  named: 'Vorg, Brawler of Hell'
		  fromAll: ( Array with: fireCivilization with: darknessCivilization )
		  ofType: ( MultipleRace conformedByAll: ( Array with: ( SingleRace ofTypeNamed: 'Human' )
					      with: ( SingleRace ofTypeNamed: 'Beat Jockey' )
					      with: ( SingleRace ofTypeNamed: 'Alien' ) ) )
		  costing: ( DMUnits mana with: 2 )
		  providing: self oneMana
		  with: ( DMUnits power with: 4000 )
]
