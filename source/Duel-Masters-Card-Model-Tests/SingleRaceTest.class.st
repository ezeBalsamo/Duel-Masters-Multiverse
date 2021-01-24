"
A RaceTest is a test class for testing the behavior of Race
"
Class {
	#name : #SingleRaceTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Card-Model-Tests'
}

{ #category : #tests }
SingleRaceTest >> test01UncategorizedRice [

	| race alienRaceTypeName armorloidRaceTypeName |

	alienRaceTypeName := 'Alien'.
	armorloidRaceTypeName := 'Armorloid'.

	race := SingleRace ofTypeNamed: alienRaceTypeName.
	self
		assert: ( race isOfTypeNamed: alienRaceTypeName );
		deny: ( race isOfTypeNamed: armorloidRaceTypeName )
]
