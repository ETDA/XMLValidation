package th.or.etda.xmlvalidator.controller;

import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.xml.sax.SAXException;

import edu.ucar.ral.crux.ValidationException;
import net.sf.saxon.s9api.SaxonApiException;
import th.or.etda.xmlvalidator.controller.*;

import th.or.etda.xmlvalidator.util.JsonUtil;
import th.or.etda.xmlvalidator.util.XMLUtil;
import th.or.etda.xmlvalidator.model.*;
import th.or.etda.xmlvalidator.validator.*;

public class ValidateController {
	response jsonResponse;
	XMLUtil XMLutil;
	JsonUtil JSONutil;
	JSONObject currentObject;
	ValidateParameter validateParam;
	String configPath;
	String XMLString;
	String XMLRoot;
	String versionXML_XML;
	String versionXML_Config ;
	String versionXML_Config_Default ;
	String versionChoosen;
	
	/**
	 * @param XMLString 
	 * @param configPath
	 */
	public ValidateController(String configPath) {
		
		this.configPath = configPath;
	}
	
	public JSONObject Validate(String XMLString){			
		this.XMLString=XMLString;
		InitialParameter();
		
		JSONObject obj = new JSONObject();
		try {
			obj = Controller();
		}
		catch(Exception e){
			e.printStackTrace();
			jsonResponse.setCode("-99");
			obj = jsonResponse.getJSONResponseObj();
		}
			
		return obj;
	}	
	
	public JSONObject Controller() {
		
		//Load Config from JsonConfig
		try {
			loadConfig();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}		
		
		//Load XML to Dom
		try {
			loadXML();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-3");
			return jsonResponse.getJSONResponseObj();
		}
		catch (ParserConfigurationException  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}		
		catch (IOException  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}
		
		// Check root is exist 
		if(!isRootExist()) {
			jsonResponse.setCode("-2");
			return jsonResponse.getJSONResponseObj();
		}	

		//Check Validate Version
		try {
			CheckVersion();
		} catch (XPathExpressionException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}	
		if(versionXML_XML == null || versionXML_XML.length() < 1 || versionXML_XML.isEmpty()){
			versionChoosen = versionXML_Config_Default;
		}
		else if(!versionChoosen.equals(versionXML_XML))
		{
			jsonResponse.setCode("-2");
			return jsonResponse.getJSONResponseObj();
		}

		
		//ValidateXML with Schema
		try {
			initValidateParameter();			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}		
		
		//ValidateXML with Schema
		boolean schemaValid = false ; 
		try {
			if(validateParam.getSchemaPath() !=null)
			{ 
				schemaValid = ValidateSchema();
			}			
			if( schemaValid == false ) {
				
				jsonResponse.setCode("-1");
				return jsonResponse.getJSONResponseObj();
			}
			if( schemaValid == true) {
				boolean continuedValidate = validateParam.getSchematronValidateFlag();
				if(continuedValidate){
					jsonResponse.setCode("0");
					return jsonResponse.getJSONResponseObj();
				}
			}
			
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			// SAXException
			e.printStackTrace();
			jsonResponse.setCode("-1");
			return jsonResponse.getJSONResponseObj();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}
			
		// Validate Schematron
		boolean schematronValid = false;
		try {
			if(validateParam.getSchematronPath()!=null)
			{ 
				schematronValid = ValidateSchematron();				
			}
			if( schematronValid == true) {
				
				jsonResponse.setCode("0");
				return jsonResponse.getJSONResponseObj();
			}
			if( schematronValid == false ) {
				
				jsonResponse.setCode("-1");
				return jsonResponse.getJSONResponseObj();
			}
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-1");
			return jsonResponse.getJSONResponseObj();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		} catch (ValidationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonResponse.setCode("-1");
			return jsonResponse.getJSONResponseObj();
		} catch (SaxonApiException e) {
			e.printStackTrace();
			jsonResponse.setCode("-99");
			return jsonResponse.getJSONResponseObj();
		}		
		
		jsonResponse.setCode("-99");
		return jsonResponse.getJSONResponseObj();
	}
	
	private boolean ValidateSchema() throws SAXException, IOException {
		// TODO Auto-generated method stub
		//Validate Schema
		Schema scm = new Schema();
		return scm.validate(XMLString, validateParam.getSchemaPath());		
	}
	
