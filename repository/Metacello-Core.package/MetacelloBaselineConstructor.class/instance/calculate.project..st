private
calculate: aConfig project: aProject
  | versionMap versionSpec |
  self configuration: aConfig.
  self
    setProject:
      (aProject
        ifNil: [ 
          [ aConfig class project ]
            on: MessageNotUnderstood
            do: [ :ex | ex return: nil ] ]).
  versionMap := Dictionary new.
  (self extractBaselinePragmaFor: aConfig class)
    do: [ :pragma | 
      versionSpec := self project versionSpec.
      self root: versionSpec.
      self evaluatePragma: pragma.
      self project attributes
        do: [ :attribute | 
          | blockList |
          (blockList := self attributeMap at: attribute ifAbsent: [  ]) ~~ nil
            ifTrue: [ blockList do: [ :block | self with: versionSpec during: block ] ] ].
      versionSpec versionString: self project singletonVersionName.
      versionMap at: versionSpec versionString put: versionSpec createVersion ].
  self project map: versionMap.
  self project errorMap: Dictionary new.
  self project configuration: aConfig