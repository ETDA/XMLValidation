<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:ns uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:16" prefix="udt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:QualifiedDataType:1" prefix="qdt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:DebitCreditNote_ReusableAggregateBusinessInformationEntity:2" prefix="ram"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:DebitCreditNote_CrossIndustryInvoice:2" prefix="rsm"/>

<sch:pattern>
    <sch:rule context="/">
        <sch:report test="not(rsm:DebitCreditNote_CrossIndustryInvoice)">ไม่ผ่านการตรวจสอบเงื่อนไขที่กำหนด (Schematron) เนื่องจากประเภทของเอกสารที่เลือกไม่ตรงกับเอกสารที่นำมาตรวจสอบ</sch:report>
    </sch:rule>
    <!-- Check Document Type Code -->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:ExchangedDocument">
        
        
        <sch:report test="not(((ram:TypeCode) = '80')or((ram:TypeCode) = '81'))">
            DCN-Document-001 รหัสประเภทเอกสารไม่ถูกต้อง (80 = ใบเพิ่มหนี้,81 = ใบลดหนี้)
            (TypeCode must equal to 80 or 81.)
        </sch:report>
        
  <!--      
        <sch:report test="not(((ram:Name) = 'ใบลดหนี้')or((ram:Name) = 'ใบเพิ่มหนี้'))">
            DCN-Document-002 ชื่อประเภทเอกสารไม่ถูกต้อง ( ใบเพิ่มหนี้/ใบลดหนี้)
            (Document Name must equal to ใบลดหนี้ or ใบเพิ่มหนี้.)
        </sch:report>
        <sch:report test="(((ram:TypeCode) = '80')and((ram:Name) != 'ใบเพิ่มหนี้'))">
            DCN-Document-003 รหัสประเภทเอกสารและชื่อประเภทเอกสารไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
        <sch:report test="(((ram:TypeCode) = '81')and((ram:Name) != 'ใบลดหนี้'))">
            DCN-Document-003 รหัสประเภทเอกสารและชื่อประเภทเอกสารไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
