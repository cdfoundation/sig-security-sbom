# usage
# 1. update model JSON files
# 2. run this script
# 3. resulting DOCX and XMI files in work directory

# requirements ####
load.libraries <- c(
  'XML',
  'tidyverse',
  'officer',
  'visNetwork',
  'RColorBrewer',
  'tidygraph',
  'ggraph',
  'igraph',
  'jsonlite'
)
install.lib <-
  load.libraries[!load.libraries %in% installed.packages()]
for (libs in install.lib)
  install.packages(libs)
sapply(load.libraries, require, character = TRUE)


fromFile<-TRUE # read model from file rather than from inline code
modelFile <-  # target the subdirectory of model subdirectory to find the model files (these model files are currently checked-in model_configuration subdirectory in this git repo)
  "plb"
  # "lba"
  # "spdx"
  # "graph"


# I/O ####
outXmiFile <- "generated_3T-SBOM-EMS.xmi"
outDocxFile <- "generated_3T-SBOM-EMS.docx"


# MODEL ####
# o packages ####
if(fromFile) {
  package_list_intro <-
    fromJSON(txt = file.path(getwd(), "model", modelFile, "package_list_intro.json"))
} else {
  package_list_intro <-
    paste("The rest of this document contains the technical content of this specification.",
          "The Tool-to-Tool - Software Bill of Material - Exchange Metamodel Standard (3T-SBOM-EMS) is a metamodel for defining and describing documents containing Software Bill of Material.",
          "It is independent of software implementation language and is highly independent of implementation details.",
          "It provides a common platform by which an end-users and tools can expose, share, consume such documents.",
          "3T-SBOM-EMS is composed of three packages, with references to pre-existing OMG standards, which are outside the scope of this document.")
    
  package_list_intro %>%
    write_json(path=file.path(getwd(), "model", modelFile, "package_list_intro.json"),pretty=T,auto_unbox=T)
}

background_intro <- "Specification overview - Provides background information on the organization of the Tool-to-Tool (3T) Software Bill of Materials (SBOM) Exchange Metamodel Standard (EMS) specification."

if(fromFile) {
  packages <- 
    fromJSON(txt = file.path(getwd(), "model", modelFile, "packages.json")) %>%
    as_tibble()
} else {
  packages <- tribble(
    ~ id,
    ~ name,
    ~ description,
    "3T-SBOM-EMS-Relationships",
    "Relationships",
    "The 3T-SBOM-EMS Relationships package defines classes for creating relations between Software Bill of Material node elements. This enables a graph-based approach to SBOM composition and analysis. All 3T-SBOM-EMS compliant tooling, repository, or efforts must support the Relationships package.",
    "3T-SBOM-EMS-Activities",
    "Activities",
    "The 3T-SBOM-EMS Activities package defines classes for handling the information about the transformations the elements detailed by the Software Bill of Material are subject of. All 3T-SBOM-EMS compliant tooling, repository, or efforts must support the Activities package.",
    "3T-SBOM-EMS-Definitions",
    "Definitions",
    "The 3T-SBOM-EMS Definitions package defines classes for structuring Software Bill of Material documents. All 3T-SBOM-EMS compliant tooling, repository, or efforts must support the Definitions package."
  )
  packages  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "packages.json"),pretty=T,auto_unbox=T)
}

if(fromFile) {
  model_intro <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "model_intro.json"))
} else {
  model_intro <- 
    c(
      "The following clauses will list and detail the classes and enumerations from each of the three 3T-SBOM-EMS model packages.",
      paste("The 3T-SBOM-EMS is defining model elements that are designed as place-holders for specific pieces of information.",
            "The model itself does not require anyone to share or expose every possible piece of information, but it defines how to share and expose them when there is an agreement or requirement for them to be shared and exposed."),
      paste("The 3T-SBOM-EMS model is also designed to support document-formatting as well as graph-formatting.",
            "The former is achieved by the serialization of instances of the classes from the model, according to serialization guidelines.",
            "The latter is achieved by a node-oriented modeling of concepts, with possible relationships between these."),
      "As shown in figure 1, the Tool-to-Tool Software Bill of Materials Exchange Metamodel Standard metamodel consists of three packages: the Definitions Package; the Relationships Package; and the Activities Package."
    ) 
  
  model_intro  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "model_intro.json"),pretty=T,auto_unbox=T)
}

if(fromFile) {
  package_intro <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "package_intro.json"))
} else {
  package_intro <- 
    tribble(~package,~intro,
            "Definitions",paste("This chapter presents the normative specification for the Tool-to-Tool Software Bill of Materials Exchange Metamodel Standard metamodel Definitions Classes.",
                                "It begins with an overview of the Definitions Classes metamodel inheritance structure shown in Figure 2 followed by a description of each element.",
                                "The inheritance from the MOF::Element class is key to ensure the 3T-SBOM-EMS meta model integrates with existing MOF-based meta models.",
                                "The Node class is pivotal to the 3T-SBOM-EMS as it brings the identification, lifecycle, annotation, and relationship capabilities to all inheriting classes and is called out in Figure 3 for better understanding of that portion of the Definitions Classes.",
                                "Then, the Artifact and Document classes are at the core of software bill of material and are called out in Figure 4 for better understanding of that portion of the Definitions Classes."),
            "Relationships",paste("This chapter presents the normative specification for the Tool-to-Tool Software Bill of Materials Exchange Metamodel Standard metamodel Relationships Classes.",
                                  "It begins with an overview of the Relationships Classes metamodel inheritance structure shown in Figure 7 followed by a description of each element.",
                                  "Their adherence to the Node class from the Definitions package is shown in Figure 3; this is key as this means that one can define relationships between any Node of the 3T-SBOM-EMS meta model."),
            "Activities",paste("This chapter presents the normative specification for the Tool-to-Tool Software Bill of Materials Exchange Metamodel Standard metamodel Activities Classes.",
                               "It begins with an overview of the main Activities Classes metamodel inheritance structure shown in Figure 5 followed by a description of each element. ",
                               "The Action centric portion of the Activities Package is called out in Figure 6 for better understanding of that portion of the Activities Classes.",
                               "Their adherence to the Node class from the Definitions package is shown in the same Figure 6; this is key as this means that one can define use any Node of the 3T-SBOM-EMS meta model as the input, the mean, and the output of an Action.")
    ) 
  
  package_intro  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "package_intro.json"),pretty=T,auto_unbox=T)
}

# o classes ####
if(fromFile) {
  classes <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "classes.json")) %>%
    as_tibble()
} else {
  classes <-
    tribble(
      ~ name,
      ~ package,
      ~ generalization,
      ~ description,
      ~ compositionDescription,
      "Node",
      "Definitions",
      NA,
      "This class is the abstract parent class of all the classes from the 3T-SBOM-EMS specifications. It supports a graph-based approach to Software Bill of Material modeling where salient elements are the nodes of a graph.",
      c(),
      #
      "Document",
      "Definitions",
      "Node",
      "This class represents the Software Bill of Material document. It is deals with pieces of information pertaining to the following facets:",
      c(
        "The artifact the SBoM document is detailing,",
        "The SBoM document itself, such as the author, the time-stamp, the generation method, and the signature,",
        "Further information pieces related to the artifact, such as license information, pedigree information, document annotations, and related documents."
      ),
      #
      "ComponentItem",
      "Definitions",
      "Node",
      "This class represents logical and physical deliverable files or group of files.",
      c(),
      #
      "Artifact",
      "Definitions",
      "ComponentItem",
      "This class represents the artifact detailed by the Software Bill of Material document. It is deals with pieces of information pertaining to the following facets:",
      c(
        "The component supplier,",
        "The component,",
        "The version of the component,",
        "The component checksum, to ensure the component has not been tampered with,",
        "The file elements to detail the composition of the delivered component."
      ),
      #
      "FileItem",
      "Definitions",
      "ComponentItem",
      "This class represents physical deliverable files or group of files.",
      c(),
      #
      "File",
      "Definitions",
      "FileItem",
      "This class represents physical deliverable files. ",
      c(),
      #
      "FileGroup",
      "Definitions",
      "FileItem",
      "This class represents physical deliverable group of files. It is composed of files and/or file groups.",
      c(),
      #
      "Agent",
      "Definitions",
      "Node",
      "This class represents the person, organization, system, entity which plays a role vis-a-vis the Software Bill of Material node elements. E.g.: creator of an SBoM node element, or supplier of the artifact, or performer of the pedigree-related action. It is deals with pieces of information pertaining to the following facets:",
      c(),
      #
      "Checksum",
      "Definitions",
      NA,
      "This class represents the hash value using the provided hash algorithm of the related content: a document, a source file, a binary file, ... The following special situations should be processed as described:",
      c("To compute the checksum of an Artifact supported by the delivery of multiple physical files, the checksum is computed as the checksum of files' checksum values, sorted alphabetically.",
        "To compute the SBOM document checksum, the checksum is computed as the checksum of all the SBOM document content, excluding the CreationInfo.checksum.checksumValue element(s)."),
      #
      "Configuration",
      "Activities",
      NA,
      "This class represents the configuration settings of a tool.",
      c(),
      #
      "Argument",
      "Activities",
      NA,
      "This class represents the arguments of an action.",
      c(),
      #
      "Annotation",
      "Definitions",
      "Node",
      "This class represents information to convey about the document, the document creation, the artifact, ... that is not part of the structured model. Annotation node elements can be used to support:",
      c(
        "Exchange of information that are not part of the specification but that are agreed upon between consumer and supplier of the document,",
        "Information about vulnerability-related analysis results,",
        "Information about artifact topics and technologies,",
        "Data Marking",
        "...  "
      ),
      #
      "LicenseInfo",
      "Definitions",
      "Node",
      "This class represents the licensing information, detailing the Intellectual Property of the artifact or of its constituant elements.",
      c(),
      #
      "PedigreeInfo",
      "Activities",
      "Node",
      "This class represents the pedigree information, detailing the ways the artifact was produced. It is composed of a set of actions.",
      c(),
      #
      "Action",
      "Activities",
      "Node",
      "This class represents action performed during the production process of the artifact. It is worth noting that:",
      c("The actions can be linked together via the relationships, supporting sequences of actions,",
        "The actions can be linked to any other SBoM node elements used as input or produced as output of the action. Most of the time, these will be file items, but the 3T-SBOM-EMS model supports more advanced behaviors."),
      #
      "Tool",
      "Activities",
      "Node",
      "This class represents the tool used to perform a pedigree activity. It is deals with pieces of information pertaining to the following facets:",
      c("The tool editor,",
        "The tool name,",
        "The tool version and service pack information,",
        "The tool type."),
      #
      "Relationship",
      "Relationships",
      "Node",
      "This class represents a relationship between two SBoM node elements. It points at another SBoM node element, and indicates the nature of the relationship. It supports a graph-based approach to SBOM modeling where salient elements are the nodes of a graph, linked together via these relationships. Most of the time, these will be relationships between SBOM documents, but the 3T-SBOM-EMS model supports more advanced behaviors.",
      c()
    ) %>%
    inner_join(packages %>% select(-description), by = c("package" = "name")) %>%
    mutate(id = paste(sep = "-", id, name)) %>%
    glimpse()
  
  classes  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "classes.json"),pretty=T,auto_unbox=T)
}


