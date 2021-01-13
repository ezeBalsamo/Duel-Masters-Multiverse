Class {
	#name : #BaselineOfDuelMastersPlays,
	#superclass : #BaselineOf,
	#category : #BaselineOfDuelMastersPlays
}

{ #category : #accessing }
BaselineOfDuelMastersPlays >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self
				setUpDependencies: spec;
				setUpPackages: spec.
			spec
				group: 'CI' with: 'Tests';
				group: 'Development' with: #('Tools' 'Tests')
			]
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpDependencies: spec [

	spec
		baseline: 'Superluminal'
			with: [ spec
				repository: 'github://ba-st/Superluminal:v1.2.0/source';
				loads: #('Core')
			];
		baseline: 'Buoy'
			with: [ spec
				repository: 'github://ba-st/Buoy:v6/source';
				loads: #('Deployment' 'Dependent-SUnit-Extensions')
			]
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpPackages: spec [

	spec
		package: 'Duel-Masters-Card-Model';
		package: 'Duel-Masters-Plays-Wikitext-Parsing-Model'
			with: [ spec requires: #('Superluminal' 'Buoy') ];
		group: 'Deployment'
			with: #('Duel-Masters-Card-Model' 'Duel-Masters-Plays-Wikitext-Parsing-Model');
		package: 'Duel-Masters-Tools' with: [ spec requires: #('Buoy') ];
		group: 'Tools' with: 'Duel-Masters-Tools'.

	self setUpTestPackages: spec
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpTestPackages: spec [

	spec
		package: 'Duel-Masters-Card-Model-Tests' with: [ spec requires: #('Duel-Masters-Card-Model') ];
		package: 'Duel-Masters-Plays-Wikitext-Parsing-Model-Tests'
			with: [ spec requires: #('Duel-Masters-Plays-Wikitext-Parsing-Model' 'Buoy') ];
		package: 'Duel-Masters-Tools-Tests' with: [ spec requires: #('Duel-Masters-Tools') ];
		group: 'Tests'
			with:
			#('Duel-Masters-Card-Model-Tests Duel-Masters-Plays-Wikitext-Parsing-Model-Tests' 'Duel-Masters-Tools-Tests')
]
