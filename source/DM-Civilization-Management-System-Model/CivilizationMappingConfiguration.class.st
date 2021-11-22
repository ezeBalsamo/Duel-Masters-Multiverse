Class {
	#name : #CivilizationMappingConfiguration,
	#superclass : #Object,
	#category : #'DM-Civilization-Management-System-Model'
}

{ #category : #applying }
CivilizationMappingConfiguration >> applyTo: aRepository [

	aRepository
		configureMappingsIn: [ :aRDBRepository | 
			aRDBRepository
				beAwareOfClassModelDefinedBy: self civilizationClassModelDefinition;
				beAwareOfDescriptorDefinedBy: self civilizationDescriptorDefinition;
				beAwareOfTableDefinedBy: self civilizationTableDefinition
			]
]

{ #category : #'private - definitions' }
CivilizationMappingConfiguration >> civilizationClassModelDefinition [

	^ ClassModelDefinition
		for: Civilization
		attributesDefinedBy:
			( Array
				with: ( BasicAttributeDefinition named: RDBMSConstants sequentialNumberAttribute )
				with: ( BasicAttributeDefinition named: self nameAttribute ) )
]

{ #category : #'private - definitions' }
CivilizationMappingConfiguration >> civilizationDescriptorDefinition [

	^ ConcreteDescriptorDefinition
		for: Civilization
		onTableNamed: self civilizationTableName
		mappingsDefinedBy:
			( Array
				with: ( SequentialNumberMappingDefinition onTableNamed: self civilizationTableName )
				with:
					( DirectMappingDefinition
						fromAttributeNamed: self nameAttribute
						toFieldNamed: self nameFieldName
						onTableNamed: self civilizationTableName ) )
]

{ #category : #'private - definitions' }
CivilizationMappingConfiguration >> civilizationTableDefinition [

	^ RealTableDefinition
		named: self civilizationTableName
		fieldsDefinedBy:
			( Array
				with: SequentialNumberFieldDefinition new
				with: ( CharacterFieldDefinition named: self nameFieldName sized: '15' ) )
]

{ #category : #'private - accessing' }
CivilizationMappingConfiguration >> civilizationTableName [

	^ 'CIVILIZATION'
]

{ #category : #'private - accessing' }
CivilizationMappingConfiguration >> nameAttribute [

	^ #name
]

{ #category : #'private - accessing' }
CivilizationMappingConfiguration >> nameFieldName [

	^ 'name'
]
