package th.or.etda.xmlvalidator;

import static org.junit.Assert.assertEquals;

import org.json.simple.JSONObject;

import org.junit.*;
import th.or.etda.xmlvalidator.util.FileUtil;
import th.or.etda.xmlvalidator.controller.*;
/*Test Class for TC718 */
public class IntegrateTest{

	FileUtil fileUtil = new FileUtil();
	String config ="src\\test\\resources\\web_validation_config.properties";
	String attribute ="code";

	@Test
	/*
	 * TC718 01 Valid XML
	 * 
	 * */
    public void TaxInvoice_01()
    {
		println("*************TC718 01 Valid XML***************");
		String XML = "src\\test\\resources\\INV71600001.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }
	
	@Test
	/*
	 * TC718 02 default version
	 * 
	 * */
    public void TaxInvoice_02()
    {
		println("*********TC718 02 default version************");
		String XML = "src\\test\\resources\\INV71800001.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }
    
	@Test
	/*
	 * TC718 03 Invalid root tag
	 * 
	 * */
    public void TaxInvoice_03()
    {
		println("**********TC718 03 Invalid root tag************");
		String XML = "src\\test\\resources\\INV71800002.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-3");
    }
	
	@Test
	/*
	 * TC718 03 Invalid root tag newfile
	 * 
	 * */
    public void TaxInvoice_03_ex1()
    {
		println("**********TC718 03v2 1 TC718 03 Invalid root tag newfile************");
		String XML = "src\\test\\resources\\INV71800002_new.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-2");
    }
    
	@Test
	/*
	 * TC718 04 Invalid schema version tag (Xpath not found) 
	 * 
	 * */
    public void TaxInvoice_04()
    {
		println("**********TC718 04 Invalid schema***************");
		String XML = "src\\test\\resources\\INV71800003.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-1");
    }
    
	@Test
	/*
	 * TC718 05 Invalid schema version
	 * 
	 * */
    public void TaxInvoice_05()
    {
		println("*****TC718 05 Invalid schema version************");
		String XML = "src\\test\\resources\\INV71800004.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-2");
    }
    
	@Test
	/*
	 * TC718 06 Invalid XML data (Schema)
	 * */
    public void TaxInvoice_06()
    {
		println("********TC718 06 Invalid XML data (Schema)******");
		String XML = "src\\test\\resources\\INV71800005.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-1");
    }
    
	@Test
	/*
	 * TC718 07 Invalid XML data (Schematron)
	 * */
    public void TaxInvoice_07()
    {
		println("*******TC718 07 Invalid XML data (Schematron)*****");
		String XML = "src\\test\\resources\\INV71800006.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-1");
    }
    
	@Test
	/*
	 * TC718 08 valid Debit note
	 * */
    public void DebitNote_08()
    {
		println("*********TC718 08 valid Debit note*************");
		String XML = "src\\test\\resources\\DBN71800001.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }
	
	@Test
	/*
	 * TC718 08 valid Debit note
	 * */
    public void DebitNote_09()
    {
		println("*********TC718 08 valid Debit note*************");
		String XML = "src\\test\\resources\\DBN71800002v2.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-2");
    }   
	@Test
	/*
	 * TC718 08 valid Debit note
	 * */
    public void DebitNote_10()
    {
		println("*********TC718 08 valid Debit note*************");
		String XML = "src\\test\\resources\\DBN71800003v2.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-1");
    }   
	@Test
	/*
	 * TC718 08 valid Debit note
	 * */
    public void DebitNote_11()
    {
		println("*********TC718 08 valid Debit note*************");
		String XML = "src\\test\\resources\\DBN71800004v2.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-2");
    }   
	
	@Test
	/*
	 * PRD01
	 * verify against RD pass 
	 * program detect xml-model as first child node 
	 * */
    public void PRD_01()
    {
		println("********* PRD01 valid verify against RD pass *************");
		String XML = "src\\test\\resources\\invalidXML_fromPRD01.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }   
	
	@Test
	/*
	 * PRD02
	 * verify against RD pass 
	 * Add more comment on head
	 * from https://www.w3.org/TR/xml-c14n11/
	 * */
    public void PRD_02()
    {
		println("********* PRD02 valid verify against RD pass *************");
		String XML = "src\\test\\resources\\invalidXML_fromPRD02.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }   
	
	@Test
	/*
	 * PRD04
	 * verify against RD pass 
	 * Add more comment on body 
	 * */
    public void PRD_03()
    {
		println("********* PRD03 valid verify against RD pass *************");
		String XML = "src\\test\\resources\\invalidXML_fromPRD03.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }   
	
	@Test
	/*
	 * PRD04
	 * verify against RD pass 
	 * Add another valid tag on top of header
	 * */
    public void PRD_04()
    {
		println("********* PRD04 valid verify against RD pass *************");
		String XML = "src\\test\\resources\\invalidXML_fromPRD04.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-3");
    }
	
	@Test
	/*
	 * STR_01
	 * stream file  
	 * CND this case is invalid > no id tag 
	 * */
    public void STR_01()
    {
		println("********* PRD04 valid verify against RD pass *************");
		String XML = "src\\test\\resources\\CDN_CN2017110001_Sample.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-1");
    }
	
	@Test
	/*
	 * STR_02
	 * stream file  
	 * TIV
	 * */
    public void STR_02()
    {
		println("********* PRD04 valid verify against RD pass *************");
		String XML = "src\\test\\resources\\TIV_IV2017110007_Sample.xml";		
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"0");
    }
    	
	@Test
	/*
	 * No config file 
	 * */
    public void error_01()
    {
		println("*************No config file***************");
		String XML = "src\\test\\resources\\INV71800001.xml";		
		config = config+"x";
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-99");
    }
    
	@Test
	/*
	 * Cannot find Schema Path 
	 * */
    public void error_02()
    {
		println("*************Cannot find Schema Path***************");
		String XML = "src\\test\\resources\\INV71800001.xml";
		config ="src\\test\\resources\\config_noschema.properties";
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-99");
    }
	
	@Test
	/*
	 * Cannot find Schematron Path 
	 * */
    public void error_03()
    {
		println("*************Cannot find Schematron Path ***************");
		println("");
		String XML = "src\\test\\resources\\INV71800001.xml";
		config ="src\\test\\resources\\config_noschematron.properties";
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-99");
    }
	

	@Test
	/*
	 * Get 6102002 - Fix to test <br /> in XML
	 * edit from Posotive case of invoice
	 * */
    public void error_04()
    {
		println("*************<br /> in xml tag ***************");
		println("");
		String XML = "src\\test\\resources\\INV71600001_err04.xml";
		config ="src\\test\\resources\\web_validation_config_noschematron.properties";
		JSONObject object = getResponseMessage(XML,config);		
    	String code = (String) object.get("code"); 	
    	showValue("file :"+ XML,object.toJSONString());
    	
    	assertEquals(code,"-1");
    }
    
    
	private JSONObject getResponseMessage(String XMPPath,String configPath) {
    	
		String XML_test = fileUtil.getStringFromFile(XMPPath);    	
    	ValidateController ctrl = new ValidateController(configPath);        	
    	JSONObject responseMessage = ctrl.Validate(XML_test);
    	
    	return responseMessage;
	}
	
	private void showValue(String XML , String json) {
    	System.out.println(XML);
    	System.out.println(json);
	}
	private void println(String Text) {
    	System.out.println(Text);
	}
}