	private boolean ValidateSchematron() throws SAXException, IOException, ValidationException, SaxonApiException {
		// TODO Auto-generated method stub
		//Validate Schematron
		Schematron scmt = new Schematron();
		return scmt.validate(XMLString, validateParam.getSchematronPath());		
	}


	private void loadConfig() throws Exception {
		JSONutil = new JsonUtil(); 	
		JSONutil.readJSONArray(configPath);		
	}	
	
	private void loadXML() throws ParserConfigurationException, SAXException, IOException {
		XMLutil = new XMLUtil(XMLString);
		XMLutil.initialDocument();
	}
	
	private String getXMLRootNodeName() throws XPathExpressionException {
		return XMLutil.getRootElementName();
	}
	
	private void InitialParameter() {
		
		this.jsonResponse = new response();		
		this.XMLutil =null;
		this.JSONutil = null;
		this.currentObject = null;
		this.validateParam = null;

		this.XMLRoot = null;
		this.versionXML_XML = null;
		this.versionXML_Config = null;
		this.versionXML_Config_Default = null ;
		this.versionChoosen = null;
	}
	private void initValidateParameter()  {
		
		JSONArray jsonArray = JSONutil.getJsonArray();
		for(Object obj : jsonArray) {
    		JSONObject jsonObj = (JSONObject) obj;    		
    		String e = (String) jsonObj.get("rootTag");
    		String version = (String) jsonObj.get("version");
    		if (e.equals(XMLRoot)&&version.equals(versionChoosen)) 
    		{    			
    			//Initiate validate parameter     			
    			String schemaPath =(String) jsonObj.get("schemaFilePath");
    			String schematronPath = (String) jsonObj.get("schematronFilePath");
    			
    			ValidateParameter param = new ValidateParameter();
    			param.setSchemaPath(schemaPath);
    			param.setSchematronPath(schematronPath);
    			if(schematronPath.length() >0 && !schematronPath.isEmpty()) {
    				param.setSchemaValidateFlag(true);
    			}
    			
    			this.validateParam = param;
    			break;
    		}
    	}
		

	}

	private boolean isActive() {
		// TODO Auto-generated method stub
		Boolean value = false;
		String temp = JSONutil.getCurrentObjestStringValue("isActive");
		
		if(temp.equals("Y")) {
			currentObject = JSONutil.getCurrentJSONObj();
			value = true;
		}
		
		return value;
	}	

	
	private Boolean isRootExist() {	
		Boolean value = false;
		List<String> rootList;
		String rootTag = "rootTag";
		rootList =  JSONutil.find(rootTag);
		
		for(String temp : rootList) {
			try {
				XMLRoot = getXMLRootNodeName();
			} catch (XPathExpressionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
			if(temp.equals(XMLRoot)) {
				value = true;
				JSONutil.UpdateCurrentNode(rootTag,XMLRoot);
				currentObject = JSONutil.getCurrentJSONObj();
			}
		}		
		return value;
	}	
	
	private void CheckVersion() throws XPathExpressionException {
		JSONArray jsonArray = JSONutil.getJsonArray();
		//get xml version
		String XpathVersion = JSONutil.getCurrentObjestStringValue("versionXpath");
		versionXML_XML = XMLutil.getElementAttribute(XpathVersion);
		 
		for(Object obj : jsonArray) {
    		JSONObject jsonObj = (JSONObject) obj;    		
    		String e = (String) jsonObj.get("rootTag");
    		String version = (String) jsonObj.get("version");
    		versionXML_Config_Default = (String) jsonObj.get("defaultVersion");
    		if (e.equals(XMLRoot)&&version.equals(versionXML_XML)) 
    		{
    			versionChoosen = versionXML_XML;
    		}
    		else if(e.equals(XMLRoot) && !version.equals(versionXML_XML)) 
    		{
    			versionChoosen = versionXML_Config_Default;
    		}
    		else if(e.equals(XMLRoot) && (versionXML_XML == null || versionXML_XML.length() < 1 || versionXML_XML.isEmpty())){
    			versionXML_XML = null ; 
    		}
    	}
	}
}