# o classes.parents from classes ####
edges <- classes %>% 
  select(from=name,to=generalization) %>%
  mutate(to=ifelse(is.na(to),"MOF",to))

inheritances <- graph_from_data_frame(d=edges, directed = T)
inheritances %>% plot()

nodes_to_process <- V(inheritances)$name

egos<-ego(inheritances,nodes=nodes_to_process,mode = "out",order=5) 
names(egos) <- nodes_to_process

classes.parents <- lapply(nodes_to_process, function(class){
  egos[[class]] %>% 
    unlist() %>% 
    names() %>% 
    enframe(value="parent_class") %>% 
    filter(parent_class!=class, parent_class!="MOF") %>% 
    transmute(class=class,parent_class)
}) %>%
  bind_rows() %>%
  glimpse()

# o enumerations ####
if(fromFile) {
  enumerations <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "enumerations.json"))  %>%
    as_tibble()
} else {
  enumerations <- tribble(
    ~ name,
    ~ package,
    ~ description,
    "FileType",
    "Definitions",
    "enumerated data type defines additional specifications of the the nature of the file.",
    "AgentType",
    "Definitions",
    "enumerated data type defines additional specifications of the of the nature of the agent.",
    "ChecksumAlgorithm",
    "Definitions",
    "enumerated data type defines additional specifications of the of the algorithm used to compute the checksum.",
    "PopulationMethod",
    "Definitions",
    "enumerated data type defines additional specifications of the way the SBOM document was created.",
    "ToolType",
    "Activities",
    "enumerated data type defines additional specifications of the tool.",
    "AnnotationType",
    "Definitions", 
    "enumerated data type defines additional specifications of the annotation.",
    "RelationshipType",
    "Relationships",
    "enumerated data type defines additional specifications of the nature of the relation between the SBOM documents."
  ) %>%
    inner_join(packages %>% select(-description), by = c("package" = "name")) %>%
    mutate(id = paste(sep = "-", id, name)) %>%
    glimpse()
  
  enumerations  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "enumerations.json"),pretty=T,auto_unbox=T)
}

# o class attributes ####
if(fromFile) {
  classes.attributes <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "classes.attributes.json")) %>%
    as_tibble()
} else {
  classes.attributes <-
    tribble(
      ~ class,
      ~ name,
      ~ description, 
      ~ type,
      ~ aggregation,
      ~ multiplicity,
      ~ reverseName,
      ~ serializationComment,
      #
      "Node",
      "specVersion",
      "The version of the 3T-SBOM-EMS specifications with which the SBOM node element is compliant.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      "this attribute can be ommited during serialization when its value is equal to the value from the parent element",
      #
      "Node",
      "name",
      "The name of the SBOM node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Node",
      "identifier",
      "The unique identifier of the SBOM node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Node",
      "identificationAuthority",
      "The identification authority, for which the identifier is globally unique. If empty, the identifier is unique within the scope of SBOM document.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      "this attribute can be ommited during serialization when its value is equal to the value from the parent element",
      #
      "Node",
      "created",
      "The creation date of the SBOM node element",
      "https://www.w3.org/TR/xmlschema11-2/#dateTime",
      NA,
      "1",
      NA,
      "this attribute can be ommited during serialization when its value is equal to the value from the parent element",
      #
      "Node",
      "modified",
      "The modification date of the SBOM node element",
      "https://www.w3.org/TR/xmlschema11-2/#dateTime",
      NA,
      "1",
      NA,
      "this attribute can be ommited during serialization when its value is equal to the value from the parent element",
      #
      "Node",
      "creator",
      "The creator agent of the SBOM node element.",
      classes %>% filter(name == "Agent") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "node",
      "this shared association can be serialized inline for readability and compactness purposes; it can be ommited during serialization when its value is equal to the value from the parent element",
      #
      "Node",
      "annotation",
      "The element(s) capturing annotations to the SBOM node element.",
      classes %>% filter(name == "Annotation") %>% select("id") %>% as.character(),
      "composition",
      "*",
      "node",
      NA,
      #
      "ComponentItem",
      "licenseInfo",
      "The element capturing the license information relatived to the SBOM component item.",
      classes %>% filter(name == "LicenseInfo") %>% select("id") %>% as.character(),
      "shared",
      "0..1",
      "licensedComponent",
      "this shared association can be serialized inline for readability and compactness purposes; it can be ommited during serialization when its value is equal to the value from the parent element",
      #
      "Document",
      "identifier",
      "The unique identifier of the SBOM document node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Document",
      "artifact",
      "The element capturing the main artifact, detailed by the SBOM document.",
      classes %>% filter(name == "Artifact") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "document",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "Document",
      "pedigreeInfo",
      "The element capturing pedigree information relative to the artifact.",
      classes %>% filter(name == "PedigreeInfo") %>% select("id") %>% as.character(),
      "composition",
      "0..1",
      "document",
      NA,
      #
      "Document",
      "checksum",
      "The element(s) capturing the checksum of the document",
      classes %>% filter(name == "Checksum") %>% select("id") %>% as.character(),
      "composition",
      "0..1",
      "signedDocument",
      NA,
      #
      "Document",
      "populationMethod",
      "The element capturing the way the SBOM document was created.",
      enumerations %>% filter(name == "PopulationMethod") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "ComponentItem",
      "checksum",
      "The element(s) capturing the checksum of the component item",
      classes %>% filter(name == "Checksum") %>% select("id") %>% as.character(),
      "composition",
      "1..*",
      "signedComponent",
      NA,
      #
      "Artifact",
      "supplier",
      "The element capturing the supplier of the artifact.",
      classes %>% filter(name == "Agent") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "artifactSupplied",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "Artifact",
      "identifier",
      "The unique identifier of the SBOM artifact node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Artifact",
      "version",
      "The version of the artifact.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Artifact",
      "component",
      "The element(s) capturing the logical and/or physical file(s) and/or group(s) of file(s) supporting the delivery of the artifact.",
      classes %>% filter(name == "ComponentItem") %>% select("id") %>% as.character(),
      "shared",
      "1..*",
      "artifact",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "File",
      "type",
      "The element capturing the type of the file.",
      enumerations %>% filter(name == "FileType") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "File",
      "identifier",
      "The unique identifier of the SBOM file node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "File",
      "path",
      "The path of the file.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "FileGroup",
      "item",
      "The element(s) capturing the physical files and/or group(s) of file(s) within the file group.",
      classes %>% filter(name == "FileItem") %>% select("id") %>% as.character(),
      "shared",
      "1..*",
      "groupedIn",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "Agent",
      "type",
      "The element capturing the type of agent.",
      enumerations %>% filter(name == "AgentType") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "Agent",
      "identifier",
      "The unique identifier of the SBOM agent node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Checksum",
      "value",
      "The result of the checksum algorithm.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Checksum",
      "algorithm",
      "The element capturing the algorithm used to compute the checksum value.",
      enumerations %>% filter(name == "ChecksumAlgorithm") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "Annotation",
      "comment",
      "The text of the annotation.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Annotation",
      "identifier",
      "The unique identifier of the SBOM annotation node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Annotation",
      "type",
      "The element capturing the type of annotation.",
      enumerations %>% filter(name == "AnnotationType") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "LicenseInfo",
      "expression",
      "The license expression, compliant with the licensing specifications. E.g.: the SPDX License Expression https://spdx.github.io/spdx-spec/appendix-IV-SPDX-license-expressions/.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "LicenseInfo",
      "identifier",
      "The unique identifier of the SBOM license information node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "PedigreeInfo",
      "action",
      "The action(s) participating to the Artiract's pedigree",
      classes %>% filter(name == "Action") %>% select("id") %>% as.character(),
      "shared",
      "1..*",
      "pedigree",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "PedigreeInfo",
      "identifier",
      "The unique identifier of the SBOM pedigree information node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Tool",
      "editor",
      "The editor of the tool.",
      classes %>% filter(name == "Agent") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "tool",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "Tool",
      "identifier",
      "The unique identifier of the SBOM tool node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Tool",
      "version",
      "The version of the tool.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Tool",
      "servicePack",
      "The service pack of the tool.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Tool",
      "type",
      "The type of the tool.",
      enumerations %>% filter(name == "ToolType") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "Tool",
      "configuration",
      "The element(s) capturing the configuration settings of the tool.",
      classes %>% filter(name == "Configuration") %>% select("id") %>% as.character(),
      "composite",
      "*",
      "tool",
      NA,
      #
      "Configuration",
      "name",
      "The name of the configuration setting of the tool.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Configuration",
      "value",
      "The value of the configuration setting of the tool.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Action",
      "argument",
      "The element(s) capturing the argument(s) of the action to be performed.",
      classes %>% filter(name == "Argument") %>% select("id") %>% as.character(),
      "composite",
      "*",
      "action",
      NA,
      #
      "Action",
      "identifier",
      "The unique identifier of the SBOM action node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Action",
      "instrument",
      "The element(s) used to perform the action.",
      classes %>% filter(name == "Node") %>% select("id") %>% as.character(),
      "shared",
      "*",
      "instrumentalToAction",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "Action",
      "object",
      "The element(s) on which the action is performed.",
      classes %>% filter(name == "Node") %>% select("id") %>% as.character(),
      "shared",
      "*",
      "actionPerformedOn",
      NA,
      #
      "Action",
      "result",
      "The element(s) resulting the action.",
      classes %>% filter(name == "Node") %>% select("id") %>% as.character(),
      "shared",
      "*",
      "resultingFromAction",
      NA,
      #
      "Action",
      "performer",
      "The entity performing the action.",
      classes %>% filter(name == "Agent") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "actionPerformed",
      "this shared association can be serialized inline for readability and compactness purposes",
      #
      "Action",
      "environment",
      "The characterization of the environment in which the action is carried out.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Action",
      "location",
      "The characterization of the location where the action is carried out.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Action",
      "started",
      "The the time at which the action began.",
      "https://www.w3.org/TR/xmlschema11-2/#dateTime",
      NA,
      "1",
      NA,
      NA,
      #
      "Action",
      "ended",
      "The the time at which the action ended.",
      "https://www.w3.org/TR/xmlschema11-2/#dateTime",
      NA,
      "1",
      NA,
      NA,
      #
      "Argument",
      "name",
      "The name of the argument of the action.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "0..1",
      NA,
      NA,
      #
      "Argument",
      "value",
      "The value of the argument of the action.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "0..1",
      NA,
      NA,
      #
      "Relationship",
      "type",
      "The type of relationships between SBOM node elements.",
      enumerations %>% filter(name == "RelationshipType") %>% select("id") %>% as.character(),
      NA,
      "1",
      NA,
      NA,
      #
      "Relationship",
      "identifier",
      "The unique identifier of the SBOM relationship node element.",
      "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
      NA,
      "1",
      NA,
      NA,
      #
      "Relationship",
      "source",
      "The element capturing the source SBOM node element.",
      classes %>% filter(name == "Node") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "sourceOfRelationship",
      "this shared association can be serialized inline for readability and compactness purposes, both in the relationship element and in the source node element (as sourceOfRelationship association)",
      #
      "Relationship",
      "target",
      "The element capturing the target SBOM node element.",
      classes %>% filter(name == "Node") %>% select("id") %>% as.character(),
      "shared",
      "1",
      "targetOfRelationship",
      "this shared association can be serialized inline for readability and compactness purposes, both in the relationship element and in the target node element (as targetOfRelationship association)"
    ) %>%
    inner_join(classes %>% select(-description,-compositionDescription), by = c("class" = "name")) %>%
    mutate(association = ifelse(is.na(aggregation), NA, paste(sep = ".", id, name))) %>%
    mutate(id = paste(sep = "-", id, name)) %>%
    glimpse()
  
  classes.attributes  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "classes.attributes.json"),pretty=T,auto_unbox=T)
}

