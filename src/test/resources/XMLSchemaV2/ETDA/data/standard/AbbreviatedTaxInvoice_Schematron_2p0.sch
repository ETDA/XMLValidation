<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:ns uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:16" prefix="udt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:QualifiedDataType:1" prefix="qdt"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:AbbreviatedTaxInvoice_ReusableAggregateBusinessInformationEntity:2" prefix="ram"/>
    <sch:ns uri="urn:etda:uncefact:data:standard:AbbreviatedTaxInvoice_CrossIndustryInvoice:2" prefix="rsm"/>

<sch:pattern>
    <sch:rule context="/">
        <sch:report test="not(rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice)">No Root Element</sch:report>
    </sch:rule>
    <!-- Check Document Type Code -->
    <sch:rule context="rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice/rsm:ExchangedDocument">
        <sch:report test="not(((ram:TypeCode) = 'T05')or((ram:TypeCode) = 'T06'))">
            ABB-Document-001 รหัสประเภทเอกสาร (TypeCode) ไม่ถูกต้อง 
            (T05 = ใบกำกับภาษีอย่างย่อ, T06 = ใบเสร็จรับเงิน/ใบกำกับภาษีอย่างย่อ)
        </sch:report>
        
   <!--      
        <sch:report test="not(((ram:Name) = 'ใบกำกับภาษีอย่างย่อ') or ((ram:Name) = 'ใบเสร็จรับเงิน/ใบกำกับภาษีอย่างย่อ'))">
            ABB-Document-002 ชื่อประเภทเอกสารไม่ถูกต้อง (ใบกำกับภาษีอย่างย่อ) หรือ (ใบเสร็จรับเงิน/ใบกำกับภาษีอย่างย่อ)
            (Name must equal to ใบกำกับภาษีอย่างย่อ.)
        </sch:report>
        <sch:report test="(((ram:TypeCode) = 'T05')and((ram:Name) != 'ใบกำกับภาษีอย่างย่อ') or ((ram:TypeCode) = 'T06')and((ram:Name) != 'ใบเสร็จรับเงิน/ใบกำกับภาษีอย่างย่อ'))">
            ABB-Document-003 รหัสประเภทเอกสารและชื่อประเภทเอกสารไม่สอดคล้องกัน
            (TypeCode and Name Not Match.)
        </sch:report>
        
  -->
        
    </sch:rule>
    <!-- SellerTradeParty Rule -->
    <sch:rule context="rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
        <sch:report test="not((ram:ID)!='')">
            ABB-SellerTradeParty-001 ต้องระบุชื่อผู้ขาย
            (Name must be present since SellerTradeParty is present.)
        </sch:report>
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            ABB-SellerTradeParty-002 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย
            (SpecifiedTaxRegistration must be present since SellerTradeParty is present.)
        </sch:report>
        <sch:report test="not(ram:PostalTradeAddress)">
            ABB-SellerTradeParty-003 ต้องระบุที่อยู่ของผู้ขาย
            (PostalTradeAddress must be present since SellerTradeParty is present.)
        </sch:report>
    </sch:rule>
    <!-- SellerTradePartyRule/SpecifiedTaxRegistration Rule-->
    <sch:rule context="rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
        <sch:report test="not(ram:SpecifiedTaxRegistration)">
            ABB-SellerTradeParty-002 ต้องระบุเลขประจำตัวผู้เสียภาษีอากรของผู้ขาย
            (SpecifiedTaxRegistration must be present since SellerTradeParty is present.)
        </sch:report>
    </sch:rule>
    
    <!-- SellerTradePartyRule/SpecifiedTaxRegistration Rule-->
    <sch:rule context="rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/SpecifiedTaxRegistration">
        <sch:report test="not(ram:ID)">
            ABB-SellerTradeParty-004 ต้องระบุ ID ของผู้ขาย
           (ID must be present since SellerTradePart/SpecifiedTaxRegistration is present.)
        </sch:report>    
        <sch:report test="not(ram:ID/@schemeID = 'TXID' or ram:ID/@schemeID = 'NIDN' or ram:ID/@schemeID = '' or not(ram:ID/@schemeID) )">
            ABB-SellerTradeParty-005 ต้องมีข้อมูลระบุประเภทของผู้ขายคือ TXID หรือ NIDN.
            (ID must equal to TXID or NIDN.)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = '' or ram:ID/@schemeID = 'TXID' or not(ram:ID/@schemeID) ) and string-length(ram:ID) != 18">
            ABB-SellerTradeParty-006 เลขประจำตัวผู้เสียภาษีอากรของผู้ขาย กรณีระบุ schemeID เป็น TXID ต้องมีจำนวนตัวอักษรเท่ากับ 18 ตัวอักษร เป็นข้อมูลเลขประจำตัว ผู้เสียภาษีอากรสำหรับนิติบุคคล 13 หลักรวมเลขสาขาอีก 5 หลัก
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 18 since schemeID is TXID)
        </sch:report>   
        <sch:report test="(ram:ID/@schemeID = 'NIDN') and string-length(ram:ID) != 13">
            ABB-SellerTradeParty-007 เลขประจำตัวผู้เสียภาษีอากรของผู้ขาย กรณีระบุ schemeID เป็น NIDN ต้องมีจำนวนตัวอักษรเท่ากับ 13 ตัวอักษร เป็นข้อมูลเลขประจำตัวประชาชน 13 หลัก
            (SellerTradeParty/SpecifiedTaxRegistration/ID must length equal to 13 since schemeID is NIDN)
        </sch:report>  
    </sch:rule>
 
    <!-- SellerTradePartyRule/PostalAddress Rule-->
    <sch:rule context="rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress">
        <sch:report test="(not(ram:PostcodeCode) or (ram:PostcodeCode=''))">
            ABB-SellerTradeParty-008 ต้องระบุรหัสไปรษณีย์ผู้ขาย 
            (PostcodeCode must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report> 
        <sch:report test="not(ram:CountryID)">
            ABB-SellerTradeParty-009 ต้องระบุรหัสประเทศผู้ขาย
            (CountryID must be present since SellerTradeParty/PostalAddress is present.)
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not(ram:BuildingNumber) or ram:BuildingNumber='')">
            ABB-SellerTradeParty-010 ต้องระบุ บ้านเลขที่ (BuildingNumber) กรณีรหัสประเทศ (CountryID) ถูกระบุเป็น TH
            (BuildingNumber must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and not(ram:CityName)">
            ABB-SellerTradeParty-011 ต้องระบุ ชื่ออำเภอ (CityName) กรณีรหัสประเทศ (CountryID) ถูกระบุเป็น TH
            (CityName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and not(ram:CitySubDivisionName)">
            ABB-SellerTradeParty-012 ต้องระบุ ชื่อตำบล (CitySubDivisionName) กรณีรหัสประเทศ (CountryID) ถูกระบุเป็น TH
            (CitySubDivisionName must be present since CountryID is TH.)
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and not(ram:CountrySubDivisionID)">
            ABB-SellerTradeParty-013 ต้องระบุ รหัสจังหวัด (CountrySubDivisionID) กรณีรหัสประเทศถูกระบุเป็น TH
            (CountrySubDivisionID must be present since CountryID is TH.)
        </sch:report>
        <!--<sch:report test="ram:CountryID ='TH' and (not((ram:BuildingNumber) and (ram:CityName) and (ram:CitySubDivisionName) and (ram:CountrySubDivisionID) and (ram:PostcodeCode)))">
            BuildingNumber or CityName or CitySubDivisionName or CountrySubDivisionID must be present since CountryID is TH.
        </sch:report>-->
        <sch:report test="ram:CountryID !='TH' and (not(ram:LineOne) or (ram:LineOne=''))">
            ABB-SellerTradeParty-014 ต้องระบุที่อยู่บรรทัดที่ 1 (LineOne) กรณีรหัสประเทศ (CountryID) ไม่ถูกระบุเป็น TH
            (LineOne must be present since CountryID is not TH.)
        </sch:report>
        <sch:report test="ram:CountryID !='TH' and (not(ram:LineTwo) or (ram:LineTwo=''))">
            ABB-SellerTradeParty-015 ต้องระบุที่อยู่บรรทัดที่ 2 (LineTwo) กรณีรหัสประเทศ (CountryID) ไม่ถูกระบุเป็น TH
            (LineTwo must be present since CountryID is not TH.)
        </sch:report>
        <sch:report test="ram:CountryID ='TH' and (not(ram:PostcodeCode) or (ram:PostcodeCode=''))">
            ABB-SellerTradeParty-016 ต้องระบุรหัสไปรณีย์ (PostcodeCode) กรณีรหัสประเทศ (CountryID) ถูกระบุเป็น TH
            (PostcodeCode must be present since CountryID is not TH.)
        </sch:report>
    </sch:rule>
    <!-- ShipFromTradeParty Rule -->
    <!-- Removed 
    <sch:rule context="rsm:AbbreviatedTaxInvoice_CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipFromTradeParty">        
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
   
</sch:pattern>

</sch:schema>