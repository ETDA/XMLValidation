<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:ns uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:16" prefix="udt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:QualifiedDataType:1" prefix="qdt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:TaxInvoice_ReusableAggregateBusinessInformationEntity:2" prefix="ram"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:TaxInvoice_CrossIndustryInvoice:2" prefix="rsm"/>

<sch:pattern>
    <sch:rule context="/">
        <sch:report test="not(rsm:TaxInvoice_CrossIndustryInvoice)">ไม่ผ่านการตรวจสอบเงื่อนไขที่กำหนด (Schematron) เนื่องจากประเภทของเอกสารที่เลือกไม่ตรงกับเอกสารที่นำมาตรวจสอบ</sch:report>
    </sch:rule>
    <!-- Check Document Type Code -->
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:ExchangedDocument">
        <sch:report test="not(((ram:TypeCode) = '388')or((ram:TypeCode) = 'T02')or((ram:TypeCode) = 'T03')or((ram:TypeCode) = 'T04'))">
            TIV-Document-001 รหัสประเภทเอกสาร (TypeCode) ไม่ถูกต้อง 
            (388 = ใบกำกับภาษี,T02 = ใบแจ้งหนี้/ใบกำกับภาษี,T03 = ใบเสร็จรับเงิน/ใบกำกับภาษี,T04 = ใบส่งของ/ใบกำกับภาษี)
            (TypeCode must equal to 388, T02, T03,T04)
        </sch:report>
        
