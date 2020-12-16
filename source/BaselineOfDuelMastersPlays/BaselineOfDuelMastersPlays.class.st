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
				group: 'Development' with: 'Tests'
			]
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpDependencies: spec [

	spec
		baseline: 'Superluminal' with: [ spec repository: 'github://ba-st/Superluminal:v1.2.0/source' ];
		project: 'Superluminal-Deployment-Core' copyFrom: 'Superluminal' with: [ spec loads: 'Core' ];
		project: 'Superluminal-Tests' copyFrom: 'Superluminal' with: [ spec loads: 'Tests' ]
]

{ #category : #accessing }
BaselineOfDuelMastersPlays >> setUpPackages: spec [

	spec
		package: 'Duel-Masters-Plays-Model' with: [ spec requires: 'Superluminal-Deployment-Core' ];
		group: 'Deployment' with: 'Duel-Masters-Plays-Model';
		package: 'Duel-Masters-Plays-Model-Tests'
			with: [ spec requires: #('Duel-Masters-Plays-Model' 'Superluminal-Tests') ];
		group: 'Tests' with: 'Duel-Masters-Plays-Model-Tests'
]
