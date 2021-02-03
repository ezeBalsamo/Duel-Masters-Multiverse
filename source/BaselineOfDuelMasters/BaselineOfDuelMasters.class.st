Class {
	#name : #BaselineOfDuelMasters,
	#superclass : #BaselineOf,
	#category : #BaselineOfDuelMasters
}

{ #category : #accessing }
BaselineOfDuelMasters >> baseline: spec [

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
BaselineOfDuelMasters >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> setUpDependencies: spec [

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
			];
		baseline: 'Aconcagua'
			with: [ spec
				repository: 'github://ba-st/Aconcagua:v8/source';
				loads: #('Deployment')
			];
		baseline: 'Kepler'
			with: [ spec
				repository: 'github://ba-st/Kepler:v5/source';
				loads: #('Deployment' 'Dependent-SUnit-Extensions')
			];
		baseline: 'Sagan'
			with: [ spec
				repository: 'github://ba-st/Sagan:v4.1.0/source';
				loads: #('Deployment' 'PostgreSQL')
			]
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpDependentSUnitExtensionsOn: aSpec [

	aSpec package: 'DM-SUnit-Model' with: [ aSpec requires: #('Buoy' 'Kepler') ].
	aSpec group: 'Dependent-SUnit-Extensions' with: 'DM-SUnit-Model'
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpModelPackagesOn: aSpec [

	aSpec
		package: 'DM-Civilization-Model' with: [ aSpec requires: 'Buoy' ];
		package: 'DM-Race-Model' with: [ aSpec requires: 'Buoy' ];
		package: 'DM-Card-Model' with: [ aSpec requires: #('Buoy' 'Aconcagua') ].
		
	aSpec
		package: 'DM-Civilization-Management-System-Model' with: [ aSpec requires: 'Kepler' ];
		package: 'DM-Race-Management-System-Model' with: [ aSpec requires: 'Kepler' ];
		package: 'DM-Card-Management-System-Model' with: [ aSpec requires: #('DM-Civilization-Management-System-Model' 'DM-Race-Management-System-Model') ].
		
	aSpec 
		package: 'DM-Card-Module-Model' with: [ aSpec requires: 'DM-Card-Management-System-Model' ];
		package: 'DM-Repository-Provider-Module-Model' with: [ aSpec requires: 'Sagan' ].

	aSpec package: 'DM-Installation-Model' with: [ aSpec requires: 'DM-Card-Module-Model' ].
	
	aSpec package: 'DMP-Wikitext-Parsing-Model' with: [ aSpec requires: 'Buoy' ].

	aSpec 
		group: 'Deployment'
		with: #('DM-Civilization-Model' 'DM-Race-Model' 'DM-Card-Model' 'DM-Civilization-Management-System-Model' 'DM-Race-Management-System-Model' 'DM-Card-Management-System-Model' 'DM-Card-Module-Model' 'DM-Repository-Provider-Module-Model' 'DM-Installation-Model' 'DMP-Wikitext-Parsing-Model').
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpPackages: spec [

	self
		setUpModelPackagesOn: spec;
		setUpDependentSUnitExtensionsOn: spec;
		setUpToolsPackagesOn: spec;
		setUpTestPackagesOn: spec
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpTestPackagesOn: spec [

	spec
		package: 'DM-Civilization-Model-Tests' with: [ spec requires: #('DM-Civilization-Model' 'Buoy') ];
		package: 'DM-Race-Model-Tests' with: [ spec requires: #('DM-Race-Model' 'Buoy') ];
		package: 'DM-Card-Model-Tests' with: [ spec requires: #('DM-Card-Model' 'DM-Civilization-Model' 'DM-Race-Model' 'Aconcagua') ].

	spec
		package: 'DM-Civilization-Management-System-Model-Tests' with: [ spec requires: #('DM-Civilization-Management-System-Model') ];
		package: 'DM-Race-Management-System-Model-Tests' with: [ spec requires: #('DM-Race-Management-System-Model') ];
		package: 'DM-Card-Management-System-Model-Tests' with: [ spec requires: #('DM-Card-Management-System-Model') ].

	spec 
		package: 'DM-Card-Module-Model-Tests' with: [ spec requires: #('DM-Card-Module-Model') ];
		package: 'DM-Repository-Provider-Module-Model-Tests' with: [ spec requires: #('DM-Repository-Provider-Module-Model') ].

	spec package: 'DM-Installation-Model-Tests' with: [ spec requires: #('DM-Installation-Model') ].
	
	spec package: 'DMP-Wikitext-Parsing-Model-Tests' with: [ spec requires: #('DMP-Wikitext-Parsing-Model') ].

	spec package: 'DM-Tools-Tests' with: [ spec requires: #('DM-Tools') ].
	
	spec package: 'DM-SUnit-Tests' with: [ spec requires: #('DM-SUnit-Model') ] .

	spec
		group: 'Tests'
		with:
			#('DM-Civilization-Model-Tests' 'DM-Race-Model-Tests' 'DM-Card-Model-Tests' 'DM-Civilization-Management-System-Model-Tests' 'DM-Race-Management-System-Model-Tests' 'DM-Card-Management-System-Model-Tests' 'DM-Card-Module-Model-Tests' 'DM-Repository-Provider-Module-Model-Tests' 'DM-Installation-Model-Tests' 'DMP-Wikitext-Parsing-Model-Tests' 'DM-Tools-Tests' 'DM-SUnit-Tests')
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpToolsPackagesOn: aSpec [

	aSpec package: 'DM-Tools' with: [ aSpec requires: 'Buoy' ].

	aSpec group: 'Tools' with: 'DM-Tools'
]
