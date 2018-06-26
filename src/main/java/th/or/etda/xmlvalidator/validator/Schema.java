package th.or.etda.xmlvalidator.validator;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.*;


import org.xml.sax.SAXException;

import th.or.etda.xmlvalidator.model.ValidateParameter;

public class Schema {
	public boolean validate(String XMLString ,String schemaPath) throws SAXException, IOException {		
		
		boolean value = false;
		File schemaFile = new File(schemaPath);
		if(schemaFile.exists()) {
			
		
		InputStream is = new  ByteArrayInputStream(XMLString.getBytes(StandardCharsets.UTF_8));
		Source xmlFile = new StreamSource(is);
		SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
					
		javax.xml.validation.Schema schema = schemaFactory.newSchema(schemaFile);
		Validator validator = schema.newValidator();
		validator.validate(xmlFile);
		value = true;
		}
		
		else {
			throw new IOException();
		}
		
		return value;		
	}
}
