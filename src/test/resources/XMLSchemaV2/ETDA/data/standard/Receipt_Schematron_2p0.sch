<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:ns uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:16" prefix="udt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:QualifiedDataType:1" prefix="qdt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:Receipt_ReusableAggregateBusinessInformationEntity:2" prefix="ram"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:Receipt_CrossIndustryInvoice:2" prefix="rsm"/>

<sch:pattern>
    <sch:rule context="/">
        <sch:report test="not(rsm:Receipt_CrossIndustryInvoice)">ไม่ผ่านการตรวจสอบเงื่อนไขที่กำหนด (Schematron) เนื่องจากประเภทของเอกสารที่เลือกไม่ตรงกับเอกสารที่นำมาตรวจสอบ</sch:report>
    </sch:rule>
    <!-- Check Document Type Code -->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:ExchangedDocument">
        <sch:report test="not((ram:TypeCode) = 'T01')">
            RCT-Document-001 รหัสประเภทเอกสารไม่ถูกต้อง T01 = ใบรับ (ใบเสร็จรับเงิน)
            (TypeCode must equal to T01.)
        </sch:report>
        <sch:report test="ram:PurposeCode != 'RCTC01' and ram:PurposeCode != 'RCTC02'  and ram:PurposeCode != 'RCTC03'  and ram:PurposeCode != 'RCTC04'  and ram:PurposeCode != 'RCTC99'">
            RCT-Document-002 กรณียกเลิกใบรับเดิม และออกใบรับใหม่ ต้องระบุรหัสสาเหตุการออกเอกสาร (PurposeCode) ต้องมีค่าเท่ากับ RCTC01 หรือ RCTC02 หรือ RCTC03 หรือ RCTC99 เท่านั้น
            (PurposeCode must equal to  RCTC01, RCTC02, RCTC03, RCTC99.)
        </sch:report>
        <sch:report test="ram:PurposeCode = 'RCTC99' and not((ram:Purpose)!='')">
            RCT-Document-003 กรณีระบุรหัสสาเหตุการออกเอกสาร (PurposeCode) มีค่าเท่ากับ RCTC99 ต้องระบุสาเหตุการออกเอกสาร (Purpose)
            (Purpose must be present since PurposeCode equals to RCTC99)
        </sch:report>
    </sch:rule>
    <sch:rule context="rsm:SupplyChainTradeTransaction">
        <sch:report test="substring(ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID,1,13) = substring(ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:SpecifiedTaxRegistration/ram:ID,1,13)">
            RCT-Document-004 เลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน ต้องไม่เท่ากับเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must not equal to SellerTradeParty/SpecifiedTaxRegistration/ID)
        </sch:report>
    </sch:rule>
    
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice">
        <sch:report test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument)
            and (not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T01']) 
            )" > 
            RCT-AdditionalReferencedDocument-001 กรณียกเลิกใบรับ(ใบเสร็จรับเงิน)เดิม และออกใบรับ(ใบเสร็จรับเงิน)ใหม่ ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ให้มีค่าเป็น T01 เท่านั้น
            (AdditionalReferencedDocument must be equal to   T01 since PurposeCode is present)
        </sch:report>
    </sch:rule>
    
    
    
    <!-- SellerTradeParty Rule -->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
        <sch:report test="not((ram:Name)!='')">
            RCT-SellerTradeParty-001 ต้องระบุชื่อผู้ขาย
            (Name must be present since SellerTradeParty is present.)
        </sch:report>

        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            RCT-SellerTradeParty-002  ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (SpecifiedTaxRegistration)
            (SpecifiedTaxRegistration must be present since SellerTradeParty is present.)
        </sch:report>      
        <sch:report test="not(ram:SpecifiedTaxRegistration/ram:ID)">
            RCT-SellerTradeParty-003 ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (SpecifiedTaxRegistration/ID)
            (SpecifiedTaxRegistration must be present since SellerTradeParty is present.)
        </sch:report> 
        <sch:report test="not(ram:PostalTradeAddress)">
            RCT-SellerTradeParty-003 ต้องมีข้อมูลที่อยู่ผู้ขายในส่วนข้อมูลผู้ขาย
            (PostalTradeAddress must be present since SellerTradeParty is present.)
        </sch:report>
    </sch:rule>
    <!-- SellerTradePartyRule/DefinedTradeContact Rule @09022017-->
  <!--  <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:PersonName">
            PersonName is not allowed because SellerTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:DepartmentName">
            DepartmentName is not allowed because SellerTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:TelephoneUniversalCommunication">
            TelephoneUniversalCommunication is not allowed because SellerTradeParty/DefinedTradeContact is present.
        </sch:report>        
    </sch:rule>-->
    
    <!-- SellerTradePartyRule/SpecifiedTaxRegistration Rule-->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration">
                                  
        <sch:report test="not(((ram:ID/@schemeID) = '') or ((ram:ID/@schemeID) = 'TXID') or((ram:ID/@schemeID) = 'NIDN')  or not(ram:ID/@schemeID) )">
            RCT-SellerTradeParty-004 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN เท่านั้น
            (schemeID must equal to TXID or NIDN.)
        </sch:report>
        
        <sch:report test="((ram:ID/@schemeID) = '' or (ram:ID/@schemeID) = 'TXID'  or not(ram:ID/@schemeID) ) and string-length(ram:ID) != 18">
            RCT-SellerTradeParty-005 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID )
        </sch:report>
        <sch:report test="(ram:ID/@schemeID) = 'NIDN' and string-length(ram:ID) != 13">
            RCT-SellerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN)
        </sch:report>
    </sch:rule>            
    
    
    <!-- SellerTradePartyRule/PostalAddress Rule-->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5))">
            RCT-SellerTradeParty-007 ต้องระบุรหัสไปรษณีย์ผู้ขาย มีจำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="(not(ram:CountryID) or ram:CountryID!='TH')">
            RCT-SellerTradeParty-008 ต้องระบุรหัสประเทศผู้ขาย ต้องมีค่าเท่ากับ TH เท่านั้น 
            (CountryID must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report>
        
        <sch:report test="(not(ram:BuildingNumber) or ram:BuildingNumber='')">
            RCT-SellerTradeParty-009 ต้องระบุ บ้านเลขที่ (BuildingNumber) 
            (BuildingNumber must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CityName) or ram:CityName ='')">
            RCT-SellerTradeParty-010 ต้องระบุ ชื่ออำเภอ (CityName) 
            (CityName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CitySubDivisionName) or ram:CitySubDivisionName ='')">
            RCT-SellerTradeParty-011 ต้องระบุ ชื่อตำบล (CitySubDivisionName) 
            (CitySubDivisionName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CountrySubDivisionID) or ram:CountrySubDivisionID='')">
            RCT-SellerTradeParty-012 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) 
            (CountrySubDivisionID must be present since CountryID is TH.)
        </sch:report>
    </sch:rule>
    
    
    <!-- BuyerTradeParty Rule -->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty">
       <!-- <sch:report test="not((ram:Name)!='')">
            RCT-BuyerTradeParty-001 ต้องระบุชื่อผู้ซื้อ
            (Name must be present since BuyerTradeParty is present.)
        </sch:report> -->
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            RCT-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            (SpecifiedTaxRegistration must be present since BuyerTradeParty is present.)
        </sch:report>
     <!--   <sch:report test="not(ram:PostalTradeAddress)">
            RCT-BuyerTradeParty-003 ต้องระบุที่อยู่ผู้ซื้อ
            (PostalTradeAddress must be present since BuyerTradeParty is present.)
        </sch:report>-->
    </sch:rule>
    
    <!-- BuyerTradePartyRule/SpecifiedTaxRegistration Rule-->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration">        
        <sch:report test="not((ram:ID)!='')">
            RCT-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            (ID must be present since BuyerTradeParty/SpecifiedTaxRegistration is present)
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or ram:ID/@schemeID = 'CCPT' or ram:ID/@schemeID = 'OTHR'  or not(ram:ID/@schemeID) )">
            RCT-BuyerTradeParty-002 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN หรือ CCPT หรือ OTHR เท่านั้น
            (schemeID must equal to TXID or NIDN or CCPT or OTHR.)
        </sch:report>   
        <!-- TXID NIDN CCPT OTHR -->
        <sch:report test="(ram:ID/@schemeID) and (ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID'  or not(ram:ID/@schemeID) ) and string-length(ram:ID) != 18">
            RCT-BuyerTradeParty-003 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            RCT-BuyerTradeParty-004 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN)
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'CCPT') and string-length(ram:ID) > 35">
            RCT-BuyerTradeParty-005 กรณีระบุประภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น CCPT ต้องมีจำนวนตัวอักษรไม่เกิน 35 ตัวอักษร
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 35 since schemeID is CCPT)
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'OTHR') and ram:ID != 'N/A'">
            RCT-BuyerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น OTHR ต้องระบุค่าเป็น N/A
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must be N/A since schemeID is OTHR)
        </sch:report> 
    </sch:rule>
    
  
    
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress">
        <sch:report test="not(((ram:LineOne) and ram:LineOne !='')) and not(((ram:BuildingNumber) and ram:BuildingNumber !='') and ((ram:CityName) and ram:CityName !='') and ((ram:CitySubDivisionName) and ram:CitySubDivisionName !='') and ((ram:CountrySubDivisionID) and ram:CountrySubDivisionID !=''))">
            RCT-BuyerTradeParty-007 ต้องระบุที่อยู่ของผู้ซื้อ เป็นแบบมีโครงสร้าง (ประกอบด้วย บ้านเลขที่ ตำบล อำเภอ จังหวัด) หรือ แบบไม่มีโครงสร้าง (ประกอบด้วยข้อมูล ที่อยู่บบรรทัดที่ 1 (LineOne) เป็นอย่างน้อย)
            (BuyerTradeParty/PostalTradeAddress must be specified in unstructured  or structured format)
        </sch:report>
        <sch:report test="(((ram:CountryID) ='TH') and (not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5)))">
            RCT-BuyerTradeParty-008 กรณีระบุค่าของ CountryID เท่ากับ TH ต้องระบุรหัสไปรษณีย์ผู้ซื้อ จำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since BuyerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="not((ram:CountryID)!='')">
            RCT-BuyerTradeParty-009 ต้องระบุรหัสประเทศของผู้ซื้อ  (BuyerTradeParty/PostalAddress/BuyerTradeParty/CountryID)
            (CountryID must be present since BuyerTradeParty/PostalAddress is present.)
        </sch:report>
        
    </sch:rule>
    <!--
    <sch:rule context="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument">
        <sch:report test="ram:ReferenceTypeCode != 'T01'">
            RCT-AdditionalReferencedDocument-001 กรณียกเลิกใบรับ(ใบเสร็จรับเงิน)เดิม และออกใบรับ(ใบเสร็จรับเงิน)ใหม่ ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ให้มีค่าเป็น T01 เท่านั้น
            (AdditionalReferencedDocument must be equal to   T01 since PurposeCode is present)
        </sch:report>
    </sch:rule> -->
                 
    <!-- ShipToTradeParty Rule @09022017-->
    <!-- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:EmailURIUniversalCommunication">
            EmailURIUniversalCommunication is not allowed because ShipToTradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule> -->
    
    <!-- ShipFromTradeParty Rule -->
    <!-- Removed 
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipFromTradeParty">        
        <sch:report test="ram:SpecifiedTaxRegistration">
            SpecifiedTaxRegistration is not allowed because ShipFromTradeParty/SpecifiedTaxRegistration is present.
        </sch:report>
        <sch:report test="ram:DefinedTradeContact">
            DefinedTradeContact is not allowed because ShipFromTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:PostalTradeAddress">
            PostalTradeAddress is not allowed because ShipFromTradeParty/PostalTradeAddress is present.
        </sch:report>        
    </sch:rule>       
    -->
    <!-- InvoicerTradeParty Rule @09022017-->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty">
        <sch:report test="not((ram:Name)!='')">
            RCT-InvoicerTradeParty-001 ต้องระบุชื่อผู้ออกเอกสารแทน
            (Name must be present since InvoicerTradeParty is present.)
        </sch:report>
        
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            RCT-InvoicerTradeParty-002  ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (SpecifiedTaxRegistration)
            (SpecifiedTaxRegistration must be present since InvoicerTradeParty is present.)
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            RCT-InvoicerTradeParty-003 ต้องระบุที่อยู่ของผู้ออกเอกสารแทน
            (PostalTradeAddress must be present since InvoicerTradeParty is present.)
        </sch:report>
    </sch:rule>
    
    <!-- InvoicerTradeParty/SpecifiedTaxRegistration Rule @09022017-->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:SpecifiedTaxRegistration">
        
        <sch:report test="not((ram:ID)!='')">
            RCT-InvoicerTradeParty-004 ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (SpecifiedTaxRegistration/ID)
            (ID must be present since InvoicerTradePart/SpecifiedTaxRegistration)
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or not(ram:ID/@schemeID))">
            RCT-InvoicerTradeParty-005 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN เท่านั้น
            (schemeID must equal to TXID or NIDN.)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID' or not(ram:ID/@schemeID) ) and string-length(ram:ID) != 18">
            RCT-InvoicerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            RCT-InvoicerTradeParty-007 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN)
        </sch:report>  
    </sch:rule>
    
    <!-- InvoicerTradeParty/PostalAddress Rule @09022017-->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5))">
            RCT-InvoicerTradeParty-008 ต้องระบุรหัสไปรษณีย์ผู้ออกเอกสารแทน มีจำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since InvoicerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="(not(ram:CountryID) or ram:CountryID !='TH')">
            RCT-InvoicerTradeParty-009 ต้องระบุรหัสประเทศผู้ออกเอกสารแทน ต้องมีค่าเท่ากับ TH เท่านั้น 
            (CountryID must be present since InvoicerTradeParty/PostalAddress is present.)
        </sch:report>
        <sch:report test="(not(ram:BuildingNumber) or ram:BuildingNumber='')">
            RCT-InvoicerTradeParty-010 ต้องระบุ บ้านเลขที่ (BuildingNumber) 
            (BuildingNumber must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CityName) or ram:CityName ='')">
            RCT-InvoicerTradeParty-011 ต้องระบุ ชื่ออำเภอ (CityName) 
            (CityName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CitySubDivisionName) or ram:CitySubDivisionName ='')">
            RCT-InvoicerTradeParty-012 ต้องระบุ ชื่อตำบล (CitySubDivisionName) 
            (CitySubDivisionName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CountrySubDivisionID) or ram:CountrySubDivisionID ='')">
            RCT-InvoicerTradeParty-013 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) 
            (CountrySubDivisionID must be present since CountryID is TH.)
        </sch:report>
    </sch:rule>
    
    <!--  Qu -->
    <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem">
        <sch:report test="not(ram:SpecifiedLineTradeDelivery[ram:BilledQuantity !=''])">
            RCT-GoodsDetail-013 ต้องระบุจำนวนสินค้าหรือบริการ  (BilledQuantity must be present since SpecifiedLineTradeDelivery is present.)
        </sch:report>
    </sch:rule>
    
    <!-- InvoiceeTradeParty Rule @09022017-->
    <!-- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty">
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
   <!-- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty/SpecifiedTaxRegistration">
        
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
    </sch:rule>-->
    
    <!-- InvoiceeTradeParty/PostalAddress Rule @09022017-->
   <!-- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:InvoiceeTradeParty/ram:PostalTradeAddress">
        <sch:report test="not(ram:CountryID)">
            CountryID must be present because SellerCITradeParty/PostalAddress is present.
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not( (ram:CityName) and (ram:CitySubDivisionName) and (ram:CountrySubDivisionID) and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionID must be present because CountryID is TH.
        </sch:report>
        <sch:report test="ram:CountryID !='TH' and (not((ram:LineOne) and (ram:LineTwo)  and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionName must be present because CountryID is not TH.
        </sch:report>
    </sch:rule>-->

    <!-- PayerTradeParty Rule @09022017-->
    <!-- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayerTradeParty">
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
    
    <!-- PayerTradeParty/SpecifiedTaxRegistration Rule-->
    <!--<sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayerTradeParty/SpecifiedTaxRegistration">
        
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
    </sch:rule>-->
    
    <!-- PayerTradeParty/PostalAddress Rule @09022017-->
    <!-- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:PayerTradeParty/ram:PostalTradeAddress">
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

    <!-- PayeeTradeParty Rule @09022017-->
    <!--- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty">
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
    </sch:rule>-->
    
    <!-- PayeeTradeParty/SpecifiedTaxRegistration Rule @09022017-->
    <!--<sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/SpecifiedTaxRegistration">
        
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
    </sch:rule>-->
    
    <!-- PayeeTradeParty/PostalAddress Rule @09022017-->
    <!--- <sch:rule context="rsm:Receipt_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:PayeeTradeParty/ram:PostalTradeAddress">
        <sch:report test="not(ram:CountryID)">
            CountryID must be present because SellerCITradeParty/PostalAddress is present.
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not(  (ram:CityName) and (ram:CitySubDivisionName) and (ram:CountrySubDivisionID) and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionID must be present because CountryID is TH.
        </sch:report>
        <sch:report test="ram:CountryID !='TH' and (not((ram:LineOne) and (ram:LineTwo)  and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionName must be present because CountryID is not TH.
        </sch:report>
    </sch:rule>-->

</sch:pattern>

</sch:schema>