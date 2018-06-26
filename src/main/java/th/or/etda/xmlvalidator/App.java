package th.or.etda.xmlvalidator;

import org.json.simple.JSONObject;

import th.or.etda.xmlvalidator.controller.ValidateController;
import th.or.etda.xmlvalidator.util.FileUtil;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
    	/*
    	 *  String inputXML = "src\\test\\resources\\INV71600001.xml";
		 *	String config = "src\\test\\resources\\web_validation_config.properties";
		 */
    	
    	String inputXML = args[0];
		String config = args[1];
    	
    	//Read XML File from test resource 
    	FileUtil fileUtil = new FileUtil();
    	
    	System.out.println("Input XML file :" + inputXML);
    	System.out.println("Input config file :" + config);
    	
    	String XML_test = fileUtil.getStringFromFile(inputXML);    	
    	ValidateController ctrl = new ValidateController(config); 
    	
    	System.out.println("Start Verification");
    	JSONObject responseMessage = ctrl.Validate(XML_test);
    	System.out.println("Complete Verification");
    	
    	System.out.println(responseMessage.toString());
    	//assertNotNull(XML_test);
    }
}