classes %>%
  anti_join(classes.attributes,by=c("name"="class")) %>%
  glimpse()

classes.attributes %>%
  anti_join(classes,by=c("class"="name")) %>%
  glimpse()

# o class attributes constraints ####
if(fromFile) {
  classes.attributes.constraints <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "classes.attributes.constraints.json")) %>%
    as_tibble()
} else {
  classes.attributes.constraints <-
    tribble(
      ~ class,
      ~ attribute,
      ~ constraint,
      ~ name,
      ~ description,
      # "Node","created","created<-is.POSIX(created)","POSIXcreationDateTime","The creation date time of the SBOM element must comply to the POSIX format",
      # "Node","modified","modified<-is.POSIX(modified)","POSIXmodificationDateTime","The modification date time of the SBOM node element must comply to the POSIX format",
      # "Action","started","started<-is.POSIX(started)","POSIXstartDateTime","The action start date time must comply to the POSIX format",
      # "Action","ended","ended<-is.POSIX(ended)","POSIXendDateTime","The action end date time must comply to the POSIX format",
      "Relationship",
      "source",
      "source<-exists(Node=source)",
      "sourceElementExistence",
      "The SBOM node element whose identifier is equal to the source node element value must exist.",
      #
      "Relationship",
      "target",
      "target<-exists(Node=target)",
      "targetElementExistence",
      "The SBOM node element whose identifier is equal to the target node element value must exist.",
      #
      "Relationship",
      "identifier",
      "identifier<-identifier=source.identifier+type+target.identifier",
      "relationshipIdentifier",
      "The identifier of the relationship is composed of: the identifier of the source node element, the relationship type, and the identifier of the target node element.",
      #
      "LicenseInfo",
      "identifier",
      "identifier<-identifier='licenseInfo'+identificationAuthority+expression",
      "licenseInfoIdentifier",
      "The identifier of the lincense information is composed of: 'licenseInfo', license information identification authority, and expression.",
      #
      "LicenseInfo",
      "name",
      "identifier<-identifier=name",
      "licenseInfoName",
      "The name of the lincense information is equal to its expression.",
      #
      "Tool",
      "identifier",
      "identifier<-identifier=type+editor.identifier+name+version+servicePack",
      "toolIdentifier",
      "The identifier of the tool is composed of: tool type, tool editor name, tool name, tool version, tool service pack.",
      #
      "Artifact",
      "identifier",
      "identifier<-identifier='artifact'+supplier.identifier+identificationAuthority+name+version+checksum.identifier",
      "artifactIdentifier",
      "The identifier of the artifact is composed of: 'artifact', artifact supplier identifier, artifact identification authority, artifact name, artifact version, and artifact checksum identifier.",
      #
      "Agent",
      "identifier",
      "identifier<-identifier=type+identificationAuthority+name",
      "agentIdentifier",
      "The identifier of the agent is composed of: agent type, agent identification authority and agent name.",
      #
      "Action",
      "identifier",
      "identifier<-identifier='action'+identificationAuthority+name",
      "actionIdentifier",
      "The identifier of the action is composed of: 'action', identification authority and name.",
      #
      "Annotation",
      "identifier",
      "identifier<-identifier='action'+identificationAuthority+name",
      "annotationIdentifier",
      "The identifier of the annotation is composed of: 'annotation', identification authority and name.",
      #
      "PedigreeInfo",
      "identifier",
      "identifier<-identifier='pedigreeInfo'+identificationAuthority+name",
      "pedigreeInfoIdentifier",
      "The identifier of the pedigree information is composed of: 'pedigreeInfo', identification authority and name.",
      #
      "Document",
      "identifier",
      "identifier<-identifier='document'+creator.identifier+name+artifact.identifier+checksum.identifier",
      "documentIdentifier",
      "The identifier of the document is composed of: 'document', document creator identifier, document name, artifact identifier, document checksum identifier."
    ) %>%
    inner_join(classes.attributes %>% select(class, name, id),
               by = c("class", "attribute" = "name")) %>%
    glimpse()
  
  
  classes.attributes.constraints  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "classes.attributes.constraints.json"),pretty=T,auto_unbox=T)
}
classes.attributes.constraints %>%
  anti_join(classes.attributes,by=c("class","attribute"="name")) %>%
  glimpse()




# o enumeration literals ####
if(fromFile) {
  enumerations.literals <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "enumerations.literals.json")) %>%
    as_tibble()
} else {
  enumerations.literals <- tribble(
    ~ name,
    ~ literal,
    ~ description,
    "FileType",
    "fileType_source",
    "if the file is human readable source code (.c, .html, etc.)",
    "FileType",
    "fileType_binary",
    "if the file is a compiled object, target image or binary executable (.o, .a, etc.)",
    "FileType",
    "fileType_archive",
    "if the file represents an archive (.tar, .jar, etc.)",
    "FileType",
    "fileType_application",
    "if the file is associated with a specific application type (MIME type of application/*)",
    "FileType",
    "fileType_audio",
    "if the file is associated with an audio file (MIME type of audio/* , e.g. .mp3)",
    "FileType",
    "fileType_text",
    "if the file is human readable text file (MIME type of text/*)",
    "FileType",
    "fileType_image",
    "if the file is associated with an picture image file (MIME type of image/*, e.g., .jpg, .gif)",
    "FileType",
    "fileType_video",
    "if the file is associated with a video file type (MIME type of video/*)",
    "FileType",
    "fileType_documentation",
    "if the file serves as documentation",
    "FileType",
    "fileType_spdx",
    "if the file is an SPDX document",
    "FileType",
    "fileType_other",
    "if the file doesn't fit into the above categories (generated artifacts, data files, etc.)",
    "AgentType",
    "agentType_person",
    "if the agent is a physical person.",
    "AgentType",
    "agentType_organization",
    "if the agent is an organization.",
    "AgentType",
    "agentType_system",
    "if the agent is a system.",
    "AgentType",
    "agentType_other",
    "if the agent doesn't fit into the above categories.",
    "ChecksumAlgorithm",
    "checksumAlgorithm_sha1",
    "if the algorithm is SHA1.",
    "ChecksumAlgorithm",
    "checksumAlgorithm_sha256",
    "if the algorithm is SHA-256.",
    "ChecksumAlgorithm",
    "checksumAlgorithm_sha256",
    "if the algorithm is SHA-512.",
    "ChecksumAlgorithm",
    "checksumAlgorithm_md5",
    "if the algorithm is MD5.",
    "ChecksumAlgorithm",
    "checksumAlgorithm_other",
    "if the algorithm doesn't fit into the above categories.",
    "PopulationMethod",
    "populationMethod_declaration",
    "if the SBOM document was created by human declaration when it is created.",
    "PopulationMethod",
    "populationMethod_automated",
    "if the SBOM document was created by an automated process when it is created.",
    "PopulationMethod",
    "populationMethod_investigation",
    "if the SBOM document was created by investigating the artifact to retrieve as much information as possible.",
    "PopulationMethod",
    "populationMethod_other",
    "if the population method doesn't fit into the above categories.",
    "AnnotationType",
    "annotationType_review",
    "if the annotation is created when the artifact is reviewed by a third-party software.",
    "AnnotationType",
    "annotationType_comment",
    "if the annotation is created to contain comments.",
    "AnnotationType",
    "annotationType_topic",
    "if the annotation is created to contain topic words to associated with the artifact.",
    "AnnotationType",
    "annotationType_other",
    "if the annotation doesn't fit into the above categories.",
    "ToolType",
    "toolType_compilation",
    "if the tool type is related to compiling.",
    "ToolType",
    "toolType_build",
    "if the tool type is related to building.",
    "ToolType",
    "toolType_packaging",
    "if the tool type is related to packaging.",
    "ToolType",
    "toolType_repository",
    "if the tool type is related to hosting artifacts (sources, packages, ...).",
    "ToolType",
    "toolType_other",
    "if the tool type doesn't fit into the above categories.",
    "RelationshipType",
    "relationshipType_contains",
    "is to be used when the relatedDocument node element contains the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_descendantOf",
    "is to be used when the relatedDocument node element is a descendant of (same lineage but postdates) the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_variantOf",
    "is to be used when the relatedDocument node element is a variant of (same lineage but not clear which came first) the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_copyOf",
    "is to be used when the relatedDocument node element is an exact copy of the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_patchFor",
    "is to be used when the relatedDocument node element is a patch file for (to be applied to) the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_dynamicLink",
    "is to be used when the relatedDocument node element dynamically links to the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_staticLink",
    "is to be used when the relatedDocument node element statically links to the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_hasPrerequisite",
    "is to be used when the relatedDocument node element has as a prerequisite the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_testCaseOf",
    "is to be used when the relatedDocument node element is a test case used in testing the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_buildToolOf",
    "is to be used when the relatedDocument node element is used to build the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_dataFile",
    "is to be used when the relatedDocument node element is a data file used in the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_metaFileOf",
    "is to be used when the relatedDocument node element is a metafile of the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_generatedFrom",
    "is to be used when the relatedDocument node element was generated from the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_expendedFromArchive",
    "is to be used when the relatedDocument node element is expanded from the archive owner of the Relationship.",
    "RelationshipType",
    "relationshipType_documentation",
    "is to be used when the relatedDocument node element provides documentation of the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_optionalComponentOf",
    "is to be used when the relatedDocument node element is an optional component of the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_packageOf",
    "is to be used when the relatedDocument node element is packaged into the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_amendment",
    "is to be used when (current) the node element owner of the Relationship amends the SBOM information in the node element owner of the Relationship.",
    "RelationshipType",
    "relationshipType_comesAfter",
    "is to be used when (current) the node element owner of the Relationship comes after the node element owner of the Relationship (useful for relationships between action node elements).",
    "RelationshipType",
    "relationshipType_other",
    "if the relationship doesn't fit into the above categories."
  ) %>%
    inner_join(enumerations %>% select(-description)) %>%
    mutate(id = paste(sep = "-", id, literal)) %>%
    glimpse()
  
  
  enumerations.literals  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "enumerations.literals.json"),pretty=T,auto_unbox=T)
}


