# XML Validation Project

XML Validation Lib based on Javax.xml.validation.Schema for validate schema and NCAR/crux project for Schematron


Developed envoronment
- Java Open JDK1.8-040
- Eclipse Oxygen 

Packaging environment
- mavan package 


## Example 
    // Initiate Validate Controller class with input 
    ValidateController ctrl = new ValidateController(config);
    
    // get response massage in JSONObject (JSON Simple lib)
    JSONObject responseMessage = ctrl.Validate(XML_test);
    
    // get response massage in JSONObject (JSON Simple lib)
    JSONObject responseMessage = ctrl.Validate(XML_test);
    
## Deployment Step 
- Clone XML Validator branch 3.1-sit 
- Edit sourcecode > test , test result > commit > push > pull > into branch 3.1-sit
- Merge request from 3.1-sit to 3.1 with test resul and detail
- Clone Java Java-DocumentIndexer branch 3.1 
- replace newver XML validator in Document Indexer 
- Compile Document Indexer via Eclipse
- Deploy to UAT 
    


## Changelog

### [0.2.2] - 2018-05-11
**Update** 
- Remove System.out.println due to GOlang problem on Docker

**Change**
- Change maven build on Open JDK 1.8_040 from Orace JDK 1.8_151

### [0.2.0] 
**Added** 
- Based line version
- SchematronValidateETDA extends edu.ucar.ral.crux.SchematronValidator 