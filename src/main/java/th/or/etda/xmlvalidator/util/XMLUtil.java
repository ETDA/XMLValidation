package th.or.etda.xmlvalidator.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class XMLUtil {
	
	String XMLString;
	Document xmlDocument;
	XPath xpath;
	public XMLUtil(String XMLString) {
		
		this.XMLString = XMLString;
		
	}
	
	public void initialDocument() throws ParserConfigurationException, SAXException, IOException {
		
		InputStream is = new ByteArrayInputStream(this.XMLString.getBytes("UTF-8"));
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = builderFactory.newDocumentBuilder();
		xmlDocument = (Document) builder.parse(is);	
		
		XPathFactory xPathfactory = XPathFactory.newInstance();
		xpath = xPathfactory.newXPath();
		
	}
	
	public String getRootElementName() throws XPathExpressionException {
		
		Node element = xmlDocument.getDocumentElement();					
		return element.getNodeName();
	}
	
	public String getElementAttribute(String xPathInput) throws XPathExpressionException {	 	
		Node node = (Node) xpath.evaluate(xPathInput,xmlDocument,XPathConstants.NODE);
		
		if(node == null) {
			return null;
		}
		
		return node.getNodeValue();
	}
	
	public String getElementValue(String xPathInput) throws XPathExpressionException {
		
		/*Xpathwith Attribute*/
		Element userElement = (Element) xpath.evaluate("/TaxInvoice_CrossIndustryInvoice/ExchangedDocumentContext/GuidelineSpecifiedDocumentContextParameter/ID",xmlDocument,XPathConstants.NODE);
		String atrb = userElement.getAttribute("schemeVersionID");	
		return userElement.getTextContent();
	}
	
	private NodeList getNodelist(String xPathInput,QName nodeset) throws XPathExpressionException {
		
		XPath xPath = XPathFactory.newInstance().newXPath();		
		Element element = xmlDocument.getDocumentElement();		
		NodeList nodeList = (NodeList) xPath.compile(xPathInput).evaluate(xmlDocument,nodeset );
		
		return nodeList;
		
	}
}