enumerations %>%
  anti_join(enumerations.literals,by=c("name")) %>%
  glimpse()

enumerations.literals %>%
  anti_join(enumerations,by=c("name")) %>%
  glimpse()

# o vis-a-vis SPDX ####

spdx_mapping_comments <- "The following table lists the correspondance between 3T-SBOM-EMS 1.0 model and SPDX 2.1 model:"

if(fromFile) {
  sbom_to_spdx <- 
    fromJSON(txt =  file.path(getwd(), "model", modelFile, "sbom_to_spdx.json")) %>%
    as_tibble()
} else {
  sbom_to_spdx <-tribble(
    ~SBOM, ~SPDX, ~comment,
    "Node","SpdxElement","-",
    "Document","SpdxDocument","-",
    "ComponentItem","SpdxItem","",
    "Artifact","Package","identification aspect of the Package",
    "File","File","-",
    "FileGroup","Package","file organization aspect of the Package",
    "Agent","-","handle as a formated string in SPDX 2.1",
    "Checksum","Checksum","-",
    "Annotation","Annotation","-",
    "LicenseInfo","SpxItem.licenseConcluded","3T-SBOM-EMS capture the licensing information as a node element with its specVersion to qualify the license expression format",
    "PedigreeInfo","-","-",
    "Action","-","-",
    "Argument","-","-",
    "Tool","-","handle as a formated string in SPDX 2.1",
    "Configuration","-","-",
    "Relationship","Relationship","-"
  )
  
  sbom_to_spdx  %>%
    write_json(path=file.path(getwd(), "model", modelFile, "sbom_to_spdx.json"),pretty=T,auto_unbox=T)
}

# VisNetwork ####
colornodes <- brewer.pal(n=8,name="Set3")
coloredges <- brewer.pal(n=8,name="Spectral")

# o exploded ####
if(FALSE) {
  nodes <-
    bind_rows(
      packages %>% select(id, label = name) %>%
        mutate(shape = "database", type = "package"),
      classes %>% select(id, label = name) %>%
        mutate(shape = "box", type = "class"),
      tribble(
        ~ id,
        ~ label,
        ~ shape,
        ~ type,
        "MOF::Element",
        "MOF::Element",
        "box",
        "class"
      ),
      classes.attributes %>% select(id, label = name) %>%
        mutate(shape = "text", type = "attribute"),
      enumerations %>% select(id, label = name) %>%
        mutate(
          shape = "box",
          type = "enumeration",
          label = paste("<<enumeration>>", "\n", label)
        )
    ) %>%
    mutate(color = colornodes[as.integer(as.factor(type))])
  
  edges <-
    bind_rows(
      classes %>%
        select(from = id, name = package) %>%
        inner_join(packages) %>%
        transmute(
          from,
          to = id,
          type = "isClassOf",
          label = ""
        ) %>%
        mutate(
          arrows = "to",
          dashes = T,
          width = 1
        ),
      enumerations %>%
        select(from = id, name = package) %>%
        inner_join(packages) %>%
        transmute(
          from,
          to = id,
          type = "isEnumerationOf",
          label = ""
        ) %>%
        mutate(
          arrows = "to",
          dashes = T,
          width = 1
        ),
      classes %>%
        filter(!is.na(generalization)) %>%
        transmute(
          from = id,
          type = "isGeneralizationOf",
          label = "",
          name = generalization
        ) %>%
        inner_join(classes, by = c("name")) %>%
        select(from, to = id, type, label) %>%
        mutate(
          arrows = "to",
          dashes = F,
          width = 1
        ),
      classes %>%
        filter(is.na(generalization)) %>%
        transmute(
          from = id,
          type = "isGeneralizationOf",
          label = "",
          to = "MOF::Element"
        ) %>%
        mutate(
          arrows = "to",
          dashes = F,
          width = 1
        ),
      classes.attributes %>%
        transmute(
          from = id,
          type = "isAttributeOf",
          label = "",
          name = class
        ) %>%
        inner_join(classes, by = c("name")) %>%
        select(from, to = id, type, label) %>%
        mutate(
          arrows = "none",
          dashes = T,
          width = 1
        ),
      classes.attributes %>%
        filter(!is.na(association)) %>%
        transmute(
          to = type,
          type = aggregation,
          label = paste(paste0("[", multiplicity, "]"), name),
          from = id
        ) %>%
        mutate(
          arrows = "to",
          dashes = F,
          width = 2
        ),
      classes.attributes %>%
        filter(is.na(association)) %>%
        transmute(
          to = type,
          type = "isOfType",
          label = paste(paste0("[", multiplicity, "]"), name),
          from = id
        ) %>%
        filter(!grepl(to, pattern = "^http")) %>%
        mutate(
          arrows = "to",
          dashes = F,
          width = 2
        )
    ) %>%
    mutate(color = coloredges[as.integer(as.factor(type))])
  
  
  
  snodes <- nodes %>% filter(type %in% c("package", "class"))
  sedges <- edges %>% filter(type %in% c("isClassOf"))
  lnodes <- snodes %>% select(label = type, shape, color) %>% unique()
  ledges <-
    sedges %>% select(label = type, arrows, color, dashes, width) %>% unique()
  
  sedges %>% filter(!from %in% snodes$id)
  sedges %>% filter(!to %in% snodes$id)
  
  
  visNetwork(snodes,
             sedges,
             main="3T-SBOM-EMS") %>%
    visIgraphLayout(randomSeed = 1234L,
                    layout = "layout_nicely",
                    type = "full") %>%
    visInteraction(navigationButtons = T) %>%
    visOptions(selectedBy = "label") %>%
    visLegend(useGroups = F,
              addEdges = ledges,
              addNodes = lnodes) %>% print() %>%
    visNodes(shapeProperties = list(borderRadius = 0))
  
  snodes <- nodes %>% filter(type %in% c("class", "attribute"))
  sedges <-
    edges %>% filter(type %in% c("isGeneralizationOf", "isAttributeOf"))
  lnodes <- snodes %>% select(label = type, shape, color) %>% unique()
  ledges <-
    sedges %>% select(label = type, arrows, color, dashes, width) %>% unique()
  
  sedges %>% filter(!from %in% snodes$id)
  sedges %>% filter(!to %in% snodes$id)
  
  
  visNetwork(snodes,
             sedges,
             main="3T-SBOM-EMS") %>%
    visIgraphLayout(randomSeed = 1234L,
                    layout = "layout_nicely",
                    type = "full") %>%
    visInteraction(navigationButtons = T) %>%
    visOptions(selectedBy = "label") %>%
    visLegend(useGroups = F,
              addEdges = ledges,
              addNodes = lnodes) %>% print() %>%
    visNodes(shapeProperties = list(borderRadius = 0))
  
  
  snodes <-
    nodes %>% filter(type %in% c("class", "attribute", "enumeration"))
  sedges <-
    edges %>% filter(type != "isClassOf", type != "isEnumerationOf")
  lnodes <- snodes %>% select(label = type, shape, color) %>% unique()
  ledges <-
    sedges %>% select(label = type, arrows, color, dashes, width) %>% unique()
  
  sedges %>% filter(!from %in% snodes$id)
  sedges %>% filter(!to %in% snodes$id)
  
  
  visNetwork(snodes,
             sedges,
             main="3T-SBOM-EMS") %>%
    visIgraphLayout(randomSeed = 1234L,
                    layout = "layout_nicely",
                    type = "full") %>%
    visInteraction(navigationButtons = T) %>%
    visOptions(selectedBy = "label") %>%
    visLegend(useGroups = F,
              addEdges = ledges,
              addNodes = lnodes) %>% print() %>%
    visNodes(shapeProperties = list(borderRadius = 0))
}



# o condensed ####
if(FALSE){
  
nodes <-
  bind_rows(
    packages %>% select(id,label=name) %>%
      mutate(shape="box",type="package"),
    tribble(~id,~label,~shape,~type,
            "MOF::Element","MOF::Element","box","class"),
    classes %>%
      anti_join(classes.attributes,by=c("name"="class")) %>%
      transmute(id,label=paste0(package,"::",name)) %>%
      mutate(shape="box",type="class"),
    classes.attributes %>% 
      group_by(class,package) %>%
      summarise(label=paste(collapse="\n",sort(unique(paste0("+",name))))) %>%
      ungroup() %>% 
      inner_join(classes,by=c("class"="name","package")) %>%
      transmute(id,label=paste0(package,"::",class,"\n","------","\n",label)) %>%
      mutate(shape="box",type="class"),
    enumerations %>% transmute(id,label=paste0(package,"::",name)) %>%
      mutate(shape="box",type="enumeration",label=paste("<<enumeration>>","\n",label))
  ) %>%
  mutate(color=colornodes[as.integer(as.factor(type))])

edges <-
  bind_rows(
    classes %>% 
      select(from=id,name=package) %>% 
      inner_join(packages) %>% 
      transmute(from,to=id,type="isClassOf",label="")%>%
      mutate(arrows="to",dashes=T,width=1,weight=5),
    enumerations %>% 
      select(from=id,name=package) %>% 
      inner_join(packages) %>% 
      transmute(from,to=id,type="isEnumerationOf",label="")%>%
      mutate(arrows="to",dashes=T,width=1,weight=5),
    classes %>% 
      filter(!is.na(generalization)) %>%
      transmute(from=id,type="isGeneralizationOf",label="",name=generalization) %>%
      inner_join(classes) %>%
      select(from,to=id,type,label)%>%
      mutate(arrows="to",dashes=F,width=1,weight=5),
    classes %>% 
      filter(is.na(generalization)) %>%
      transmute(from=id,type="isGeneralizationOf",label="",to="MOF::Element")%>%
      mutate(arrows="to",dashes=F,width=1,weight=5),
    classes.attributes %>%
      filter(!is.na(association)) %>%
      transmute(to=type,type=aggregation,label=paste(paste0("[",multiplicity,"]"),name),name=class) %>%
      inner_join(classes) %>%
      select(from=id,to,type,label) %>%
      mutate(arrows="to",dashes=F,width=2,weight=1),
    classes.attributes %>%
      filter(is.na(association)) %>%
      transmute(to=type,type="isOfType",label=paste(paste0("[",multiplicity,"]"),name),name=class) %>%
      inner_join(classes) %>%
      select(from=id,to,type,label) %>%
      filter(!grepl(to,pattern = "^http")) %>%
      mutate(arrows="to",dashes=F,width=2,weight=100)
  ) %>%
  mutate(color=coloredges[as.integer(as.factor(type))])


# oo inheritance ####

snodes <- nodes %>% filter(type%in%c("class"))
sedges <- edges %>% filter(type %in% c("isGeneralizationOf"))
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id)
sedges %>% filter(!to%in%snodes$id)