-->
        
     <!-- <sch:report test="(( (ram:PurposeCode) or (ram:Purpose) or (ram:IncludedCINote/ram:Content) ) and (not( (ram:PurposeCode) and (ram:Purpose) and (ram:IncludedCINote/ram:Content) ) ))">
            ไม่พบข้อมูรหัสสาเหตุ สาเหตุ และหมายเหตุการออกเอกสาร (tiv-nodata-001 : ram:PurposeCode, ram:Purpose and ram:IncludedCINote/ram:Content must be present because AdditionalReferencedDocument is present.)
        </sch:report>  -->
        <sch:report test="not((ram:PurposeCode) !='')">
            DCN-Document-004 ต้องระบุข้อมูลรหัสสาเหตุการออกเอกสาร (PurposeCode)
            (PurposeCode must be present.)
        </sch:report>
    </sch:rule>
    
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice">
        <sch:report test="rsm:ExchangedDocument/ram:TypeCode ='80' and (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument) 
            and  (((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNG01') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNG02') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNG99')  and ((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNS01')
            and ((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNS02') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNS02')
            and ((rsm:ExchangedDocument/ram:PurposeCode) != 'DBNS99'))">
            DCN-Document-005 กรณีใบเพิ่มหนี้ การระบุรหัสสาเหตุการออกเอกสาร (PurposeCode) ต้องมีค่าเท่ากับ DBNG01 หรือ DBNG02 หรือ DBNG99 หรือ DBNS01 หรือ DBNS02 หรือ DBNS99 เท่านั้น
            (In case of debit note, PurposeCode must equal to DBNG01, DBNG02, DBNG99, DBNS01, DBNS02, DBNS99)
        </sch:report>
        <sch:report test="rsm:ExchangedDocument/ram:TypeCode ='81' and (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument) 
            and  (((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNG01') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNG02') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNG03')  and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNG04')
            and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNG05') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNG99') 
            and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNS01')  and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNS02')
            and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNS03')  and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNS04')  and ((rsm:ExchangedDocument/ram:PurposeCode) != 'CDNS99')
            )">
            DCN-Document-006 กรณีใบลดหนี้ การระบุรหัสสาเหตุการออกเอกสาร (PurposeCode) ต้องมีค่าเท่ากับ CDNG01 หรือ CDNG02 หรือ CDNG03 หรือ CDNG04 หรือ CDNG05 หรือ CDNG99 หรือ CDNS01 หรือ CDNS02 หรือ CDNS03 หรือ CDNS04 หรือ CDNS99 เท่านั้น
            (In case of credit note, PurposeCode must equal to  CDNG01, CDNG02, CDNG03, CDNG04, CDNG05, CDNG99, CDNS01, CDNS02, CDNS03, CDNS04, CDNS99)
        </sch:report>
        <sch:report test="((rsm:ExchangedDocument/ram:PurposeCode = 'DBNG99') or (rsm:ExchangedDocument/ram:PurposeCode = 'DBNS99') or (rsm:ExchangedDocument/ram:PurposeCode = 'CDNG99') or (rsm:ExchangedDocument/ram:PurposeCode = 'CDNS99') ) and ( not(rsm:ExchangedDocument/ram:Purpose) or (rsm:ExchangedDocument/ram:Purpose = '') )">
            DCN-Document-007 กรณีระบุรหัสสาเหตุการออกเอกสาร (PurposeCode) มีค่าเท่ากับ DBNG99 หรือ DBNS99 หรือ CDNG99 หรือ CDNS99 ต้องระบุสาเหตุการออกเอกสาร (Purpose)
            (Purpose must be present since PurposeCode equals to DBNG99, DBNS99, CDNG99, CDNS99)
        </sch:report>
        <sch:report test="substring(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID,1,13) = substring(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:SpecifiedTaxRegistration/ram:ID,1,13)">
            DCN-Document-008 เลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน ต้องไม่เท่ากับเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must not equal to SellerTradeParty/SpecifiedTaxRegistration/ID)
        </sch:report>
        
        <!-- Additional Reffe
        <sch:report test="not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = '388' or rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = 'T02' or rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = 'T03' or rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = 'T04')" > 
            DCN-AdditionalReferencedDocument-001 ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ที่มีค่าเป็น  388 หรือ T02 หรือ T03 หรือ T04 อย่างน้อย 1 เอกสาร
            (AdditionalReferencedDocument must be equal to  388 or T02 or T03 or T04 since PurposeCode is present.)
        </sch:report> -->
        <!-- Additional Reffe -->
        <sch:report test="(not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = '388']) 
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T02'])
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T03'])
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T04'])
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = '80'])
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = '81'])
            )" > 
            DCN-AdditionalReferencedDocument-001 ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ที่มีค่าเป็น 80 หรือ 81 หรือ  388 หรือ T02 หรือ T03 หรือ T04  อย่างน้อย 1 เอกสาร
            (AdditionalReferencedDocument must be equal to 80 or 81 or 388 or T02 or T03 or T04 since PurposeCode is present.)
        </sch:report>
        <!-- Additional Reffe -->
    </sch:rule>
    
    
    
    
    <!-- SellerTradeParty Rule -->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
        <sch:report test="not((ram:Name)!='')">
            DCN-SellerTradeParty-001 ต้องระบุชื่อผู้ขาย
            (Name must be present since SellerTradeParty is present.)
        </sch:report>
        
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            DCN-SellerTradeParty-002  ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (SpecifiedTaxRegistration)
            (SpecifiedTaxRegistration must be present since SellerTradeParty is present.)
        </sch:report>        
      <!--  <sch:report test="not(ram:PostalTradeAddress)">
            DCN-SellerTradeParty-003 ต้องมีข้อมูลที่อยู่ผู้ขายในส่วนข้อมูลผู้ขาย
            (PostalTradeAddress must be present since SellerTradeParty is present.)
        </sch:report>   -->
    </sch:rule>
    
    <!-- SellerTradePartyRule/SpecifiedTaxRegistration Rule-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration">
        
        <sch:report test="not((ram:ID)!='')">
            DCN-SellerTradeParty-003 ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (SpecifiedTaxRegistration/ID)
            (ID must be present since SellerTradePart/SpecifiedTaxRegistration)
        </sch:report>                           
        <sch:report test="not(((ram:ID/@schemeID) = '') or ((ram:ID/@schemeID) = 'TXID') or((ram:ID/@schemeID) = 'NIDN')  or not(ram:ID/@schemeID))">
            DCN-SellerTradeParty-004 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN เท่านั้น
            (schemeID must equal to TXID or NIDN..)
        </sch:report>
        
        <sch:report test="(ram:ID) and ((ram:ID/@schemeID) = '' or (ram:ID/@schemeID) = 'TXID'  or not(ram:ID/@schemeID)) and string-length(ram:ID) != 18">
            DCN-SellerTradeParty-005 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID
        </sch:report>
        
        <sch:report test="(ram:ID) and (ram:ID/@schemeID) = 'NIDN' and string-length(ram:ID) != 13">
            DCN-SellerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 because schemeID is NIDN)
        </sch:report>
    </sch:rule>
    
    <!-- SellerTradePartyRule/DefinedTradeContact Rule 
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:PersonName">
            PersonName is not allowed because SellerCITradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:DepartmentName">
            DepartmentName is not allowed because SellerCITradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:TelephoneUniversalCommunication">
            TelephoneCIUniversalCommunication is not allowed because SellerCITradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule>   -->
    
    <!-- SellerCITradePartyRule/PostalAddress Rule-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5))">
            DCN-SellerTradeParty-007 ต้องระบุรหัสไปรษณีย์ผู้ขาย มีจำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="not(ram:CountryID) or ram:CountryID !='TH' ">
            DCN-SellerTradeParty-008 ต้องระบุรหัสประเทศผู้ขาย ต้องมีค่าเท่ากับ TH เท่านั้น 
            (CountryID must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report>
        <sch:report test="(not(ram:BuildingNumber) or ram:BuildingNumber='')">
            DCN-SellerTradeParty-009 ต้องระบุ บ้านเลขที่ (BuildingNumber) 
            (BuildingNumber must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CityName) or ram:CityName='')">
            DCN-SellerTradeParty-010 ต้องระบุ ชื่ออำเภอ (CityName) 
            (CityName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CitySubDivisionName) or ram:CitySubDivisionName='')">
            DCN-SellerTradeParty-011 ต้องระบุ ชื่อตำบล (CitySubDivisionName) 
            (CitySubDivisionName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CountrySubDivisionID) or ram:CountrySubDivisionID='')">
            DCN-SellerTradeParty-012 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) 
            (CountrySubDivisionID must be present since CountryID is TH.)
        </sch:report>
    </sch:rule>
    
    <!-- BuyerTradeParty Rule -->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty">
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            DCN-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            (SpecifiedTaxRegistration must be present since BuyerTradeParty is present.)
        </sch:report>
    </sch:rule>
    
    <!-- BuyerTradeParty/SpecifiedTaxRegistration Rule-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration">
        <sch:report test="not((ram:ID)!='')">
            DCN-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            (ID must be present because BuyerTradeParty/SpecifiedTaxRegistration is present.)
        </sch:report>  
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or ram:ID/@schemeID = 'CCPT' or ram:ID/@schemeID = 'OTHR'  or not(ram:ID/@schemeID))">
            DCN-BuyerTradeParty-002 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN หรือ CCPT หรือ OTHR เท่านั้น
            (schemeID must equal to TXID or NIDN or CCPT or OTHR.)
        </sch:report>   
        <!-- TXID NIDN CCPT OTHR -->
        <sch:report test="(ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID'  or not(ram:ID/@schemeID)) and string-length(ram:ID) != 18">
            DCN-BuyerTradeParty-003 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID.)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            DCN-BuyerTradeParty-004 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN)
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'CCPT') and string-length(ram:ID) > 35">
            DCN-BuyerTradeParty-005  กรณีระบุประภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น CCPT ต้องมีจำนวนตัวอักษรไม่เกิน 35 ตัวอักษร
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 35 since schemeID is CCPT)
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'OTHR') and (ram:ID) != 'N/A'">
            DCN-BuyerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น OTHR ต้องระบุค่าเป็น N/A
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must be N/A since schemeID is OTHR)
        </sch:report> 
    </sch:rule>
    
    
    <!-- BuyerTradePartyRule/DefinedTradeContact Rule
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:PersonName">
            PersonName is not allowed because BuyerTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:DepartmentName">
            DepartmentName is not allowed because BuyerTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:TelephoneCIUniversalCommunication">
            TelephoneCIUniversalCommunication is not allowed because BuyerTradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule> -->
    
    <!-- BuyerTradePartyRule/PostalAddress Rule-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress">
        <sch:report test="not(((ram:LineOne) and ram:LineOne !='')) and not(((ram:BuildingNumber) and ram:BuildingNumber !='') and ((ram:CityName) and ram:CityName !='') and ((ram:CitySubDivisionName) and ram:CitySubDivisionName !='') and ((ram:CountrySubDivisionID) and ram:CountrySubDivisionID !=''))">
            DCN-BuyerTradeParty-007 ต้องระบุที่อยู่ของผู้ซื้อ เป็นแบบมีโครงสร้าง (ประกอบด้วย บ้านเลขที่ ตำบล อำเภอ จังหวัด) หรือ แบบไม่มีโครงสร้าง (ประกอบด้วยข้อมูล ที่อยู่บบรรทัดที่ 1 (LineOne) เป็นอย่างน้อย)
            (BuyerTradeParty/PostalTradeAddress must be specified in unstructured  or structured format.)
        </sch:report>
        
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5)) and ram:CountryID ='TH'">
            DCN-BuyerTradeParty-008 กรณีระบุค่าของ CountryID เท่ากับ TH ต้องระบุรหัสไปรษณีย์ผู้ซื้อ จำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since BuyerTradeParty/PostalAddress is present.)
        </sch:report>   
        
        <sch:report test="not(ram:CountryID) or ram:CountryID =''">
            DCN-BuyerTradeParty-009 ต้องระบุรหัสประเทศของผู้ซื้อ  
            (CountryID must be present since BuyerTradeParty/PostalAddress is present.)
        </sch:report> 
    </sch:rule>
    
    <!-- AdditionalReferencedDocument Rule -->
   <!-- <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument">
        <sch:report test="not(ram:IssuerAssignedID and ram:IssueDateTime and ram:ReferenceTypeCode)">
            IssuerAssignedID, ram:IssueDateTime and ram:ReferenceTypeCode must be present because AdditionalReferencedDocument is present.
        </sch:report>
    </sch:rule> -->
    
    <!-- ShipToCITradeParty Rule @09022017-->
    <!-- <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:EmailURICIUniversalCommunication">
            EmailURICIUniversalCommunication is not allowed because ShipToCITradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule> -->
    
    <!-- ShipFromCITradeParty Rule -->
    <!-- Removed 
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipFromTradeParty">        
        <sch:report test="ram:SpecifiedTaxRegistration">
            SpecifiedTaxRegistration is not allowed because ShipFromCITradeParty/SpecifiedTaxRegistration is present.
        </sch:report>
        <sch:report test="ram:DefinedTradeContact">
            DefinedTradeContact is not allowed because ShipFromCITradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:PostalTradeAddress">
            PostalTradeAddress is not allowed because ShipFromCITradeParty/PostalTradeAddress is present.
        </sch:report>        
    </sch:rule>
    -->
    <!-- ApplicationTradeTax Rule @09022017-->
    <!--
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
        <sch:report test="not(ram:TypeCode)">
            TypeCode must be present because ApplicableTradeTax is present.
        </sch:report>
        <sch:report test="not(ram:CalculatedRate)">
            CalculatedRate must be present because ApplicableTradeTax is present.
        </sch:report>
        <sch:report test="not(ram:BasisAmount)">
            BasisAmount mustbe present because ApplicableTradeTax is present.
        </sch:report>
        <sch:report test="not(ram:CalculatedAmount)">
            CalculatedAmount mustbe present because ApplicableTradeTax is present.
        </sch:report>
    </sch:rule>-->
    
    <!-- InvoicerTradeParty Rule @09022017-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty">
        <sch:report test="not((ram:Name)!='')">
             DCN-InvoicerTradeParty-001 ต้องระบุชื่อผู้ออกเอกสาร
            (Name must be present since InvoicerTradeParty is present.)
        </sch:report>
        
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            DCN-InvoicerTradeParty-002 ต้องระบุเลขประจำตัวผู้เสียภาษีของผู้ออกเอกสาร
            (SpecifiedTaxRegistration must be present since  InvoicerTradeParty is present.)
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            DCN-InvoicerTradeParty-003 ต้องระบุที่อยู่ผู้ออกเอกสาร
            (PostalTradeAddress must be present since InvoicerTradeParty is present.)
        </sch:report>
    </sch:rule>
    
    <!-- InvoicerTradeParty/SpecifiedTaxRegistration Rule @09022017-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:SpecifiedTaxRegistration">
        
        <sch:report test="not((ram:ID)!='')">
            DCN-InvoicerTradeParty-004 ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (SpecifiedTaxRegistration/ID)
            (ID must be present since InvoicerTradePart/SpecifiedTaxRegistration)
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = ''  or not(ram:ID/@schemeID))">
            DCN-InvoicerTradeParty-005 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN เท่านั้น
            (schemeID must equal to TXID or NIDN.)
        </sch:report>   
        <sch:report test="(ram:ID) and (ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID'  or not(ram:ID/@schemeID)) and string-length(ram:ID) != 18">
            DCN-InvoicerTradeParty-006  กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            DCN-InvoicerTradeParty-007 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN.)
        </sch:report>  
    </sch:rule>
    
    <!-- InvoicerTradeParty/PostalAddress Rule @09022017-->
    <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5))">
            DCN-InvoicerTradeParty-008 ต้องระบุรหัสไปรษณีย์ผู้ออกเอกสารแทน มีจำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since InvoicerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="not(ram:CountryID) or ram:CountryID !='TH' ">
            DCN-InvoicerTradeParty-009 ต้องระบุรหัสประเทศผู้ออกเอกสารแทน ต้องมีค่าเท่ากับ TH เท่านั้น 
            (CountryID must be present since InvoicerTradeParty/PostalAddress is present.)
        </sch:report>
        <sch:report test="(not(ram:BuildingNumber) or ram:BuildingNumber='')">
            DCN-InvoicerTradeParty-010 ต้องระบุ บ้านเลขที่ (BuildingNumber) 
            (BuildingNumber must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CityName) or ram:CityName='')">
            DCN-InvoicerTradeParty-011 ต้องระบุ ชื่ออำเภอ (CityName) 
            (CityName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CitySubDivisionName) or ram:CitySubDivisionName='')">
            DCN-InvoicerTradeParty-012 ต้องระบุ ชื่อตำบล (CitySubDivisionName) 
            (CitySubDivisionName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CountrySubDivisionID) or ram:CountrySubDivisionID='')">
            DCN-InvoicerTradeParty-013 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) 
            (CountrySubDivisionID must be present since CountryID is TH.)
        </sch:report>
    </sch:rule>
    
    <!-- InvoiceeTradeParty Rule @09022017-->
    <!-- <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty">
        <sch:report test="not(ram:Name)">
            Name must be present since SellerCITradeParty is present.
        </sch:report>
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            SpecifiedTaxRegistration must be present since SellerTradeParty is present.
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            PostalTradeAddress must be present since SellerTradeParty is present.
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            PostalTradeAddress must be present since SellerTradeParty is present.
        </sch:report>
    </sch:rule> -->
    
    <!-- InvoiceeTradeParty/SpecifiedTaxRegistration Rule @09022017-->
    <!-- <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty/SpecifiedTaxRegistration">
        
        <sch:report test="not(ram:ID)">
            ID must be present because SellerTradePart/SpecifiedTaxRegistration
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or ram:ID/@schemeID = 'CCPT' or ram:ID/@schemeID = 'OTHR')">
            ID must equal to TXID or NIDN.
        </sch:report>   
        
        <sch:report test="(ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID') and string-length(ram:ID) != 18">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 because schemeID is TXID
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 because schemeID is NIDN
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'CCPT') and string-length(ram:ID) != 18">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 because schemeID is CCPT
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'OTHR') and string-length(ram:ID) > 64">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length less than or equal to 64 because schemeID is OTHR
        </sch:report> 
    </sch:rule>
    -->
    
    <!-- InvoicerTradeParty/PostalAddress Rule @09022017-->
   <!--- <sch:rule context="rsm:DebitCreditNote_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:InvoiceeTradeParty/ram:PostalTradeAddress">
        <sch:report test="not(ram:CountryID)">
            CountryID must be present because SellerCITradeParty/PostalAddress is present.
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not( (ram:CityName) and (ram:CitySubDivisionName) and (ram:CountrySubDivisionID) and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionID must be present because CountryID is TH.
        </sch:report>
        <sch:report test="ram:CountryID !='TH' and (not((ram:LineOne) and (ram:LineTwo)  and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionName must be present because CountryID is not TH.
        </sch:report>
    </sch:rule> -->
    
    
    
</sch:pattern>

</sch:schema>