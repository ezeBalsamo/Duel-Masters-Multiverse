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
				loads: #('Deployment Dependent-SUnit-Extensions')
			]
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpPackages: spec [

	spec
		package: 'Duel-Masters-Plays-Model' with: [ spec requires: #('Superluminal') ];
		group: 'Deployment' with: 'Duel-Masters-Plays-Model';
		package: 'Duel-Masters-Plays-Tools' with: [ spec requires: #('Buoy') ];
		group: 'Tools' with: 'Duel-Masters-Plays-Tools'.

	self setUpTestPackages: spec
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpTestPackages: spec [

	spec
		package: 'Duel-Masters-Plays-Model-Tests'
			with: [ spec requires: #('Duel-Masters-Plays-Model' 'Buoy') ];
		package: 'Duel-Masters-Plays-Tools-Tests' with: [ spec requires: #('Duel-Masters-Plays-Tools') ];
		group: 'Tests' with: #('Duel-Masters-Plays-Model-Tests' 'Duel-Masters-Plays-Tools-Tests')
]