visNetwork(snodes,
           sedges,
           main="3T-SBOM-EMS class inheritance structure") %>%
  visIgraphLayout(randomSeed=1234L,
                  layout="layout_nicely",
                  type = "full") %>%
  visInteraction(navigationButtons = T) %>%
  visOptions(selectedBy = "label") %>%
  visNodes(shapeProperties=list(borderRadius=0))  %>%
  visExport(type="png", name = "export-network", 
            float = "left", label = "Save graph") %>% print()  %>% 
  print()



# oo inheritance and relations with enumerations ####

snodes <- nodes %>% 
  filter(type%in%c("class","enumeration"))
sedges <- edges %>% 
  filter(type!="isClassOf",type!="isEnumerationOf") %>% 
  mutate(smooth.enabled=ifelse(type=="isGeneralizationOf",FALSE,TRUE))
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id)
sedges %>% filter(!to%in%snodes$id)


visNetwork(snodes,
           sedges,
           main="3T-SBOM-EMS") %>%
  visIgraphLayout(randomSeed=1234L,
                  layout="layout_with_fr",
                  type = "full",
                  weights=sedges%>%select(weight)%>%unlist(use.names = F)) %>%
  visInteraction(navigationButtons = T) %>%
  visOptions(selectedBy = "label") %>%
  visNodes(shapeProperties=list(borderRadius=0))  %>%
  visExport(type="png", name = "export-network", 
            float = "left", label = "Save graph") %>% print() 

for(package_id in packages$id){
  sedges <- edges %>%
    filter(grepl(from,pattern = paste0(package_id)) |
             grepl(to,pattern = paste0(package_id))) %>% 
    filter(type!="isClassOf",type!="isEnumerationOf")%>% 
    mutate(smooth.enabled=ifelse(type=="isGeneralizationOf",FALSE,TRUE))
  
  snodes <- sedges %>%
    select(from,to) %>%
    gather(value="id") %>%
    select(-key) %>%
    unique() %>%
    inner_join(nodes,by=c("id")) %>%
    filter(type%in%c("class","attribute","enumeration"))
 
  lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
  ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()
  
  sedges %>% filter(!from%in%snodes$id)%>%
    glimpse()
  sedges %>% filter(!to%in%snodes$id) %>% 
    glimpse()
  
  
  visNetwork(snodes,
             sedges,
             main=package_id) %>%
    visIgraphLayout(randomSeed=1234L,
                    layout="layout_with_fr",
                    type = "full",
                    weights=sedges%>%select(weight)%>%unlist(use.names = F)) %>%
    visInteraction(navigationButtons = T) %>%
    visOptions(selectedBy = "label") %>%
    visNodes(shapeProperties=list(borderRadius=0))  %>%
    visExport(type="png", name = "export-network", 
              float = "left", label = "Save graph") %>% print() 
  
}


# oo inheritance and relations without enumerations ####

snodes <- nodes %>% 
  filter(type%in%c("class"))
sedges <- edges %>% 
  filter(type!="isClassOf",type!="isOfType",type!="isEnumerationOf") %>% 
  mutate(smooth.enabled=ifelse(type=="isGeneralizationOf",FALSE,TRUE))
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id)
sedges %>% filter(!to%in%snodes$id)


visNetwork(snodes,
           sedges,
           main="3T-SBOM-EMS") %>%
  visIgraphLayout(randomSeed=1234L,
                  layout="layout_with_fr",
                  type = "full",
                  weights=sedges%>%select(weight)%>%unlist(use.names = F)) %>%
  visInteraction(navigationButtons = T) %>%
  visOptions(selectedBy = "label") %>%
  visNodes(shapeProperties=list(borderRadius=0))  %>%
  visExport(type="png", name = "export-network", 
            float = "left", label = "Save graph") %>% print() 


for(package_id in packages$id){
  sedges <- edges %>%
    filter(grepl(from,pattern = paste0(package_id)) |
             grepl(to,pattern = paste0(package_id))) %>% 
    filter(type!="isClassOf",type!="isEnumerationOf")%>% 
    mutate(smooth.enabled=ifelse(type=="isGeneralizationOf",FALSE,TRUE))
  
  snodes <- sedges %>%
    select(from,to) %>%
    gather(value="id") %>%
    select(-key) %>%
    unique() %>%
    inner_join(nodes,by=c("id")) %>%
    filter(type%in%c("class","attribute","enumeration")) %>%
    mutate(color=ifelse(grepl(id,pattern = paste0(package_id)),color,"lightgrey"))
  
  lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
  ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()
  
  sedges %>% filter(!from%in%snodes$id)%>%
    glimpse()
  sedges %>% filter(!to%in%snodes$id) %>% 
    glimpse()
  
  
  visNetwork(snodes,
             sedges,
             main=package_id) %>%
    visIgraphLayout(randomSeed=1234L,
                    layout="layout_with_fr",
                    type = "full",
                    weights=sedges%>%select(weight)%>%unlist(use.names = F)) %>%
    visInteraction(navigationButtons = T) %>%
    visOptions(selectedBy = "label") %>%
    visNodes(shapeProperties=list(borderRadius=0))  %>%
    visExport(type="png", name = "export-network", 
              float = "left", label = "Save graph") %>% print() 
  
}
}

# o condensed without association as attributes ####

nodes <-
  bind_rows(
    packages %>% select(id,label=name) %>%
      mutate(shape="box",type="package"),
    tribble(~id,~label,~shape,~type,
            "MOF::Element","MOF::Element","box","class"),
    classes %>%
      anti_join(classes.attributes %>% 
                  filter(!grepl(type,pattern = "^3T")),by=c("name"="class")) %>%
      transmute(id,label=paste0(package,"::",name)) %>%
      mutate(shape="box",type="class"),
    classes.attributes %>% 
      filter(!grepl(type,pattern = "^3T")) %>%
      group_by(class,package) %>%
      summarise(label=paste(collapse="\n",sort(unique(paste0("+",name))))) %>%
      ungroup() %>% 
      inner_join(classes,by=c("class"="name","package")) %>%
      transmute(id,label=paste0(package,"::",class,"\n","------","\n",label)) %>%
      mutate(shape="box",type="class"),
    enumerations %>% transmute(id,label=paste0(package,"::",name)) %>%
      mutate(shape="box",type="enumeration",label=paste("<<enumeration>>","\n",label))
  ) %>%
  unique() %>%
  mutate(color=colornodes[as.integer(as.factor(type))])

edges <-
  bind_rows(
    classes %>% 
      select(from=id,name=package) %>% 
      inner_join(packages) %>% 
      transmute(from,to=id,type="isClassOf",label="")%>%
      mutate(arrows="to",dashes=T,width=1,weight=5),
    enumerations %>% 
      select(from=id,name=package) %>% 
      inner_join(packages) %>% 
      transmute(from,to=id,type="isEnumerationOf",label="")%>%
      mutate(arrows="to",dashes=T,width=1,weight=5),
    classes %>% 
      filter(!is.na(generalization)) %>%
      transmute(from=id,type="isGeneralizationOf",label="",name=generalization) %>%
      inner_join(classes) %>%
      select(from,to=id,type,label)%>%
      mutate(arrows="to",dashes=F,width=1,weight=5),
    classes %>% 
      filter(is.na(generalization)) %>%
      transmute(from=id,type="isGeneralizationOf",label="",to="MOF::Element")%>%
      mutate(arrows="to",dashes=F,width=1,weight=5),
    classes.attributes %>%
      filter(!is.na(association)) %>%
      transmute(to=type,type=aggregation,label=paste(paste0("[",multiplicity,"]"),name),name=class) %>%
      inner_join(classes) %>%
      select(from=id,to,type,label) %>%
      mutate(arrows="to",dashes=F,width=2,weight=1),
    classes.attributes %>%
      filter(is.na(association)) %>%
      transmute(to=type,type="isOfType",label=paste(paste0("[",multiplicity,"]"),name),name=class) %>%
      inner_join(classes) %>%
      select(from=id,to,type,label) %>%
      filter(!grepl(to,pattern = "^http")) %>%
      mutate(arrows="to",dashes=F,width=2,weight=100)
  ) %>%
  mutate(color=coloredges[as.integer(as.factor(type))])

# oo inheritance ####

snodes <- nodes %>% filter(type%in%c("class"))
sedges <- edges %>% filter(type %in% c("isGeneralizationOf"))
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id)
sedges %>% filter(!to%in%snodes$id)


visNetwork(snodes,
           sedges,
           main="3T-SBOM-EMS class inheritance structure") %>%
  visIgraphLayout(randomSeed=1234L,
                  layout="layout_nicely",
                  type = "full") %>%
  visInteraction(navigationButtons = T) %>%
  visOptions(selectedBy = "label") %>%
  visNodes(shapeProperties=list(borderRadius=0))  %>%
  visExport(type="png", name = "export-network", 
            float = "left", label = "Save graph") %>% print()  %>% 
  print()


# oo inheritance and relations with enumerations ####

snodes <- nodes %>% 
  filter(type%in%c("class","enumeration"))
sedges <- edges %>% 
  filter(type!="isClassOf",type!="isEnumerationOf") %>% 
  mutate(smooth.enabled=ifelse(type=="isGeneralizationOf",FALSE,TRUE))
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id) %>% select(from,to,type,label)
sedges %>% filter(!to%in%snodes$id) %>% select(from,to,type,label)


visNetwork(snodes,
           sedges,
           main="3T-SBOM-EMS") %>%
  visIgraphLayout(randomSeed=1234L,
                  layout="layout_with_fr",
                  type = "full",
                  weights=sedges%>%select(weight)%>%unlist(use.names = F)) %>%
  visInteraction(navigationButtons = T) %>%
  visOptions(selectedBy = "label") %>%
  visNodes(shapeProperties=list(borderRadius=0))  %>%
  visExport(type="png", name = "export-network", 
            float = "left", label = "Save graph") %>% print() 