<!--           
        <sch:report test="not(  ((ram:Name) = 'TAX INVOICE') or ((ram:Name) = 'Tax Invoice') or ((ram:Name) = 'Tax invoice') or ((ram:Name) = 'tax invoice') or((ram:Name) = 'ใบแจ้งหนี้/ใบกำกับภาษี')or((ram:Name) = 'ใบเสร็จรับเงิน/ใบกำกับภาษี')or((ram:Name) = 'ใบส่งของ/ใบกำกับภาษี'))">
            TIV-Document-002 ชื่อประเภทเอกสารไม่ถูกต้อง (ใบกำกับภาษี ,ใบแจ้งหนี้/ใบกำกับภาษี ,ใบเสร็จรับเงิน/ใบกำกับภาษี ,ใบส่งของ/ใบกำกับภาษี)
            (Name must equal to ใบกำกับภาษี ,ใบแจ้งหนี้/ใบกำกับภาษี ,ใบเสร็จรับเงิน/ใบกำกับภาษี ,ใบส่งของ/ใบกำกับภาษี.)
        </sch:report>

        <sch:report test="(((ram:TypeCode) = '388')and((ram:Name) != 'ใบกำกับภาษี'))">
            TIV-Document-003 รหัสประเภทเอกสาร (ExchangedDocument/TypeCode) และชื่อประเภทเอกสาร (ExchangedDocument/Name) ไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
        <sch:report test="(((ram:TypeCode) = 'T02')and((ram:Name) != 'ใบแจ้งหนี้/ใบกำกับภาษี'))">
            TIV-Document-003 รหัสประเภทเอกสาร (ExchangedDocument/TypeCode) และชื่อประเภทเอกสาร (ExchangedDocument/Name) ไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
        <sch:report test="(((ram:TypeCode) = 'T03')and((ram:Name) != 'ใบเสร็จรับเงิน/ใบกำกับภาษี'))">
            TIV-Document-003 รหัสประเภทเอกสาร (ExchangedDocument/TypeCode) และชื่อประเภทเอกสาร (ExchangedDocument/Name) ไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
        <sch:report test="(((ram:TypeCode) = 'T04')and((ram:Name) != 'ใบส่งของ/ใบกำกับภาษี'))">
            TIV-Document-003 รหัสประเภทเอกสาร (ExchangedDocument/TypeCode) และชื่อประเภทเอกสาร (ExchangedDocument/Name) ไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
 -->
    </sch:rule>
    
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice">
        <sch:report test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument) and  (((rsm:ExchangedDocument/ram:PurposeCode) != 'TIVC01') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'TIVC02') and ((rsm:ExchangedDocument/ram:PurposeCode) != 'TIVC99') )">
            TIV-Document-004 กรณียกเลิกใบกำกับภาษีเดิม และออกใบกำกับภาษีใหม่ รหัสสาเหตุการออกเอกสาร (PurposeCode) ต้องมีค่าเท่ากับ TIVC01 หรือ TIVC02 หรือ TIVC99
            (PurposeCode must equal to TIVC01, TIVC02,  TIVC99)
        </sch:report>
        <sch:report test="(rsm:ExchangedDocument/ram:PurposeCode = 'TIVC99') and ( not(rsm:ExchangedDocument/ram:Purpose) or (rsm:ExchangedDocument/ram:Purpose = '') )">
            TIV-Document-005 กรณีระบุรหัสสาเหตุการออกเอกสาร (PurposeCode) มีค่าเท่ากับ TIVC99 ต้องระบุสาเหตุการออกเอกสาร (Purpose)
            (Purpose must be present since PurposeCode equals to TIVC99)
        </sch:report>
        <sch:report test="substring(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID,1,13) = substring(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:SpecifiedTaxRegistration/ram:ID,1,13)">
            TIV-Document-006 เลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทนต้องไม่เท่ากับเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must not equal to SellerTradeParty/SpecifiedTaxRegistration/ID.)
        </sch:report>
        
        <!-- Additional Reffe 
        <sch:report test=" (rsm:ExchangedDocument/ram:PurposeCode = 'TIVC01' or rsm:ExchangedDocument/ram:PurposeCode = 'TIVC02' or rsm:ExchangedDocument/ram:PurposeCode = 'TIVC99') 
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = '388' or rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = 'T02' or rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = 'T03' or rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode = 'T04')" > 
            TIV-AdditionalReferencedDocument-001 กรณียกเลิกใบกำกับภาษีเดิม และออกใบกำกับภาษีใหม่ ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ให้มีค่าเป็น 388 หรือ T02 หรือ T03 หรือ T04 เท่านั้น
            (AdditionalReferencedDocument must be equal to  388 or T02 or T03 or T04 since PurposeCode is present.)
        </sch:report> -->
        <!-- Additional Reffe
        <sch:report test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument)">
             have AdditionalReferencedDocument !!
        </sch:report> -->
        <sch:report test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument) and (not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = '388']) 
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T02'])
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T03'])
            and not(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T04'])
            )" > 
            TIV-AdditionalReferencedDocument-001 กรณียกเลิกใบกำกับภาษีเดิม และออกใบกำกับภาษีใหม่ ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ให้มีค่าเป็น 388 หรือ T02 หรือ T03 หรือ T04 เท่านั้น
            (AdditionalReferencedDocument must be equal to  388 or T02 or T03 or T04 since PurposeCode is present.)
        </sch:report>
        
    </sch:rule>
    <!--
    <sch:rule context="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement">
        <sch:report test="not(ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = '388']) and not(ram:AdditionalReferencedDocument[ram:ReferenceTypeCode = 'T02'])" > 
            TIV-AdditionalReferencedDocument-001 กรณียกเลิกใบกำกับภาษีเดิม และออกใบกำกับภาษีใหม่ ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ให้มีค่าเป็น 388 หรือ T02 หรือ T03 หรือ T04 เท่านั้น
            (AdditionalReferencedDocument must be equal to  388 or T02 or T03 or T04 since PurposeCode is present.)
        </sch:report>
    </sch:rule>-->
    
    <!-- SellerTradeParty Rule -->
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
       <sch:report test="not((ram:Name)!='')">
            TIV-SellerTradeParty-001 ต้องระบุชื่อผู้ขาย
            (Name must be present since SellerTradeParty is present.)
        </sch:report> 
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            TIV-SellerTradeParty-002  ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (SpecifiedTaxRegistration)
            (SpecifiedTaxRegistration must be present since SellerTradeParty is present.)
        </sch:report>
    </sch:rule>
    
    <!-- SellerTradePartyRule/DefinedTradeContact Rule
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedCITradeContact">
        <sch:report test="ram:PersonName">
            PersonName is not allowed since SellerTradeParty/DefinedCITradeContact is present.
        </sch:report>
        <sch:report test="ram:DepartmentName">
            DepartmentName is not allowed since SellerTradeParty/DefinedCITradeContact is present.
        </sch:report>
        <sch:report test="ram:TelephoneCIUniversalCommunication">
            TelephoneCIUniversalCommunication is not allowed since SellerTradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule> -->
    
    <!-- SellerTradePartyRule/SpecifiedTaxRegistration Rule-->

    
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration">   
        <sch:report test="not((ram:ID)!='')">
            TIV-SellerTradeParty-003 ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (SpecifiedTaxRegistration/ID)
            (ID must be present since SellerTradePart/SpecifiedTaxRegistration)
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or not(ram:ID/@schemeID) )">
            TIV-SellerTradeParty-004 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN เท่านั้น
            (schemeID must equal to TXID or NIDN.)
        </sch:report>  
        
        <sch:report test="(ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID'  or not(ram:ID/@schemeID)) and string-length(ram:ID) != 18">
            TIV-SellerTradeParty-005 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID.)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            TIV-SellerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN.)
        </sch:report>  
    </sch:rule>
    
    <!-- SellerTradePartyRule/PostalAddress Rule-->
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5))">
            TIV-SellerTradeParty-007 ต้องระบุรหัสไปรษณีย์ผู้ขาย มีจำนวนตัวเลขเท่ากับ 5 หลัก
            (PostcodeCode must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="not(ram:CountryID) or ram:CountryID !='TH' ">
            TIV-SellerTradeParty-008 ต้องระบุรหัสประเทศผู้ขาย ต้องมีค่าเท่ากับ TH เท่านั้น 
            (CountryID must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report>
        <sch:report test="(not(ram:BuildingNumber) or ram:BuildingNumber='')">
            TIV-SellerTradeParty-009 ต้องระบุ บ้านเลขที่ (BuildingNumber) 
            (BuildingNumber must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CityName) or ram:CityName='')">
            TIV-SellerTradeParty-010 ต้องระบุ ชื่ออำเภอ (CityName) 
            (CityName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CitySubDivisionName) or ram:CitySubDivisionName='')">
            TIV-SellerTradeParty-011 ต้องระบุ ชื่อตำบล (CitySubDivisionName) 
            (CitySubDivisionName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="(not(ram:CountrySubDivisionID) or ram:CountrySubDivisionID='')">
            TIV-SellerTradeParty-012 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) 
            (CountrySubDivisionID must be present since CountryID is TH.)
        </sch:report>
        <!--<sch:report test="ram:CountryID ='TH' and (not((ram:BuildingNumber) and (ram:CityName) and (ram:CitySubDivisionName) and (ram:CountrySubDivisionID) and (ram:PostcodeCode)))">
            BuildingNumber or CityName or CitySubDivisionName or CountrySubDivisionID must be present since CountryID is TH.
        </sch:report>-->
        <!--
        <sch:report test="ram:CountryID !='TH' and (not(ram:LineOne) or (ram:LineOne=''))">
            TIV-SellerTradeParty-014 ต้องระบุที่อยู่บรรทัดที่ 1 (LineOne) กรณีรหัสประเทศ (CountryID) ไม่ถูกระบุเป็น TH
            (LineOne must be present since CountryID is not TH.)
        </sch:report>
        <sch:report test="ram:CountryID !='TH' and (not(ram:LineTwo) or (ram:LineTwo=''))">
            TIV-SellerTradeParty-015 ต้องระบุที่อยู่บรรทัดที่ 2 (LineTwo) กรณีรหัสประเทศ (CountryID) ไม่ถูกระบุเป็น TH
            (LineTwo must be present since CountryID is not TH.)
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not(ram:PostcodeCode) or (ram:PostcodeCode=''))">
            TIV-SellerTradeParty-016 ต้องระบุรหัสไปรณีย์ (PostcodeCode) กรณีรหัสประเทศ (CountryID) ถูกระบุเป็น TH
            (PostcodeCode must be present since CountryID is not TH.)
        </sch:report>
        -->
    </sch:rule>
    
    <!-- BuyerTradeParty Rule -->
   <!-- <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty">
        <sch:report test="not(ram:Name)">
            
            Name must be present since BuyerTradeParty is present.
        </sch:report>
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            TIV-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            SpecifiedTaxRegistration must be present since BuyerTradeParty is present.
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            PostalTradeAddress must be present since BuyerTradeParty is present.
        </sch:report>
    </sch:rule>-->
    
    <!-- BuyerTradeParty/SpecifiedTaxRegistration Rule-->
    
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty">
        <!-- 
        <sch:report test="not((ram:Name)!='')">
            TIV-BuyerTradeParty-001 ต้องระบุชื่อผู้ซื้อ
            (Name must be present since BuyerTradeParty is present.)
        </sch:report>
        -->
        
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            TIV-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            (ID must be present since BuyerTradeParty/SpecifiedTaxRegistration is present.)
        </sch:report>
        <!--
        <sch:report test="not(ram:PostalTradeAddress)">
            TIV-BuyerTradeParty-003 ต้องระบุที่อยู่ของผู้ซื้อ
            (PostalTradeAddress must be present since BuyerTradeParty is present.)
        </sch:report>
        -->
    </sch:rule>
    
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration">
         
        <sch:report test="not((ram:ID)!='')">
            TIV-BuyerTradeParty-001 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ
            (ID must be present since BuyerTradeParty/SpecifiedTaxRegistration is present)
        </sch:report>   
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or ram:ID/@schemeID = 'CCPT' or ram:ID/@schemeID = 'OTHR' or not(ram:ID/@schemeID) )">
            TIV-BuyerTradeParty-002 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN หรือ CCPT หรือ OTHR เท่านั้น
            (schemeID must equal to TXID or NIDN or CCPT or OTHR.)
        </sch:report>   
        <!-- TXID NIDN CCPT OTHR -->
        <sch:report test="(ram:ID)!='' and (ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID'  or not(ram:ID/@schemeID) ) and string-length(ram:ID) != 18">
            TIV-BuyerTradeParty-003 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 because schemeID is TXID.)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            TIV-BuyerTradeParty-004 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 because schemeID is NIDN.)
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'CCPT') and string-length(ram:ID) > 35">
            TIV-BuyerTradeParty-005 กรณีระบุประภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น CCPT ต้องมีจำนวนตัวอักษรไม่เกิน 35 ตัวอักษร
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must length equal to 35 because schemeID is CCPT.)
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'OTHR') and ram:ID != 'N/A' ">
            TIV-BuyerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ (schemeID) เป็น OTHR ต้องระบุค่าเป็น N/A
            (BuyerTradeParty/SpecifiedTaxRegistration/ID must be N/A because schemeID is OTHR.)
        </sch:report> 
    </sch:rule>
    <!-- BuyerTradePartyRule/DefinedTradeContact Rule
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:PersonName">
            PersonName is not allowed since BuyerTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:DepartmentName">
            DepartmentName is not allowed since BuyerTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:TelephoneUniversalCommunication">
            TelephoneUniversalCommunication is not allowed since BuyerTradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule>-->
    
    <!-- BuyerTradePartyRule/PostalAddress Rule-->

    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress">
             <sch:report test="not(((ram:LineOne) and ram:LineOne !='')) and not(((ram:BuildingNumber) and ram:BuildingNumber !='') and ((ram:CityName) and ram:CityName !='') and ((ram:CitySubDivisionName) and ram:CitySubDivisionName !='') and ((ram:CountrySubDivisionID) and ram:CountrySubDivisionID !=''))">
                 TIV-BuyerTradeParty-007 ต้องระบุที่อยู่ของผู้ซื้อ เป็นแบบมีโครงสร้าง (ประกอบด้วย บ้านเลขที่ ตำบล อำเภอ จังหวัด) หรือ แบบไม่มีโครงสร้าง (ประกอบด้วยข้อมูล ที่อยู่บบรรทัดที่ 1 (LineOne) เป็นอย่างน้อย)
                 (BuyerTradeParty/PostalTradeAddress must be specified in unstructured  or structured format.)
             </sch:report>
        
            <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5)) and ram:CountryID ='TH'">
            TIV-BuyerTradeParty-008 กรณีระบุค่าของ CountryID เท่ากับ TH ต้องระบุรหัสไปรษณีย์ผู้ซื้อ จำนวนตัวเลขเท่ากับ 5 หลัก
                (PostcodeCode must be present since BuyerTradeParty/PostalAddress is present.)
            </sch:report>   
        
        <sch:report test="not(ram:CountryID) or ram:CountryID =''">
            TIV-BuyerTradeParty-009 ต้องระบุรหัสประเทศของผู้ซื้อ  
                (CountryID must be present since BuyerTradeParty/PostalAddress is present.)
            </sch:report> 
            
         
    </sch:rule>
    
    <!-- AdditionalReferencedDocument Rule @09022017-->
    <!--  <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument">
        <sch:report test="not(ram:IssuerAssignedID and ram:IssueDateTime and ram:ReferenceTypeCode)">
            AdditionalReferencedTIV-Document-001 เอกสารอ้างอิงต้องมีข้อมูลเลขที่เอกสาร, วันเดือนปีที่ออกและรหัสระบุประเภทเอกสารอ้างอิง
            (IssuerAssignedID, ram:IssueDateTime and ram:ReferenceTypeCode must be present since AdditionalReferencedDocument is present.)
            
        </sch:report>
    </sch:rule> -->
    
    <!-- <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice"> not(((ram:TypeCode) = '388')or((ram:TypeCode) = 'T02')or((ram:TypeCode) = 'T03')or((ram:TypeCode) = 'T04')) -->
        <!-- <sch:report test=" ( (rsm:ExchangedDocument/ram:PurposeCode = 'TIVC01' or rsm:ExchangedDocument/ram:PurposeCode = 'TIVC02' or rsm:ExchangedDocument/ram:PurposeCode = 'TIVC99') 
            and (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument != '388' and rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode != 'T02' and rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode != 'T03' and rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode != 'T04'))" > 
            TIV-AdditionalReferencedDocument-001 กรณียกเลิกใบกำกับภาษีเดิม และออกใบกำกับภาษีใหม่ ต้องระบุรหัสเอกสารอ้างอิง (AdditionalReferencedDocument) ให้มีค่าเป็น 388 หรือ T02 หรือ T03 หรือ T04 เท่านั้น
            (AdditionalReferencedDocument must be equal to  388 or T02 or T03 or T04 since PurposeCode is present.)
        </sch:report>
    </sch:rule> -->
    
    
    
       <!-- ShipToTradeParty Rule @09022017-->
    <!--<sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:DefinedTradeContact">
        <sch:report test="ram:EmailURIUniversalCommunication">
            EmailURIUniversalCommunication is not allowed since ShipToTradeParty/DefinedTradeContact is present.
        </sch:report>
    </sch:rule>-->
    
    <!-- ShipFromTradeParty Rule -->
   <!-- Removed 
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipFromTradeParty">        
        <sch:report test="ram:SpecifiedTaxRegistration">
            SpecifiedTaxRegistration is not allowed since ShipFromTradeParty/SpecifiedTaxRegistration is present.
        </sch:report>
        <sch:report test="ram:DefinedTradeContact">
            DefinedTradeContact is not allowed since ShipFromTradeParty/DefinedTradeContact is present.
        </sch:report>
        <sch:report test="ram:PostalTradeAddress">
            PostalTradeAddress is not allowed since ShipFromTradeParty/PostalTradeAddress is present.
        </sch:report>        
    </sch:rule>
    -->
    <!-- ApplicationTradeTax Rule @09022017-->
  <!--
 <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
        <sch:report test="not(ram:TypeCode)">
            TypeCode must be present since ApplicableTradeTax is present.
        </sch:report>
        <sch:report test="not(ram:CalculatedRate)">
            CalculatedRate must be present since ApplicableTradeTax is present.
        </sch:report>
        <sch:report test="not(ram:BasisAmount)">
            BasisAmount mustbe present since ApplicableTradeTax is present.
        </sch:report>
        <sch:report test="not(ram:CalculatedAmount)">
            CalculatedAmount mustbe present since ApplicableTradeTax is present.
        </sch:report>
    </sch:rule>
 -->   
    
    <!-- InvoicerTradeParty Rule @09022017-->
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty">
        <sch:report test="not((ram:Name)!='')">
            TIV-InvoicerTradeParty-001 ต้องระบุชื่อผู้ออกเอกสารแทน
            (Name must be present since InvoicerTradeParty is present.)
        </sch:report>
        
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            TIV-InvoicerTradeParty-002  ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (SpecifiedTaxRegistration)
            (SpecifiedTaxRegistration must be present since InvoicerTradeParty is present.)
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            TIV-InvoicerTradeParty-003 ต้องระบุที่อยู่ของผู้ออกเอกสารแทน
            (PostalTradeAddress must be present since InvoicerTradeParty is present.)
        </sch:report>
    </sch:rule>
    
    <!-- InvoicerTradeParty/SpecifiedTaxRegistration Rule @09022017-->
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:SpecifiedTaxRegistration">
        
            <sch:report test="not((ram:ID)!='')">
                TIV-InvoicerTradeParty-004 ต้องระบุข้อมูลเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (SpecifiedTaxRegistration/ID)
                (ID must be present since InvoicerTradePart/SpecifiedTaxRegistration.)
            </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = ''  or not(ram:ID/@schemeID) )">
            TIV-InvoicerTradeParty-005 ต้องระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID)  และต้องมีค่าเป็น TXID หรือ NIDN เท่านั้น
            (schemeID must equal to TXID or NIDN.)
            </sch:report>   
        <sch:report test="(ram:ID) and (ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID'  or not(ram:ID/@schemeID) ) and string-length(ram:ID) != 18">
            TIV-InvoicerTradeParty-006 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID) เป็น TXID ต้องมีจำนวนตัวเลขเท่ากับ 18 หลัก (เลขประจำตัวผู้เสียภาษีอากร 13 หลัก และเลขสาขา 5 หลัก)
            (InvoicerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID)
            </sch:report>   
            <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
                TIV-InvoicerTradeParty-007 กรณีระบุประเภทเลขประจำตัวผู้เสียภาษีอากรของผู้ออกเอกสารแทน (schemeID) เป็น NIDN ต้องมีจำนวนตัวเลขเท่ากับ 13 หลัก (เลขประจำตัวประชาชน 13 หลัก)
                (InvoicerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN.)
            </sch:report>  
    </sch:rule>
    
    <!-- InvoicerTradeParty/PostalAddress Rule @09022017-->
    <sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode='') or (string-length(ram:PostcodeCode) != 5))">
                TIV-InvoicerTradeParty-008 ต้องระบุรหัสไปรษณีย์ผู้ออกเอกสารแทน มีจำนวนตัวเลขเท่ากับ 5 หลัก
                (PostcodeCode must be present since InvoicerTradeParty/PostalAddress is present.)
            </sch:report> 
            <sch:report test="not(ram:CountryID) or ram:CountryID !='TH' ">
                TIV-InvoicerTradeParty-009 ต้องระบุรหัสประเทศผู้ออกเอกสารแทน ต้องมีค่าเท่ากับ TH เท่านั้น
                (CountryID must be present since InvoicerTradeParty/PostalAddress is present.)
            </sch:report>
            <sch:report test="(not(ram:BuildingNumber) or ram:BuildingNumber='')">
                TIV-InvoicerTradeParty-010 ต้องระบุ บ้านเลขที่ (BuildingNumber) 
                (BuildingNumber must be present since CountryID is TH.)
            </sch:report>
        <sch:report test="(not(ram:CityName) or ram:CityName='')">
                TIV-InvoicerTradeParty-011 ต้องระบุ ชื่ออำเภอ (CityName) 
                (CityName must be present since CountryID is TH.)
            </sch:report>
        <sch:report test="(not(ram:CitySubDivisionName) or ram:CitySubDivisionName='')">
                TIV-InvoicerTradeParty-012 ต้องระบุ ชื่อตำบล (CitySubDivisionName) 
                (CitySubDivisionName must be present since CountryID is TH.)
            </sch:report>
        <sch:report test="(not(ram:CountrySubDivisionID) or ram:CountrySubDivisionID='')">
                TIV-InvoicerTradeParty-013 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) 
                (CountrySubDivisionID must be present since CountryID is TH.)
            </sch:report>
            
    </sch:rule>
    
    <!-- InvoiceeTradeParty Rule @09022017-->
    <!--<sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty">
        <sch:report test="not(ram:Name)">
            Name must be present since SellerTradeParty is present.
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
    <!--<sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty/SpecifiedTaxRegistration">
        
        <sch:report test="not(ram:ID)">
            ID must be present since SellerTradePart/SpecifiedTaxRegistration
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or ram:ID/@schemeID = 'CCPT' or ram:ID/@schemeID = 'OTHR')">
            ID must equal to TXID or NIDN or CCPT or OTHR.
        </sch:report>   -->
        <!-- TXID NIDN CCPT OTHR -->
        <!--<sch:report test="(ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID') and string-length(ram:ID) != 18">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'CCPT') and string-length(ram:ID) != 18">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is CCPT
        </sch:report> 
        <sch:report test="(ram:ID/@schemeID = 'OTHR') and string-length(ram:ID) > 64">
            SellerTradeParty/SpecifiedTaxRegistration/ID must length less than or equal to 64 since schemeID is OTHR
        </sch:report> 
    </sch:rule>-->
    
    <!-- InvoicerTradeParty/PostalAddress Rule@09022017-->
    <!--<sch:rule context="rsm:TaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:InvoiceeTradeParty/ram:PostalTradeAddress">
        <sch:report test="not(ram:CountryID)">
            CountryID must be present since SellerTradeParty/PostalAddress is present.
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not((ram:CityName) and (ram:CitySubDivisionName) and (ram:CountrySubDivisionID) and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionID must be present since CountryID is TH.
        </sch:report>
        <sch:report test="ram:CountryID !='TH' and (not((ram:LineOne) and (ram:LineTwo)  and (ram:PostcodeCode)))">
            BuildingName or CityName or CitySubDivisionName or CountrySubDivisionName must be present since CountryID is not TH.
        </sch:report>
    </sch:rule>-->
    
</sch:pattern>

</sch:schema>