for(package_id in packages$id){
  sedges <- edges %>%
    filter(grepl(from,pattern = paste0(package_id)) |
             grepl(to,pattern = paste0(package_id))) %>% 
    filter(type!="isClassOf",type!="isEnumerationOf")%>% 
    mutate(smooth.enabled=ifelse(type=="isGeneralizationOf",FALSE,TRUE))
  
  snodes <- sedges %>%
    select(from,to) %>%
    gather(value="id") %>%
    select(-key) %>%
    unique() %>%
    inner_join(nodes,by=c("id")) %>%
    filter(type%in%c("class","attribute","enumeration")) %>%
    mutate(color=ifelse(grepl(id,pattern = paste0(package_id)),color,"lightgrey"))
  
  lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
  ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()
  
  sedges %>% filter(!from%in%snodes$id)%>%
    glimpse()
  sedges %>% filter(!to%in%snodes$id) %>% 
    glimpse()
  
  
  visNetwork(snodes,
             sedges,
             main=package_id) %>%
    visIgraphLayout(randomSeed=1234L,
                    layout="layout_with_fr",
                    type = "full",
                    weights=sedges%>%select(weight)%>%unlist(use.names = F)) %>%
    visInteraction(navigationButtons = T) %>%
    visOptions(selectedBy = "label") %>%
    visNodes(shapeProperties=list(borderRadius=0))  %>%
    visExport(type="png", name = "export-network", 
              float = "left", label = "Save graph") %>% print() 
  
}


# GGRAPH ####

# o condensed ####

nodes <-
  bind_rows(
    packages %>% select(id,label=name) %>%
      mutate(shape="box",type="package"),
    tribble(~id,~label,~shape,~type,
            "MOF::Element","MOF::Element","box","class"),
    classes %>%
      anti_join(classes.attributes,by=c("name"="class")) %>%
      transmute(id,label=paste0(package,"::",name)) %>%
      mutate(shape="box",type="class"),
    classes.attributes %>% 
      group_by(class,package) %>%
      summarise(label=paste(collapse="\n",sort(unique(paste0("+",name))))) %>%
      ungroup() %>% 
      inner_join(classes,by=c("class"="name","package")) %>%
      transmute(id,label=paste0(package,"::",class,"\n","----------","\n",label)) %>%
      mutate(shape="box",type="class"),
    enumerations %>% transmute(id,label=paste0(package,"::",name)) %>%
      mutate(shape="box",type="enumeration",label=paste("<<enumeration>>","\n",label))
  ) %>%
  mutate(color=colornodes[as.integer(as.factor(type))])

edges <-
  bind_rows(
    classes %>% 
      select(from=id,name=package) %>% 
      inner_join(packages) %>% 
      transmute(from,to=id,type="isClassOf",label="")%>%
      mutate(arrows="to",dashes=T,width=1,weight=5),
    enumerations %>% 
      select(from=id,name=package) %>% 
      inner_join(packages) %>% 
      transmute(from,to=id,type="isEnumerationOf",label="")%>%
      mutate(arrows="to",dashes=T,width=1,weight=5),
    classes %>% 
      filter(!is.na(generalization)) %>%
      transmute(from=id,type="isGeneralizationOf",label="",name=generalization) %>%
      inner_join(classes) %>%
      select(from,to=id,type,label)%>%
      mutate(arrows="to",dashes=F,width=1,weight=5),
    classes %>% 
      filter(is.na(generalization)) %>%
      transmute(from=id,type="isGeneralizationOf",label="",to="MOF::Element")%>%
      mutate(arrows="to",dashes=F,width=1,weight=5),
    classes.attributes %>%
      filter(!is.na(association)) %>%
      transmute(to=type,type=aggregation,label=paste(paste0("[",multiplicity,"]"),name),name=class) %>%
      inner_join(classes) %>%
      select(from=id,to,type,label) %>%
      mutate(arrows="to",dashes=F,width=2,weight=1),
    classes.attributes %>%
      filter(is.na(association)) %>%
      transmute(to=type,type="isOfType",label=paste(paste0("[",multiplicity,"]"),name),name=class) %>%
      inner_join(classes) %>%
      select(from=id,to,type,label) %>%
      filter(!grepl(to,pattern = "^http")) %>%
      mutate(arrows="to",dashes=F,width=2,weight=100)
  ) %>%
  mutate(color=coloredges[as.integer(as.factor(type))])



snodes <- nodes %>% filter(type%in%c("class","attribute"))
sedges <- edges %>% filter(type %in% c("isGeneralizationOf","isAttributeOf"))
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id)
sedges %>% filter(!to%in%snodes$id)


sedges %>%
  as_tbl_graph() %>%
  activate(nodes) %>%
  left_join(snodes, by = c(name = "id")) %>%
  ggraph(layout = "with_fr") +
  geom_node_label(aes(label = label)) +
  geom_edge_link(
    aes(
      start_cap = label_rect(node1.label),
      end_cap = label_rect(node2.label)
    ),
    arrow = arrow(length = unit(4, "mm"))
  ) +
  theme_graph(fg_text_colour = 'white')

snodes <- nodes %>% filter(type%in%c("class","attribute","enumeration"))
sedges <- edges %>% filter(type!="isClassOf",type!="isEnumerationOf")
lnodes <- snodes %>% select(label=type,shape,color) %>% unique()
ledges <- sedges %>% select(label=type,arrows,color,dashes,width) %>% unique()

sedges %>% filter(!from%in%snodes$id)
sedges %>% filter(!to%in%snodes$id)

sedges %>%
  as_tbl_graph() %>%
  activate(nodes) %>%
  left_join(snodes, by = c(name = "id")) %>%
  ggraph(layout = "with_fr") +
  geom_node_label(aes(label = label)) +
  geom_edge_link(
    aes(
      start_cap = label_rect(node1.label),
      end_cap = label_rect(node2.label)
    ),
    arrow = arrow(length = unit(4, "mm"))
  ) +
  theme_graph(fg_text_colour = 'white')




# XMI ####

xml <- NULL


# root node ####
# e.g. <xmi:XMI xmlns:uml="http://www.omg.org/spec/UML/20131001" xmlns:StandardProfile="http://www.omg.org/spec/UML/20131001/StandardProfile" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:mofext="http://www.omg.org/spec/MOF/20131001">
xml <- xmlTree(
  "xmi:XMI",
  namespaces = list(
    xmi = "http://www.omg.org/spec/XMI/20131001",
    uml = "http://www.omg.org/spec/UML/20161101",
    mofext = "http://www.omg.org/spec/MOF/20131001",
    ocl = "http://www.omg.org/spec/OCL/20090501"
  )
)



# main package ####
xml$addNode(
  "uml:Package",
  attrs = c(
    "xmi:id" = "3T-SBOM-EMS",
    "xmi:type" = "uml:Package",
    name = "Tool-to-Tool Software Bill of Material Exchange Metamodel Standard",
    URI = "http://www.omg.org/spec/3T-SBOM-EMS/20yymmdd/"
  ),
  close = FALSE
)




lapply(classes %>% select(package) %>% unique() %>% unlist(use.names = F), function(package_name) {
  # o definitions package ####
  
  xml$addNode(
    "packagedElement",
    attrs = c(
      "xmi:id" = packages %>% filter(name == package_name) %>% select("id") %>% as.character(),
      "xmi:type" = "uml:Package",
      name = packages %>% filter(name == package_name) %>% select("name") %>% as.character()
    ),
    close = FALSE
  )
  
  # oo Definitions enumeration ####
  
  lapply(enumerations %>% filter(package == package_name) %>% select(id) %>% unlist(use.names = F), function(enumeration_id) {
    xml$addNode(
      "packagedElement",
      attrs = c(
        "xmi:id" = enumerations %>% filter(id == enumeration_id) %>% select(id) %>% as.character(),
        "xmi:type" = "uml:Enumeration",
        name = enumerations %>% filter(id == enumeration_id) %>% select(name) %>% as.character()
      ),
      close = FALSE
    )
    # ooo literals ####
    if (enumerations.literals %>% filter(
      name == enumerations %>% filter(id == enumeration_id) %>% select(name) %>% as.character()
    )  %>% nrow() >
    0) {
      lapply(enumerations.literals %>% filter(
        name == enumerations %>% filter(id == enumeration_id) %>% select(name) %>% as.character()
      ) %>% select(id) %>% unlist(use.names = F), function(literal_id) {
        xml$addNode(
          "ownedLiteral",
          attrs = c(
            "xmi:id" = enumerations.literals %>% filter(id == literal_id) %>% select(id) %>% as.character(),
            "xmi:type" = "uml:EnumerationLiteral",
            visibility = "public",
            name = enumerations.literals %>% filter(id == literal_id) %>% select(name) %>% as.character()
          ),
          close = TRUE
        )
        
      })
    }
    # oo close enumeration ####
    xml$closeTag()
    
  })
  
  # oo Definitions association ####
  # e.g. <packagedElement xmi:type="uml:Association" xmi:id="SPMS-Definitions-PatternDefinition.sections" name="sections">
  #        <memberEnd xmi:idref="SPMS-Definitions-PatternDefinition-sections"/>
  #        <memberEnd xmi:idref="SPMS-Definitions-PatternDefinition.sections-def"/>
  #        <ownedEnd xmi:type="uml:Property" xmi:id="SPMS-Definitions-PatternDefinition.sections-def" name="def" visibility="public" type="SPMS-Definitions-PatternDefinition" association="SPMS-Definitions-PatternDefinition.sections"/>
  #      </packagedElement>
  
  lapply(classes.attributes %>% filter(
    package == package_name) %>% filter(!is.na(aggregation)) %>% select(association) %>% unlist(use.names = F), function(association_id) {
    xml$addNode(
      "packagedElement",
      attrs = c(
        "xmi:id" = association_id,
        "xmi:type" = "uml:Association",
        name = classes.attributes %>% filter(association == association_id) %>% select(name) %>% as.character()
      ),
      close = FALSE
    )
    # ooo ends ####
      xml$addNode(
        "memberEnd",
        attrs = c(
          "xmi:idref" = classes.attributes %>% filter(association == association_id) %>% select(id) %>% as.character()
        ),
        close = TRUE
      )
      xml$addNode(
        "memberEnd",
        attrs = c(
          "xmi:idref" = paste(classes.attributes %>% filter(association == association_id) %>% select(id) %>% as.character(),
                              classes.attributes %>% filter(association == association_id) %>% select(reverseName) %>% as.character(),
                              sep="-")
        ),
        close = TRUE
      )
      xml$addNode(
        "ownedEnd",
        attrs = c(
          "xmi:type" = "uml:Property",
          "xmi:id" = paste(classes.attributes %>% filter(association == association_id) %>% select(id) %>% as.character(),
                           classes.attributes %>% filter(association == association_id) %>% select(reverseName) %>% as.character(),
                           sep="-"),
          name=classes.attributes %>% filter(association == association_id) %>% select(reverseName) %>% as.character(),
          visibility="public",
          type = classes.attributes %>% filter(association == association_id) %>% select(type) %>% as.character(),
          association = association_id
        ),
        close = TRUE
      )
        
      
    
    # oo close association ####
    xml$closeTag()
    
  })
  
  # oo Definitions classes ####
  # e.g. <packagedElement xmi:type="uml:Class" xmi:id="SPMS-Definitions-PatternElement" name="PatternElement">
  
  lapply(classes %>% filter(package == package_name) %>% select(id) %>% unlist(use.names = F), function(class_id) {
    xml$addNode(
      "packagedElement",
      attrs = c(
        "xmi:id" = classes %>% filter(id == class_id) %>% select(id) %>% as.character(),
        "xmi:type" = "uml:Class",
        name = classes %>% filter(id == class_id) %>% select(name) %>% as.character()
      ),
      close = FALSE
    )
    # ooo generalisation ####
    # special case <packagedElement xmi:type="uml:Class" xmi:id="SPMS-Definitions-PatternElement" name="PatternElement">
    # <generalization xmi:type="uml:Generalization" xmi:id="SPMS-Definitions-PatternElement.generalization0">
    #   <general href="http://www.omg.org/spec/UML/20131001/UML.xmi#Element"/>
    #   </generalization>
    # e.g <generalization xmi:type="uml:Generalization" xmi:id="SPMS-Definitions-PatternDefinition.generalization0" general="SPMS-Definitions-PatternElement"/>
    if (classes %>% filter(id == class_id) %>% select(generalization) %>% is.na()) {
      xml$addNode(
        "generalization",
        attrs = c(
          "xmi:id" = paste(
            classes %>% filter(id == class_id) %>% select(id) %>% as.character(),
            "generalization",
            sep = "."
          ),
          "xmi:type" = "uml:Generalization"
        ),
        close = FALSE
      )
      xml$addNode(
        "general",
        attrs = c(href = "http://www.omg.org/spec/UML/20131001/UML.xmi#Element"),
        close = TRUE
        
      )
      xml$closeTag()
      
    } else {
      xml$addNode(
        "generalization",
        attrs = c(
          "xmi:id" = paste(
            classes %>% filter(id == class_id) %>% select(id) %>% as.character(),
            "generalization",
            sep = "."
          ),
          "xmi:type" = "uml:Generalization",
          general = classes %>% 
            filter(id == class_id) %>% 
            select(generalization) %>% 
            inner_join(classes %>% select(id, name),
                       by = c("generalization" = "name")) %>% 
            select(id) %>% as.character()
          
        ),
        close = TRUE
        
      )
    }  
    
    # ooo simple attibutes ####
    # e.g. <ownedAttribute xmi:type="uml:Property" xmi:id="SPMS-Relationships-Nature-name" name="name" visibility="public">
    # <type href="http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String"/>
    #   </ownedAttribute>
    if (classes.attributes %>% filter(class == classes %>% filter(id == class_id) %>% select(name) %>% as.character()) %>% filter(is.na(aggregation)) %>% nrow() >
        0) {
      lapply(classes.attributes %>% filter(
        class == classes %>% filter(id == class_id) %>% select(name) %>% as.character()
      ) %>% filter(is.na(aggregation)) %>% select(id) %>% unlist(use.names = F), function(attribute_id) {
        xml$addNode(
          "ownedAttribute",
          attrs = c(
            "xmi:id" = classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
            "xmi:type" = "uml:Property",
            visibility = "public",
            name = classes.attributes %>% filter(id == attribute_id) %>% select(name) %>% as.character()
          ),
          close = FALSE
        )
        xml$addNode(
          "type",
          attrs = c(
            href = classes.attributes %>% filter(id == attribute_id) %>% select(type) %>% as.character()
          ),
          close = TRUE
        )
        
        # oooo constraints ####
        # e.g. <ownedRule xmi:id="AAAAAAFttjETZcBYZeU=" name="documentReference" visibility="public" xmi:type="uml:Constraint">
        # <constrainedElement xmi:idref="AAAAAAFttf4n4QAOiwA="/>
        #   <specification xmi:id="AAAAAAFttj14AM3SUKA=" xmi:type="uml:OpaqueExpression" comment="relatedDocument%3C-exists(Document.name=relatedDocument)"/>
        #   </ownedRule>
        
        if(classes.attributes.constraints %>% filter(id == attribute_id) %>% nrow()>0) {
          xml$addNode(
              "ownedRule",
              attrs = c(
                "xmi:id" = paste(attribute_id,"constraint",sep = "."),
                "xmi:type" = "uml:Constraint",
                visibility = "public",
                name = classes.attributes.constraints %>% filter(id == attribute_id) %>% select(name) %>% as.character()
              ),
              close = FALSE
            )
          xml$addNode(
            "constrainedElement",
            attrs = c("xmi:idref" = attribute_id),
            close = TRUE
          )
          xml$addNode(
            "specification",
            attrs = c(
              "xmi:id" = paste(attribute_id, "constraint", "ocl", sep = "."),
              "xmi:type" = "uml:OpaqueExpression"
            ),
            close = FALSE
          )
          # ooooo specification of constraint ####
          xml$addNode(
            "language" , 
            "OCL",
            close=TRUE)
          xml$addNode(
            "comment" ,
            classes.attributes.constraints %>% filter(id == attribute_id) %>% select(constraint) %>% as.character(),
            close = TRUE
          )
          # ooooo close specification ####
          xml$closeTag()
          
          # oooo close constraint ####
          xml$closeTag()
        }
        
        # ooo close simple attribute ####
        xml$closeTag()
        
      })
    }
    
    
    # ooo association attributes  ####
    # e.g. <ownedAttribute xmi:type="uml:Property" xmi:id="SPMS-Definitions-PatternElement-definitions" name="definitions" visibility="public" aggregation="composite" type="SPMS-Formalisms-FormalizedDefinition" association="SPMS-Definitions-PatternDefinition.definitions">
    # <lowerValue xmi:type="uml:LiteralInteger" xmi:id="SPMS-Definitions-PatternElement-definitions.lowerValue"/>
    #   <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="SPMS-Definitions-PatternElement-definitions.upperValue" value="*"/>
    #     </ownedAttribute>
    
    if (classes.attributes %>% filter(class == classes %>% filter(id == class_id) %>% select(name) %>% as.character()) %>% filter(!is.na(aggregation)) %>% nrow() >
        0) {
      lapply(classes.attributes %>% filter(
        class == classes %>% filter(id == class_id) %>% select(name) %>% as.character()
      ) %>% filter(!is.na(aggregation)) %>% select(id) %>% unlist(use.names = F), function(attribute_id) {
        xml$addNode(
          "ownedAttribute",
          attrs = c(
            "xmi:id" = classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
            "xmi:type" = "uml:Property",
            visibility = "public",
            name = classes.attributes %>% filter(id == attribute_id) %>% select(name) %>% as.character(),
            aggregation = classes.attributes %>% filter(id == attribute_id) %>% select(aggregation) %>% as.character(),
            type = classes.attributes %>% filter(id == attribute_id) %>% select(type) %>% as.character(),
            association = classes.attributes %>% filter(id == attribute_id) %>% select(association) %>% as.character()
          ),
          close = FALSE
        )
        if (classes.attributes %>% filter(id == attribute_id) %>% select(multiplicity) %>% as.character() ==
            "1") {
          xml$addNode(
            "lowerValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".lowerValue"
              ),
              "xmi:type" = "uml:LiteralInteger",
              value = "1"
            ),
            close = TRUE
          )
          xml$addNode(
            "upperValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".upperValue"
              ),
              "xmi:type" = "uml:LiteralInteger",
              value = "1"
            ),
            close = TRUE
          )
        } else if (classes.attributes %>% filter(id == attribute_id) %>% select(multiplicity) %>% as.character() ==
                   "*") {
          xml$addNode(
            "lowerValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".lowerValue"
              ),
              "xmi:type" = "uml:LiteralInteger",
              value = "0"
            ),
            close = TRUE
          )
          xml$addNode(
            "upperValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".upperValue"
              ),
              "xmi:type" = "uml:LiteralUnlimitedNatural",
              value = "*"
            ),
            close = TRUE
          )
          
        } else if (classes.attributes %>% filter(id == attribute_id) %>% select(multiplicity) %>% as.character() ==
                   "1..*") {
          xml$addNode(
            "lowerValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".lowerValue"
              ),
              "xmi:type" = "uml:LiteralInteger",
              value = "1"
            ),
            close = TRUE
          )
          xml$addNode(
            "upperValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".upperValue"
              ),
              "xmi:type" = "uml:LiteralUnlimitedNatural",
              value = "*"
            ),
            close = TRUE
          )
        } else if (classes.attributes %>% filter(id == attribute_id) %>% select(multiplicity) %>% as.character() ==
                   "0..1") {
          xml$addNode(
            "lowerValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".lowerValue"
              ),
              "xmi:type" = "uml:LiteralInteger",
              value = "0"
            ),
            close = TRUE
          )
          xml$addNode(
            "upperValue",
            attrs = c(
              "xmi:id" = paste0(
                classes.attributes %>% filter(id == attribute_id) %>% select(id) %>% as.character(),
                ".upperValue"
              ),
              "xmi:type" = "uml:LiteralInteger",
              value = "1"
            ),
            close = TRUE
          )
        }
        
        # oooo constraints ####
        # e.g. <ownedRule xmi:id="AAAAAAFttjETZcBYZeU=" name="documentReference" visibility="public" xmi:type="uml:Constraint">
        # <constrainedElement xmi:idref="AAAAAAFttf4n4QAOiwA="/>
        #   <specification xmi:id="AAAAAAFttj14AM3SUKA=" xmi:type="uml:OpaqueExpression" comment="relatedDocument%3C-exists(Document.name=relatedDocument)"/>
        #   </ownedRule>
        
        if(classes.attributes.constraints %>% filter(id == attribute_id) %>% nrow()>0) {
          xml$addNode(
            "ownedRule",
            attrs = c(
              "xmi:id" = paste(attribute_id,"constraint",sep = "."),
              "xmi:type" = "uml:Constraint",
              visibility = "public",
              name = classes.attributes.constraints %>% filter(id == attribute_id) %>% select(name) %>% as.character()
            ),
            close = FALSE
          )
          xml$addNode(
            "constrainedElement",
            attrs = c("xmi:idref" = attribute_id),
            close = TRUE
          )
          xml$addNode(
            "specification",
            attrs = c(
              "xmi:id" = paste(attribute_id, "constraint", "ocl", sep = "."),
              "xmi:type" = "uml:OpaqueExpression"
            ),
            close = FALSE
          )
          # ooooo specification of constraint ####
          xml$addNode(
            "language" , 
            "OCL",
            close=TRUE)
          xml$addNode(
            "comment" ,
            classes.attributes.constraints %>% filter(id == attribute_id) %>% select(constraint) %>% as.character(),
            close = TRUE
          )
          # ooooo close specification ####
          xml$closeTag()
          # oooo close constraint ####
          xml$closeTag()
        }
        
        # ooo close association attribute ####
        xml$closeTag()
        
      })
    }
    
    
    # oo close class ####
    
    xml$closeTag()
  })
  
  
  
  # o close definitions package ####
  xml$closeTag()
  
})



# end main package ####
xml$closeTag()

# o mofext tag ####
# e.g. <mofext:Tag xmi:type="mofext:Tag" xmi:id="_1" name="org.omg.xmi.nsPrefix" value="spms" element="_0"/>

xml$addNode(
  "mofext:Tag",
  attrs = c(
    "xmi:id" = "3T-SBOM-EMS-tag",
    "xmi:type" = "mofext:Tag",
    name = "org.omg.xmi.nsPrefix",
    value = "sbom",
    element = "3T-SBOM-EMS"
  ),
  close = TRUE
)

# finalize XMI file ####
write(saveXML(xml), file = outXmiFile)




# DOCX ####

ordered_lst_packages<-package_intro%>% select(package) %>% unique() %>% unlist(use.names = F)


docx <- read_docx("sbom_template.docx")

docx %>% styles_info() %>% as_tibble() %>% filter(style_type=="paragraph" & is_custom == TRUE) %>% arrange(style_type) %>% print()

docx <- docx %>%
  body_add_par("References", style =
                 "sbomTitle")  %>%
  body_add_par("Normative References", style =
                 "sbomClause") 
docx <- docx %>%
  body_add_par("The following normative documents contain provisions, which, through reference in this text, constitute provisions of
this specification. For dated references, subsequent amendments to, or revisions of any of these publications do not
apply.", style = "sbomNormal")
docx <- docx %>%
  body_add_par("OMG Unified Modeling Language (OMG UML), Version 2.5.1, formal/17-12-05", style = "sbomList") %>%
  body_add_par("OMG Meta Object Facility, version 2.5.1 (MOF), formal/19-10-01", style = "sbomList") %>%
  body_add_par("OMG XML Metadata Interchange, version 2.5.1 (XMI), formal/15-06-07", style = "sbomList") %>%
  body_add_par("OMG Object Constraint Language, version 2.4 (OCL), formal/14-02-03", style = "sbomList")


docx <- docx  %>%
  body_add_par("Additional Information", style =
                 "sbomTitle") %>%
  body_add_par("How to Proceed", style =
                 "sbomClause")  %>%
  body_add_par(
    package_list_intro
  )  %>%
  body_add_par(
    paste("Clause 7.",
          background_intro),
    style = "sbomList"
  ) 

iClause <- 7
lapply(ordered_lst_packages, function(package_name) {
  iClause <- iClause +1
  docx <- docx %>%
    body_add_par(
      paste(paste0("Clause ",iClause,"."),
            packages %>% filter(name==package_name) %>% select(description) %>% as.character()),
      style = "sbomList"
    ) 
  
})


# docx <- docx %>%
#   body_add_par("3T-SBOM-EMS Model (Normative)", style =
#                  "sbomTitle") 


docx <- docx %>%
  body_add_par("Background of the model elements", style = "sbomTitle") 
lapply(model_intro,function(item){
  docx <- docx %>%
    body_add_par(item, style="sbomNormal")
})


lapply(ordered_lst_packages,function(package_name){
  docx <- docx %>%
    body_add_break() %>%
    body_add_par(paste(package_name,"Classes"), style = "sbomTitle")
  
  docx <- docx %>%
    body_add_par(package_intro %>% filter(package==package_name) %>% select(intro) %>% as.character(), style = "sbomNormal")
  
  lapply(classes %>% filter(package==package_name) %>% select(name) %>% unlist(use.names = F),function(class_name){
    docx <- docx %>%
      body_add_par(classes %>% filter(name==class_name) %>% transmute(text=paste(name,"Class")) %>% unlist(use.names = F), style = "sbomClause")
    docx <- docx %>%
      body_add_par(classes %>% filter(name==class_name) %>% transmute(text=description) %>% unlist(use.names = F), style = "sbomNormal")
    table_data <- classes %>% 
      filter(name==class_name) %>% 
      select(compositionDescription) %>% 
      unlist(use.names = F)
    if(!table_data%>% is.null()) {
      lapply(table_data, function(description_item) {
        docx <- docx %>%
          body_add_par(
            description_item,
            style = "sbomList"
          )
      })
    }
    
    
    docx <- docx %>%
      body_add_par("SuperClass",style="sbomSubSubClause")
    docx <- docx %>%
      body_add_par(classes %>% filter(name==class_name) %>% transmute(text=ifelse(is.na(generalization),"MOF::Element",generalization)) %>% unlist(use.names = F), style = "sbomNormal")
    
    table_data <- classes.parents %>% 
      filter(class==class_name) %>% 
      select(parent_class) %>%
      inner_join(classes.attributes,by=c("parent_class"="class")) %>%
      filter(is.na(aggregation)) %>%
      transmute(text = paste(
        name,
        ":",
        gsub(
          gsub(
            type,
            pattern = "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#",
            fixed = T,
            replacement = ""
          ),
          pattern = paste0("3T-SBOM-EMS-",package_name,"-"),
          fixed = T,
          replacement = ""
        ),
        paste0("[",
               multiplicity,
               "]")
      ), description, parent_class) %>%
      rename(`Attribute name:type[cardinality]`=text,`Description`=description,`Parent Class name`=parent_class)
    if(table_data%>% nrow()>0) {
      docx <- docx %>%
        body_add_par("Attributes (inherited)",style="sbomSubSubClause") %>%
        body_add_par("The following table lists the inherited attributes and the parent class the attributes are inherited from:","sbomNormal")
      docx <- docx %>%
        body_add_table(header=T, first_row = T,
                       style = "sbomTable",
                       value =  table_data)
    }
    
    
    
    table_data <- classes.attributes %>%
      filter(class == class_name, is.na(aggregation)) %>%
      transmute(text = paste(
        name,
        ":",
        gsub(
          gsub(
            type,
            pattern = "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#",
            fixed = T,
            replacement = ""
          ),
          pattern = paste0("3T-SBOM-EMS-",package_name,"-"),
          fixed = T,
          replacement = ""
        ),
        paste0("[",
               multiplicity,
               "]")
      ), description) %>%
      rename(`Attribute name:type[cardinality]`=text,`Description`=description)
    if(table_data%>% nrow()>0) {
      docx <- docx %>%
        body_add_par("Attributes",style="sbomSubSubClause") %>%
        body_add_par("The following table lists the class own attributes:","sbomNormal")
      docx <- docx %>%
        body_add_table(header=T, first_row = T,
                       style = "sbomTable",
                       value =  table_data)
  
      
    }
    
    table_data <- classes.attributes.constraints %>% 
      filter(class==class_name) %>% 
      transmute(attribute, description) %>%
      rename(`Attribute name`=attribute,`Description`=description)
    if(table_data%>% nrow()>0) {
      docx <- docx %>%
        body_add_par("Constraints",style="sbomSubSubClause") %>%
        body_add_par("The following table lists the constraints that exist on class attributes:","sbomNormal")
      docx <- docx %>%
        body_add_table(header=T, first_row = T,
                       style = "sbomTable",
                       table_data )
    }
    
    table_data <- classes.attributes %>%
      filter(class == class_name,
             !is.na(aggregation),
             grepl(multiplicity, pattern = "^1")) %>%
      transmute(text = paste(
        name,
        ":",
        gsub(
          type,
          pattern = paste0("3T-SBOM-EMS-",package_name,"-"),
          fixed = T,
          replacement = ""
        ),
        paste0("[",
               multiplicity,
               "]")
      ), description,reverseName) %>%
      rename(`Association name:type[cardinality]`=text,`Description`=description,`Reverse association name`=reverseName)
    if(table_data%>% nrow()>0) {
      docx <- docx %>%
        body_add_par("Associations (required)",style="sbomSubSubClause") %>%
        body_add_par("The following table lists the class required associations:","sbomNormal")
      docx <- docx %>%
        body_add_table(header=T, first_row = T,
                       style = "sbomTable",
                       table_data )
      
      
    }
    
    table_data <- classes.attributes %>%
      filter(class == class_name,
             !is.na(aggregation),
             !grepl(multiplicity, pattern = "^1")) %>%
      transmute(text = paste(
        name,
        ":",
        gsub(
          type,
          pattern = paste0("3T-SBOM-EMS-",package_name,"-"),
          fixed = T,
          replacement = ""
        ),
        paste0("[",
               multiplicity,
               "]")
      ), description,reverseName) %>%
      rename(`Association name:type[cardinality]`=text,`Description`=description,`Reverse association name`=reverseName)
    if(table_data%>% nrow()>0) {
      docx <- docx %>%
        body_add_par("Associations (optional)",style="sbomSubSubClause") %>%
        body_add_par("The following table lists the class optional associations:","sbomNormal")
      docx <- docx %>%
        body_add_table(header=T, first_row = T,
                       style = "sbomTable",
                       table_data )
     
    }
    
    table_data <- classes.attributes %>% 
      filter(class==class_name) %>% 
      filter(!is.na(serializationComment)) %>% 
      select(name,serializationComment) %>%
      rename(`Attribute name`=name,`Serialization comment`=serializationComment)
    if(table_data%>% nrow()>0) {
      docx <- docx %>%
        body_add_par("Serialization comments",style="sbomSubSubClause")%>%
        body_add_par("The following table lists serialization considerations:","sbomNormal")
      
      docx <- docx  %>%
          body_add_table(header=T, first_row = T,
                         style = "sbomTable",
                         table_data )
    }
    
    
  })
  lapply(enumerations %>% filter(package==package_name) %>% select(name) %>% unlist(use.names = F),function(enumeration_name){
    docx <- docx %>%
      body_add_par(enumerations %>% filter(name==enumeration_name) %>% transmute(text=paste(name,"data type (enumeration)")) %>% unlist(use.names = F), style = "sbomClause")
    docx <- docx %>%
      body_add_par(paste(enumeration_name,enumerations %>% filter(name==enumeration_name) %>% transmute(text=description) %>% unlist(use.names = F)), style = "sbomNormal")
    docx <- docx %>%
      body_add_par("Literal values",style="sbomSubSubClause")
    docx <- docx %>%
      body_add_table(header=T, first_row = T,
                     style = "sbomTable",
                     enumerations.literals %>% 
                       filter(name==enumeration_name) %>% 
                       select(literal, description)  %>%
                       rename(`Enumeration literal name`=literal,`Description`=description) )
    
  })

  
  
})

docx <- docx %>%
  body_add_break()

# docx <- docx %>%
#   body_add_par("Annex B:  3T-SBOM-EMS and SPDX (Informative)", style =
#                  "sbomTitle")
# docx <- docx %>%
#   body_add_par(spdx_mapping_comments,style="sbomNormal")
# docx <- docx %>%
#   body_add_table(header=T, first_row = T,
#                  style = "sbomTable",
#                  sbom_to_spdx  %>%
#                    rename(`3T-SBOM-EMS element name`=SBOM,`SPDX 3.0 element name`=SPDX,`Correspondance comment`=comment))

docx %>% print(outDocxFile)

