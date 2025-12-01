Report 60140 "SSD_Sales Invoice"
{
    DefaultLayout = RDLC;
    Caption = 'Sales Invoice';
    RDLCLayout = './Layouts/Sales Invoice new_.rdl';
    UseSystemPrinter = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(LocationToAddr_1; LocationToAddr[1])
            {
            }
            column(LocationToAddr_2; LocationToAddr[2])
            {
            }
            column(AllowPrintOnSI; AllowPrintOnSI)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyHeadPic; CompanyInfo."New Logo1")
            {
            }
            column(CINNoTxt; CINNoTxt)
            {
            }
            column(GSTINTxt; GSTINTxt)
            {
            }
            column(PANTxt; PANTxt)
            {
            }
            column(ReportForNavId_1000000257;1000000257)
            {
            }
            column(QR_Code; "QR Code")
            {
            }
            // column(Structure_;"Sales Invoice Header".Structure)
            // {
            // }
            column(Remarks_ALL; Remarks_ALL)
            {
            }
            column(ShipToCode1; "Ship-to Code")
            {
            }
            column(SellTo_GSTReg; reccust."GST Registration No.")
            {
            }
            column(TaxPayableonOnReverseCharges; TaxPayableonOnReverseCharge)
            {
            }
            column(InvNoNew; "Sales Invoice Header"."No.")
            {
            }
            column(ShipToAddr_8_;'Packing : TOTAL ' + Format(TotalPack) + ' PKGS ( GWT ' + Format(TotalWeight) + ' KGS ) ' + '     PKG Slip No.: ' + PackingSlipNo)
            {
            }
            column(ShipToAddr_1_; ShipToAddr[1])
            {
            }
            column(ShipToAddr_2_; ShipToAddr[2])
            {
            }
            column(ShipToAddr_3_; ShipToAddr[3])
            {
            }
            column(ShipToAddr_4_; ShipToAddr[4])
            {
            }
            column(ShipToAddr_5_; ShipToAddr[5])
            {
            }
            column(PlaceOfSupply; PlaceOfSupply)
            {
            }
            column(PlaceOfDelivery; PlaceOfDelivery)
            {
            }
            column(ShipToGST; ShipToGST)
            {
            }
            column(AppliedtoInsurancePolicy_SalesInvoiceHeader; "Sales Invoice Header"."Applied to Insurance Policy")
            {
            }
            column(Sales_Invoice_Line__Amount; "Sales Invoice Line".Amount)
            {
            }
            // column(Sales_Invoice_Line___BED_Amount_;"Sales Invoice Line"."BED Amount")
            // {
            // }
            // column(Sales_Invoice_Line___SHE_Cess_Amount_;"Sales Invoice Line"."SHE Cess Amount")
            // {
            // }
            // column(Sales_Invoice_Line___eCess_Amount_;"Sales Invoice Line"."eCess Amount")
            // {
            // }
            // column(Sales_Invoice_Line__Amount__Sales_Invoice_Line___Excise_Amount_;"Sales Invoice Line".Amount+"Sales Invoice Line"."Excise Amount")
            // {
            // }
            column(FreightAmt; FreightAmt)
            {
            }
            // column(Sales_Invoice_Line___Tax_Amount_;"Sales Invoice Line"."Tax Amount")
            // {
            //     DecimalPlaces = 2:2;
            // }
            column(ForAmt; ForAmt)
            {
            }
            column(PaymentDescr_; PaymentTerms.Description)
            {
            }
            // column(Sales_Invoice_Line___Amount_To_Customer__SaleInvLine__Line_Amount_;"Sales Invoice Line"."Amount To Customer"+SaleInvLine."Line Amount")
            // {
            // }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Vehicle_No__; "Sales Invoice Header"."Vehicle No.")
            {
            }
            column(ShipmentMethod_Description_Control1000000061; ShipmentMethod.Description)
            {
            }
            column(NoInText_1_; NoInText[1])
            {
            }
            column(ExInText_1_; ExInText[1])
            {
            }
            column(TotalGstAMountintext; TotalGstAMountintext[1])
            {
            }
            column(bool; bool)
            {
            }
            column(Assessable_Value_;'Assessable Value')
            {
            }
            column(BED1; BED1)
            {
            }
            column(Ecess; Ecess)
            {
            }
            column(SHE; SHE)
            {
            }
            column(TaxText; TaxText)
            {
            }
            column(BedAmt; BedAmt)
            {
            }
            column(ECessAmounst; ECessAmount)
            {
            }
            column(SheCessAmount; SheCessAmount)
            {
            }
            column(TaxableAmount_1; TaxableAmount)
            {
            }
            column(SaleInvLine__Line_Amount_; SaleInvLine."Line Amount")
            {
            }
            column(Ship_To__;'Ship To:')
            {
            }
            column(ShipToAddr_6__Control1000000076; ShipToAddr[6])
            {
            }
            column(ShippingAgent_Name; ShippingAgent.Name)
            {
            }
            column(Remarks______Comments_1__________Comments_2_;'Remarks: ' + Comments[1] + ' ' + Comments[2])
            {
            }
            column(Sales_Invoice_Header__ST38_No_; "ST38 No")
            {
            }
            column(Sales_Invoice_Hesader__Customer_Road_Permit_No__; "Customer Road Permit No.")
            {
            }
            column(Taxable_AmountCaption; Taxable_AmountCaptionLbl)
            {
            }
            column(FreightCaption; FreightCaptionLbl)
            {
            }
            column(ForwardingCaption; ForwardingCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(TransportCaption; TransportCaptionLbl)
            {
            }
            column(Vehicle_NoCaption; Vehicle_NoCaptionLbl)
            {
            }
            column(Frt_BasisCaption; Frt_BasisCaptionLbl)
            {
            }
            column(Total_DutyCaption; Total_DutyCaptionLbl)
            {
            }
            column(Inv_ValueCaption; Inv_ValueCaptionLbl)
            {
            }
            column(RoundingCaption; RoundingCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__ST38_No_Caption; FieldCaption("ST38 No"))
            {
            }
            column(Customer_Road_Permit_No_Caption; Customer_Road_Permit_No_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(CrossRefValue; CrossRefValue)
            {
            }
            column(PackingTotalDes_;'Packing : TOTAL ' + Format(TotalPack) + ' PKGS ( GWT ' + Format(Round(TotalWeight, 0.01, '=')) + ' KGS ) ' + '     PKG Slip No.: ' + PackingSlipNo)
            {
            }
            column(TotalWeight; TotalWeight)
            {
            }
            column(Sales_Invoice_Header___Sell_to_Customer_No__; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(ShipToAddr_1__Control126; ShipToAddr[1])
            {
            }
            column(ShipToAddr_2__Control127; ShipToAddr[2])
            {
            }
            column(ShipToAddr_3__Control128; ShipToAddr[3])
            {
            }
            column(ShipToAddr_4__Control129; ShipToAddr[4])
            {
            }
            column(ShipToAddr_5__Control130; ShipToAddr[5])
            {
            }
            column(ShipToAddr_6_; ShipToAddr[6])
            {
            }
            column(ShipToAddr_7_; ShipToAddr[7])
            {
            }
            column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
            {
            }
            column(Sales_Invoice_Header___Sell_to_Customer_No__Caption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
            {
            }
            // column(GrandAmount;"Sales Invoice Header"."Amount to Customer")
            // {
            // }
            column(IRN_; EInvoicingRequest."IRN No.")
            {
            }
            column(QRImage; EInvoicingRequest."QR Image")
            {
            }
            column(TotalGST; TotalGST)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_1000000212;1000000212)
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(OrgDupliText; OrgDupliText)
                {
                }
                column(TCS_Amount; TCS_Amount)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(ReportForNavId_1000000211;1000000211)
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_; Format("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(CompanyInfo2Picture; Cust3."QR Code")
                    {
                    }
                    column(CompanyInfo3Picture; QRCodeStr.QRCode)
                    {
                    }
                    column(CompanyInfo1Picture; Cust3."QR Code")
                    {
                    }
                    column(Sales_Invoice_Header___No__; InvNoNew)
                    {
                    }
                    column(DataItem1000000202; Format("Sales Invoice Header"."Gate Out Date"))
                    {
                    }
                    column(ExciseTarrifNos_1_________ExciseTarrifNos_2_; ExciseTarrifNos[1] + '/' + ExciseTarrifNos[2])
                    {
                    }
                    column(OrderNoNew_______FORMAT__Sales_Invoice_Header___Order_Date__; OrderNoNew + '/ ' + Format("Sales Invoice Header"."Order Date"))
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_City_; "Sales Invoice Header"."Ship-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')')
                    {
                    }
                    column(PaymentTerms_Description_Control1000000009; PaymentTerms.Description)
                    {
                    }
                    column(Sales_Invoice_Header___Applied_to_Insurance_Policy_; "Sales Invoice Header"."Applied to Insurance Policy")
                    {
                    }
                    column(Cust_Contact; Cust.Contact)
                    {
                    }
                    column(Cust__Phone_No__; Cust."Phone No.")
                    {
                    }
                    // column(Cust__C_S_T__No__;Cust."C.S.T. No.")
                    // {
                    // }
                    column(CustPANNo; Cust."P.A.N. No.")
                    {
                    }
                    // column(BillTo__T_I_N__No__;BillTo."T.I.N. No.")
                    // {
                    // }
                    column(BillTo__E_C_C__No__; reccust1."GST Registration No.")
                    {
                    }
                    column(Cust__Our_Account_No__; Cust."Our Account No.")
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(Sales_Invoice_Header___External_Doc__Date_; "Sales Invoice Header"."External Doc. Date")
                    {
                    }
                    column(ExciseTarrifNos_3_________ExciseTarrifNos_4_; ExciseTarrifNos[3] + '/' + ExciseTarrifNos[4])
                    {
                    }
                    column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_Caption; Sales_Invoice_Header___Posting_Date_CaptionLbl)
                    {
                    }
                    column(Removal_Date_TimeCaption; Removal_Date_TimeCaptionLbl)
                    {
                    }
                    column(Excise_Tarrif_No_Caption; Excise_Tarrif_No_CaptionLbl)
                    {
                    }
                    column(WO_No____DateCaption; WO_No____DateCaptionLbl)
                    {
                    }
                    column(DestinationCaption; DestinationCaptionLbl)
                    {
                    }
                    column(Payment_TermsCaption; Payment_TermsCaptionLbl)
                    {
                    }
                    column(Goods_insured_under_BAGICL_Marine_Cargo_Caption; Goods_insured_under_BAGICL_Marine_Cargo_CaptionLbl)
                    {
                    }
                    column(Insurance_Policy_No_Caption; Insurance_Policy_No_CaptionLbl)
                    {
                    }
                    column(CTC_Caption; CTC_CaptionLbl)
                    {
                    }
                    column(Phone_NoCaption; Phone_NoCaptionLbl)
                    {
                    }
                    column(ST_NoCaption; ST_NoCaptionLbl)
                    {
                    }
                    column(ECC_No_Caption; ECC_No_CaptionLbl)
                    {
                    }
                    column(P_O__No_Caption; P_O__No_CaptionLbl)
                    {
                    }
                    column(TIN_No_Caption; TIN_No_CaptionLbl)
                    {
                    }
                    column(V__CodeCaption; V__CodeCaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number)where(Number=filter(1..));

                        column(ReportForNavId_1000000169;1000000169)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; DimensionLoop1.Number)
                        {
                        }
                        column(DimText_Control98; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                //IF NOT PostedDocDim1.FIND('-') THEN // BIS 1145
                                CurrReport.Break();
                            end
                            else if not Continue then CurrReport.Break();
                            Clear(DimText);
                            Continue:=false;
                        /* // BIS 1145 <<
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    MESSAGE(' // BIS 1145') // BIS 1145
                                    //DimText := STRSUBSTNO(
                                      //'%1 %2',PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code") // BIS 1145
                                  ELSE
                                    MESSAGE(' // BIS 1145'); // BIS 1145
                                    //DimText :=  // BIS 1145
                                      //STRSUBSTNO(  // BIS 1145
                                        //'%1, %2 %3',DimText,  // BIS 1145
                                        //PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code");// BIS 1145
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL (PostedDocDim1.NEXT = 0);
                                */
                        // BIS 1145 >>
                        end;
                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.")where(Quantity=filter(<>0));

                        column(Per_CGST; Per_CGST)
                        {
                        }
                        column(Per_SGST; Per_SGST)
                        {
                        }
                        column(Per_IGST; Per_IGST)
                        {
                        }
                        column(CGST_Amt; CGST_Amt)
                        {
                        }
                        column(IGST_Amt; IGST_Amt)
                        {
                        }
                        column(SGST_Amt; SGST_Amt)
                        {
                        }
                        column(ReportForNavId_1000000164;1000000164)
                        {
                        }
                        column(desc1; desc1)
                        {
                        }
                        column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(AmountInWords; AmountInWords[1])
                        {
                        }
                        column(ShipmentDate_SalesInvoiceLine; "Sales Invoice Line"."Shipment Date")
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount_; "Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(HSN; "HSN/SAC Code")
                        {
                        }
                        column(Sales_Invoice_Line_Description; desc)
                        {
                        }
                        // column(GSTBaseAmount_SalesInvoiceLine;"Sales Invoice Line"."GST Base Amount")
                        // {
                        // }
                        column(Sales_Invoice_Line__No__; SrNo)
                        {
                        }
                        // column(CGSTAMT;"Total GST Amount")
                        // {
                        // }
                        column(Sales_Invoice_Line_Description_Control65; "No." + '-' + desc)
                        {
                        }
                        column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                        {
                        }
                        column(GSTText; GSTText2 + GSTText3 + ' ' + GSTText1)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                        DecimalPlaces = 2: 5;
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure Code")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control70; "Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Description_2_; "Description 2")
                        {
                        }
                        // column(TaxableAmount;Amount+"Excise Amount")
                        // {
                        // }
                        // column(TaxAmount;"Tax Amount")
                        // {
                        // }
                        column(PackDesc_1_; PackDesc[1])
                        {
                        }
                        column(PackDesc_2_; PackDesc[2])
                        {
                        }
                        column(PackDescQty_1_; PackDescQty[1])
                        {
                        }
                        column(PackDescQty_2_; PackDescQty[2])
                        {
                        }
                        column(PackDescQty_3_; PackDescQty[3])
                        {
                        }
                        column(PackDesc_3_; PackDesc[3])
                        {
                        }
                        column(PackDescQty_4_; PackDescQty[4])
                        {
                        }
                        column(PackDesc_4_; PackDesc[4])
                        {
                        }
                        column(FORMAT_DespLine__Actual_Wt_____KGS___;'( ' + Format(DespLine."Actual Wt") + ' KGS )')
                        {
                        }
                        column(RecCrossReference__Cross_Reference_No__; RecCrossReferenceNo)
                        {
                        }
                        column(FORMAT_ROUND_Item2__Net_Weight___Sales_Invoice_Line__Quantity_0_01_________KGS___;'( ' + Format(ROUND(Item2."Net Weight" * "Sales Invoice Line".Quantity, 0.01, '=')) + ' KGS )')
                        {
                        }
                        // column(Ref_____FORMAT__Source_Document_Type__0_;'Ref: '+ Format("Source Document Type",0))
                        // {
                        // }
                        // column(Sales_Invoice_Line__Source_Document_No__;"Source Document No.")
                        // {
                        // }
                        // column(Supplementary;Supplementary)
                        // {
                        // }
                        column(Sales_Invoice_Line__Line_Amount__Control86; "Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_;-"Inv. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control99; "Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(FixedRows; FixedRows)
                        {
                        }
                        column(RowsCount; RowsCount)
                        {
                        }
                        column(Sales_Invoice_Line_Amount; Amount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        // column(Sales_Invoice_Line__Amount_Including_VAT_;"Amount To Customer")
                        // {
                        //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        // column(Sales_Invoice_Line__Excise_Amount_;"Excise Amount")
                        // {
                        //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        // column(Sales_Invoice_Line__Tax_Amount_;"Tax Amount")
                        // {
                        //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___Total_TDS_TCS_Incl__SHE_CESS_; TotalTCSAmount)
                        {
                        }
                        column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(TotalTaxAmt; TotalTaxAmt)
                        {
                        }
                        column(TotalExciseAmt; TotalExciseAmt)
                        {
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__;-("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Header___VAT_Base_Discount___; "Sales Invoice Header"."VAT Base Discount %")
                        {
                        AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                        {
                        AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control60; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control61; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(Amount_Including_VAT____Amount_Control62; "Amount Including VAT" - Amount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Amount_Control63; Amount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Amount_Including_VAT__Control71; "Amount Including VAT")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control72; TotalExclVATText)
                        {
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                        }
                        column(Sales_Invoice_Line__No__Caption; Sales_Invoice_Line__No__CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Description_Control65Caption; Sales_Invoice_Line_Description_Control65CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_QuantityCaption; Sales_Invoice_Line_QuantityCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(No___Description_of_PackagesCaption; No___Description_of_PackagesCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control85; ContinuedCaption_Control85Lbl)
                        {
                        }
                        column(Inv__Discount_Amount_Caption; Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__Excise_Amount_Caption; Sales_Invoice_Line__Excise_Amount_CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__Tax_Amount_Caption; Sales_Invoice_Line__Tax_Amount_CaptionLbl)
                        {
                        }
                        column(Service_Tax_AmountCaption; Service_Tax_AmountCaptionLbl)
                        {
                        }
                        column(ChargesAmountCaption; ChargesAmountCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
                        {
                        }
                        column(Service_Tax_eCess_AmountCaption; Service_Tax_eCess_AmountCaptionLbl)
                        {
                        }
                        column(TCS_AmountCaption; TCS_AmountCaptionLbl)
                        {
                        }
                        column(Svc_Tax_Amt__Applied_Caption; Svc_Tax_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(Svc_Tax_eCess_Amt__Applied_Caption; Svc_Tax_eCess_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(Service_Tax_SHE_Cess_AmountCaption; Service_Tax_SHE_Cess_AmountCaptionLbl)
                        {
                        }
                        column(Svc_Tax_SHECess_Amt_Applied_Caption; Svc_Tax_SHECess_Amt_Applied_CaptionLbl)
                        {
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__Caption; Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        column(DespLine_Actual_Wt; DespLine."Actual Wt")
                        {
                        }
                        column(GrandTotal_Rounded; GrandTotal_Rounded)
                        {
                        }
                        //SSDVG
                        column(PackageNO; PackageNO)
                        {
                        }
                        //SSDVG
                        trigger OnAfterGetRecord()
                        var
                            Item: Record Item;
                            ILE: Record "Item Ledger Entry";
                            // StructureLineDetails: Record UnknownRecord13798;
                            Location: Record Location;
                            SalesInvPackTemp: Record "SSD Sales Inv Pack Temp";
                            SalesInvLine: Record "Sales Invoice Line";
                            TypeHelper: Codeunit "Type Helper";
                            CRLF: Text[2];
                            J: Integer;
                            ItemRec: Record Item;
                        begin
                            GSTText1:='';
                            GSTText2:='';
                            GSTText3:='';
                            TotalGST:=0;
                            TCS_Amount:=0;
                            Per_CGST:=0;
                            CGST_Amt:=0;
                            Per_SGST:=0;
                            SGST_Amt:=0;
                            Per_IGST:=0;
                            IGST_Amt:=0;
                            if "Invoice Type" = "Invoice Type"::Supplementary then begin
                                TaxTransactionValue.Reset();
                                TaxTransactionValue.SetRange("Tax Record ID", "Sales Invoice Line".RecordId);
                                TaxTransactionValue.SetRange("Tax Type", 'GST');
                                TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                                IF TaxTransactionValue.FindSet()then repeat if TaxTransactionValue."Value ID" = 2 then begin
                                            CGST_Amt:=TaxTransactionValue.Amount;
                                            Per_CGST:=TaxTransactionValue.Percent;
                                            GSTText2:='CGST ' + FORMAT(Per_CGST) + '% Rs.' + Format(CGST_Amt);
                                        end;
                                        IF TaxTransactionValue."Value ID" = 3 then begin
                                            IGST_Amt:=TaxTransactionValue.Amount;
                                            Per_IGST:=TaxTransactionValue.Percent;
                                            GSTText1:='IGST ' + FORMAT(Per_IGST) + '% Rs.' + Format(IGST_Amt);
                                        end;
                                        IF TaxTransactionValue."Value ID" = 6 then begin
                                            SGST_Amt:=TaxTransactionValue.Amount;
                                            Per_SGST:=TaxTransactionValue.Percent;
                                            GSTText3:='SGST ' + FORMAT(Per_SGST) + '% Rs.' + Format(SGST_Amt);
                                        end;
                                    until TaxTransactionValue.Next() = 0;
                            end
                            else
                            begin
                                DetailedGSTLedgerEntry1.Reset();
                                DetailedGSTLedgerEntry1.SetRange("Transaction Type", DetailedGSTLedgerEntry1."Transaction Type"::Sales);
                                DetailedGSTLedgerEntry1.SetRange("Document Type", DetailedGSTLedgerEntry1."Document Type"::Invoice);
                                DetailedGSTLedgerEntry1.SetRange("Document No.", "Sales Invoice Header"."No.");
                                DetailedGSTLedgerEntry1.SetRange("Document Line No.", "Line No.");
                                // DetailedGSTLedgerEntry1.SetFilter(DetailedGSTLedgerEntry1."Payment Type", '<>%1', DetailedGSTLedgerEntry1."Payment Type"::Advance);
                                if DetailedGSTLedgerEntry1.FindSet()then repeat if DetailedGSTLedgerEntry1."GST Component Code" = 'IGST' then begin
                                            Per_IGST:=DetailedGSTLedgerEntry1."GST %";
                                            IGST_Amt:=Abs(DetailedGSTLedgerEntry1."GST Amount");
                                            GSTText1:='IGST ' + FORMAT(Per_IGST) + '% Rs.' + Format(IGST_Amt);
                                        end;
                                        if DetailedGSTLedgerEntry1."GST Component Code" = 'CGST' then begin
                                            Per_CGST:=DetailedGSTLedgerEntry1."GST %";
                                            CGST_Amt:=abs(DetailedGSTLedgerEntry1."GST Amount");
                                            GSTText2:='CGST ' + FORMAT(Per_CGST) + '% Rs.' + Format(CGST_Amt);
                                        end;
                                        if DetailedGSTLedgerEntry1."GST Component Code" = 'SGST' then begin
                                            Per_SGST:=DetailedGSTLedgerEntry1."GST %";
                                            SGST_Amt:=abs(DetailedGSTLedgerEntry1."GST Amount");
                                            GSTText3:='SGST ' + FORMAT(Per_SGST) + '% Rs.' + Format(SGST_Amt);
                                        end;
                                    until DetailedGSTLedgerEntry1.Next() = 0;
                            end;
                            ChargesAmount:=0;
                            SrNo+=1;
                            XX:=XX - 1;
                            desc:='';
                            //Alle_190419-begin
                            desc:="Sales Invoice Line".Description;
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then begin
                                desc1:=CopyStr("Sales Invoice Line".Description, 1, 5);
                                if desc1 <> 'Round' then desc:="Sales Invoice Line".Description
                                else
                                    desc:='Freight';
                                if desc <> '' then desc:='Freight'
                                else
                                    desc:="Sales Invoice Line".Description;
                            end;
                            //Alle_190419-end
                            // ALLE1.01 Sk Start
                            // GSTText := '';
                            // if "Sales Invoice Line"."GST Jurisdiction Type"  ="Sales Invoice Line"."gst jurisdiction type"::Intrastate then begin
                            //     DetailedGSTLedgerEntry.Reset;
                            //     DetailedGSTLedgerEntry.SetRange("Document No.","Sales Invoice Line"."Document No.");
                            //     DetailedGSTLedgerEntry.SetRange("Document Type",DetailedGSTLedgerEntry."document type"::Invoice) ;
                            //     DetailedGSTLedgerEntry.SetRange(DetailedGSTLedgerEntry."No.","No.");
                            //     DetailedGSTLedgerEntry.SetFilter(DetailedGSTLedgerEntry."GST Component Code",'%1|%2','SGST','CGST');
                            //     if DetailedGSTLedgerEntry.FindSet then
                            //       repeat
                            //       if GSTText ='' then
                            //         GSTText :=DetailedGSTLedgerEntry."GST Component Code"+Format(ROUND(DetailedGSTLedgerEntry."GST %",0.1,'='))+'%  '  +' Rs. '+Format(Abs(DetailedGSTLedgerEntry."GST Amount"))
                            //       else
                            //         GSTText :=GSTText+'    '+DetailedGSTLedgerEntry."GST Component Code"+Format(ROUND(DetailedGSTLedgerEntry."GST %",0.1,'='))+'%  ' +' Rs. '+Format(Abs(DetailedGSTLedgerEntry."GST Amount")) ;
                            //      until DetailedGSTLedgerEntry.Next =0;
                            // end else  begin
                            //  if GSTGroup.Get("Sales Invoice Line"."GST Group Code") then
                            //   GSTText:= 'I'+GSTGroup.Description  +' Rs. '+Format("Total GST Amount");
                            // end;
                            // TotalGstAMount := TotalGstAMount + "Total GST Amount";
                            // Check.InitTextVariable();
                            // //Check.FormatNoText(NoInText,"Sales Invoice Line"."Excise Amount",'');
                            // Check.FormatNoText(TotalGstAMountintext,TotalGstAMount,'');  //Alle[Z]- Added-01-06-2015
                            // //message('%1',TotalGstAMountintext[1]);
                            // "Sales Invoice Header".CalcFields("Sales Invoice Header"."Amount to Customer");
                            // Check.InitTextVariable();
                            // Check.FormatNoText(AmountInWords,"Sales Invoice Header"."Amount to Customer",'');
                            // ALLE1.01 Sk Start
                            FixedRows+=1;
                            if FixedRows > 4 then begin
                                RowsCount:=RowsCount + 1;
                                FixedRows:=0;
                            end;
                            if "System-Created Entry" then begin
                                SrNo:=0;
                                "Unit Price":=0;
                                Quantity:=0;
                            end;
                            if "System-Created Entry" then CurrReport.Skip();
                            PostedShipmentDate:=0D;
                            if Quantity <> 0 then PostedShipmentDate:=FindPostedShipmentDate();
                            Clear(TotalPack);
                            Clear(TotalWeight);
                            if(Type = Type::"G/L Account") and (not ShowInternalInfo)then "No.":='';
                            /*
                            IF DespLine.GET(DespLine."Document Type"::Order,
                                            "Sales Invoice Line"."Despatch Slip No.",
                                            "Sales Invoice Line"."Despatch Slip Line No.") THEN
                            BEGIN
                              DespLine.CALCFIELDS("No of Pack");
                              DespLine.CALCFIELDS("Actual Wt");
                              DespLine.CALCFIELDS("Gross Wt");

                              TotalPack  += DespLine."No of Pack";
                              TotalWeight += DespLine."Gross Wt";

                            END;
                            */
                            Location.Reset();
                            IF Location.Get("Location Code")THEN if not Location."SSD Automated Plant" then begin
                                    DespLine.Reset();
                                    DespLine.SetRange("Document Type", DespLine."document type"::Order);
                                    DespLine.SetRange("Document Subtype", DespLine."document subtype"::Despatch);
                                    DespLine.SetRange("Document No.", "Sales Invoice Line"."Despatch Slip No.");
                                    if DespLine.FindSet()then repeat DespLine.CalcFields("No of Pack");
                                            DespLine.CalcFields("Actual Wt");
                                            DespLine.CalcFields("Gross Wt");
                                            TotalPack+=DespLine."No of Pack";
                                            TotalWeight+=DespLine."Gross Wt";
                                        until DespLine.Next() = 0;
                                end
                                else
                                begin
                                    ValueEntry.Reset();
                                    ValueEntry.SetRange("Document No.", "Document No.");
                                    //ValueEntry.SetRange("Item No.", "No.");
                                    //ValueEntry.SetRange("Document Line No.", "Line No.");
                                    ValueEntry.SetRange(Adjustment, FALSE);
                                    if ValueEntry.FindSet()then repeat ItemLedgerEntry.Reset();
                                            ItemLedgerEntry.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                            if ItemLedgerEntry.FindSet()then repeat ItemRec.Reset();
                                                    ItemRec.Get(ItemLedgerEntry."Item No.");
                                                    TotalWeight+=Abs(ItemLedgerEntry.Quantity) * ItemRec."Gross Weight";
                                                    //SSDVG TOTAL
                                                    //ItemCatCode := ITemLE."Item Category Code";
                                                    TotalPack+=1;
                                                until ItemLedgerEntry.Next() = 0;
                                        until ValueEntry.next() = 0;
                                end;
                            //<<<< ALLE[551]
                            CrossRefValue:='';
                            if Item2.Get("Sales Invoice Line"."No.")then;
                            CrossRefValue:='( ' + Format(ROUND(Item2."Net Weight" * "Sales Invoice Line".Quantity, 0.01, '=')) + ' KGS )';
                            //TotalWeight += Item2."Net Weight"*"Sales Invoice Line".Quantity;
                            //<<<< ALLE[551]
                            //>>Alle VPB
                            Clear(PackDesc);
                            Clear(PackDescQty);
                            PackCounter:=1;
                            if SalesInvPackTemp.FindSet()then SalesInvPackTemp.DeleteAll();
                            Location.Reset();
                            if Location.Get("Location Code")then if not Location."SSD Automated Plant" then begin
                                    SalesScheduleBuffer.Reset();
                                    SalesScheduleBuffer.SetRange("Document Type", SalesScheduleBuffer."document type"::Order);
                                    SalesScheduleBuffer.SetRange("Document No.", "Sales Invoice Line"."Despatch Slip No.");
                                    SalesScheduleBuffer.SetRange("Order Line No.", "Sales Invoice Line"."Despatch Slip Line No.");
                                    if SalesScheduleBuffer.FindFirst()then repeat PackDesc[PackCounter]:=Format(SalesScheduleBuffer."No. of Box") + ' ' + Format(SalesScheduleBuffer.Packing);
                                            PackDescQty[PackCounter]:=Format(SalesScheduleBuffer."Qty per Box") + ' ' + SalesScheduleBuffer."Unit of Measure Code";
                                            //SalesScheduleBuffer."Gross Weight"
                                            PackCounter+=1;
                                            PackingSlipNo:="Sales Invoice Line"."Despatch Slip No.";
                                        until SalesScheduleBuffer.Next() = 0;
                                //  <<Alle VPB
                                //SSDVG added+
                                end
                                else
                                begin
                                    ValueEntry.Reset();
                                    ValueEntry.SetRange("Document No.", "Document No.");
                                    ValueEntry.SetRange("Item No.", "No.");
                                    ValueEntry.SetRange("Document Line No.", "Line No.");
                                    ValueEntry.SetRange(Adjustment, FALSE);
                                    if ValueEntry.FindSet()then repeat ItemLedgerEntry.Reset();
                                            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.")then begin
                                                PackageNO:=ItemLedgerEntry."Package No.";
                                                Item1.Get(ItemLedgerEntry."Item No.");
                                                // PackDescQty[PackCounter] := Format(Item1."Pack Size") + ' ' + Item1."Base Unit of Measure";
                                                //PackDesc[PackCounter] := Format(Quantity / Item1."Pack Size") + ' ' + Format(Item1."SSD Packing");
                                                PackCounter:=1;
                                                PackingSlipNo:="Sales Invoice Line"."Despatch Slip No.";
                                                //SSDVG TOTAL
                                                //ItemCatCode := ITemLE."Item Category Code";
                                                //if "Sales Invoice Header"."No." = ItemLedgerEntry."Document No." then begin
                                                if not SalesInvPackTemp.Get(ValueEntry."Document No.", ValueEntry."Item No.", ValueEntry."Valued Quantity", ValueEntry."Document Line No.")then begin
                                                    SalesInvPackTemp.Init();
                                                    SalesInvPackTemp."No.":=ValueEntry."Document No.";
                                                    SalesInvPackTemp."Item No.":=ValueEntry."Item No.";
                                                    SalesInvPackTemp.Quantity:=ValueEntry."Valued Quantity";
                                                    SalesInvPackTemp."Line No.":=ValueEntry."Document Line No.";
                                                    SalesInvPackTemp."Package Count":=1;
                                                    J+=1;
                                                    SalesInvPackTemp.Insert();
                                                end
                                                else
                                                begin
                                                    SalesInvPackTemp."Package Count"+=1;
                                                    SalesInvPackTemp.Modify();
                                                end;
                                            end;
                                        //  end;
                                        until ValueEntry.Next() = 0;
                                // end;
                                //until ValueEntry.Next() = 0;
                                //SSDVG added-
                                end;
                            Clear(PackDesc);
                            Clear(PackDescQty);
                            SalesInvPackTemp.Reset();
                            if SalesInvPackTemp.FindSet()then repeat // "Sales Invoice Line".Reset();
 // "Sales Invoice Line".SetRange("Document No.", TempSalesInv."No.");
                                    // "Sales Invoice Line".SetRange("No.", TempSalesInv."Item No.");
                                    // "Sales Invoice Line".SetRange("Quantity", TempSalesInv.Quantity);
                                    // "Sales Invoice Line".SetRange("Line No.", TempSalesInv."Line No.");
                                    // if "Sales Invoice Line".FindFirst() then begin
                                    CRLF:=TypeHelper.CRLFSeparator();
                                    if PackDesc[PackCounter] = '' then PackDesc[PackCounter]:=Format(SalesInvPackTemp."Package Count") + ' ' + Format(Item1."SSD Packing")
                                    else
                                        PackDesc[PackCounter]+=CRLF + Format(SalesInvPackTemp."Package Count") + ' ' + Format(Item1."SSD Packing");
                                    if PackDescQty[PackCounter] = '' then PackDescQty[PackCounter]:=Format(Abs(SalesInvPackTemp.Quantity)) + ' ' + Item1."Base Unit of Measure"
                                    else
                                        PackDescQty[PackCounter]+=CRLF + Format(Abs(SalesInvPackTemp.Quantity)) + ' ' + Item1."Base Unit of Measure";
                                // end;
                                until SalesInvPackTemp.Next() = 0;
                            if not "System-Created Entry" then begin
                                BED1:='CENVAT ' + Format(0) + ' %';
                                Ecess:='Edu Cess ' + Format(0) + ' %';
                                SHE:='Hr. Cess ' + Format(0) + ' %';
                            end;
                            // ExciseSetup.Reset;
                            // ExciseSetup.SetCurrentkey("Excise Bus. Posting Group","Excise Prod. Posting Group","From Date",SSI);
                            // ExciseSetup.SetRange("Excise Bus. Posting Group","Excise Bus. Posting Group");
                            // ExciseSetup.SetRange("Excise Prod. Posting Group","Excise Prod. Posting Group");
                            // ExciseSetup.SetFilter("From Date",'<=%1',"Posting Date");
                            // if ExciseSetup.FindLast then
                            // begin
                            //   BED1 := 'CENVAT '+Format(ExciseSetup."BED %")+' %';
                            //   Ecess := 'Edu Cess '+Format(ExciseSetup."eCess %")+' %';
                            //   SHE := 'Hr. Cess '+Format(ExciseSetup."SHE Cess %")+' %';
                            // end;
                            // VATAmountLine.Init;
                            // VATAmountLine."VAT Identifier" := "VAT Identifier";
                            // VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            // VATAmountLine."Tax Group Code" := "Tax Group Code";
                            // VATAmountLine."VAT %" := "VAT %";
                            // VATAmountLine."VAT Base" := Amount;
                            // VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            // VATAmountLine."Line Amount" := "Line Amount";
                            // if "Allow Invoice Disc." then
                            //   VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            // VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            // VATAmountLine.InsertLine;
                            // TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS";
                            // if ISSERVICETIER then begin
                            //   TotalSubTotal += "Line Amount";
                            //   TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            //   TotalAmount += Amount;
                            //   TotalAmountVAT += "Amount Including VAT" - Amount;
                            //   // TotalAmountInclVAT += "Amount Including VAT";
                            //   TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            //   TotalAmountInclVAT += "Amount To Customer";
                            //   TotalExciseAmt +=  "Excise Amount";
                            //   TotalTaxAmt +=  "Tax Amount";
                            //   ServiceTaxAmount += "Service Tax Amount";
                            //   ServiceTaxeCessAmount += "Service Tax eCess Amount";
                            //   ServiceTaxSHECessAmount += "Service Tax SHE Cess Amount";
                            // end;
                            // StructureLineDetails.Reset;
                            // StructureLineDetails.SetRange(Type,StructureLineDetails.Type::Sale);
                            // StructureLineDetails.SetRange("Document Type",StructureLineDetails."document type"::Invoice);
                            // StructureLineDetails.SetRange("Invoice No.","Document No.");
                            // //StructureLineDetails.SETRANGE("Item No.","No.");
                            // //StructureLineDetails.SETRANGE("Line No.","Line No.");
                            // if StructureLineDetails.Find('-') then
                            //   repeat
                            //     if not StructureLineDetails."Payable to Third Party" then begin
                            //       if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges then
                            //         ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
                            //       if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
                            //         OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
                            //     end;
                            //   until StructureLineDetails.Next = 0;
                            // if ISSERVICETIER then begin
                            // if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
                            //   ServiceTaxEntry.Reset;
                            //   ServiceTaxEntry.SetRange(Type,ServiceTaxEntry.Type::Sale);
                            //   ServiceTaxEntry.SetRange("Document Type",ServiceTaxEntry."document type"::Invoice);
                            //   ServiceTaxEntry.SetRange("Document No.","Document No.");
                            //   if ServiceTaxEntry.FindFirst then begin
                            //     if "Sales Invoice Header"."Currency Code" <> '' then begin
                            //      ServiceTaxEntry."Service Tax Amount" :=
                            //        ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //          "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //          ServiceTaxEntry."Service Tax Amount","Sales Invoice Header"."Currency Factor"));
                            //      ServiceTaxEntry."eCess Amount" :=
                            //        ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //          "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //          ServiceTaxEntry."eCess Amount","Sales Invoice Header"."Currency Factor"));
                            //      ServiceTaxEntry."SHE Cess Amount" :=
                            //        ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //          "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //          ServiceTaxEntry."SHE Cess Amount","Sales Invoice Header"."Currency Factor"));
                            //     end;
                            //     ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
                            //     ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
                            //     ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
                            //     AppliedServiceTaxAmt := ServiceTaxAmount - Abs(ServiceTaxEntry."Service Tax Amount");
                            //     AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - Abs(ServiceTaxEntry."eCess Amount");
                            //     AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - Abs(ServiceTaxEntry."SHE Cess Amount");
                            //   end else begin
                            //     AppliedServiceTaxAmt := ServiceTaxAmount;
                            //     AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
                            //     AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            //   end;
                            // end else begin
                            //   ServiceTaxAmt := ServiceTaxAmount;
                            //   ServiceTaxECessAmt := ServiceTaxeCessAmount;
                            //   ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            // end;
                            // end;
                            // //>>Alle VPB
                            // RecCrossReference.Init;
                            if Type = Type::Item then begin
                                RecCrossReference.Reset();
                                RecCrossReference.SetRange("Item No.", "No.");
                                RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
                                RecCrossReference.SetRange("Reference Type No.", "Sell-to Customer No.");
                                if RecCrossReference.FindFirst()then RecCrossReferenceNo:=RecCrossReference."Reference No.";
                            end;
                        // //<<Alle VPB
                        // //<<Alle VPB
                        // if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
                        //   ServiceTaxEntry.Reset;
                        //   ServiceTaxEntry.SetRange(Type,ServiceTaxEntry.Type::Sale);
                        //   ServiceTaxEntry.SetRange("Document Type",ServiceTaxEntry."document type"::Invoice);
                        //   ServiceTaxEntry.SetRange("Document No.","Document No.");
                        //   if ServiceTaxEntry.FindFirst then begin
                        //     if "Sales Invoice Header"."Currency Code" <> '' then begin
                        //      ServiceTaxEntry."Service Tax Amount" :=
                        //        ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                        //          "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                        //          ServiceTaxEntry."Service Tax Amount","Sales Invoice Header"."Currency Factor"));
                        //      ServiceTaxEntry."eCess Amount" :=
                        //        ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                        //          "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                        //          ServiceTaxEntry."eCess Amount","Sales Invoice Header"."Currency Factor"));
                        //      ServiceTaxEntry."SHE Cess Amount" :=
                        //        ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                        //          "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                        //          ServiceTaxEntry."SHE Cess Amount","Sales Invoice Header"."Currency Factor"));
                        //     end;
                        //     ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
                        //     ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
                        //     ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
                        //     AppliedServiceTaxAmt := "Service Tax Amount" - Abs(ServiceTaxEntry."Service Tax Amount");
                        //     AppliedServiceTaxECessAmt := "Service Tax eCess Amount" - Abs(ServiceTaxEntry."eCess Amount");
                        //     AppliedServiceTaxSHECessAmt := "Service Tax SHE Cess Amount" - Abs(ServiceTaxEntry."SHE Cess Amount");
                        //   end else begin
                        //     AppliedServiceTaxAmt := "Service Tax Amount";
                        //     AppliedServiceTaxECessAmt := "Service Tax eCess Amount";
                        //     AppliedServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                        //   end;
                        // end else begin
                        //   ServiceTaxAmt := "Service Tax Amount";
                        //   ServiceTaxECessAmt := "Service Tax eCess Amount";
                        //   ServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                        // end;
                        // if "Sales Invoice Header".Structure = 'GST-P&F-SA' then
                        //   Gtotal+="Sales Invoice Line"."Amount To Customer"
                        // else
                        //   Gtotal := "Total GST Amount"+FreightAmt+ForAmt+SaleInvLine."Line Amount";
                        // GrandTotal_Rounded:=ROUND(Gtotal,1,'=');
                        // Check.InitTextVariable();
                        // //Check.FormatNoText(NoInText,"Sales Invoice Line"."Excise Amount",'');
                        // Check.FormatNoText(NoInText,TotalExciseAmt,'');  //Alle[Z]- Added-01-06-2015
                        // //Check.FormatNoText(ExInText,ROUND(Gtotal,0.01,'='),'');  //ALLE-SS
                        // Check.FormatNoText(ExInText,ROUND(Gtotal,1,'='),'');
                        // //MESSAGE('%1',ExInText[1]);
                        end;
                        trigger OnPreDataItem()
                        begin
                            TempVATAmountLine.DeleteAll();
                            TempSalesShipmentBuffer.Reset();
                            TempSalesShipmentBuffer.DeleteAll();
                            FirstValueEntryNo:=0;
                            MoreLines:=Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0)do MoreLines:=Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break();
                            SetRange("Line No.", 0, "Line No.");
                            // CurrReport.CreateTotals("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Excise Amount","Tax Amount",
                            //   "Service Tax Amount","Service Tax eCess Amount","Amount To Customer");
                            // CurrReport.CreateTotals("Service Tax SHE Cess Amount",DespLine."Actual Wt");
                            SrNo:=0;
                            Gtotal:=0;
                            XX:=6;
                            GrandTotal_Rounded:=0;
                            FixedRows:=0;
                            CGSTAMT:=0;
                            Clear(TotalGstAMount);
                        end;
                    }
                    dataitem(LineCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_1000000000;1000000000)
                        {
                        }
                        column(LineCount_Number; LineCount_NumLbl)
                        {
                        }
                        column(XX; XX)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            XX:=XX - 1;
                        end;
                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, XX);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_1000000073;1000000073)
                        {
                        }
                        column(VATAmountLine__VAT_Base_; TempVATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; TempVATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; TempVATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; TempVATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; TempVATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmountLine__VAT_Base__Control108; TempVATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control109; TempVATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control140; TempVATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control141; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control142; TempVATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control112; TempVATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control113; TempVATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control110; TempVATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control114; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control118; TempVATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control116; TempVATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control117; TempVATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control132; TempVATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control133; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control134; TempVATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control108Caption; VATAmountLine__VAT_Base__Control108CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control109Caption; VATAmountLine__VAT_Amount__Control109CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control141Caption; VATAmountLine__Inv__Disc__Base_Amount__Control141CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control140Caption; VATAmountLine__Line_Amount__Control140CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control142Caption; VATAmountLine__Invoice_Discount_Amount__Control142CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control112Caption; VATAmountLine__VAT_Base__Control112CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control116Caption; VATAmountLine__VAT_Base__Control116CaptionLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;
                        trigger OnPreDataItem()
                        begin
                            if TempVATAmountLine.GetTotalVATAmount() = 0 then CurrReport.Break();
                            SetRange(Number, 1, TempVATAmountLine.Count);
                            CurrReport.CreateTotals(TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount", TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText:=Text003Lbl;
                        if IsServiceTier()then OutputNo+=1;
                    end;
                    CurrReport.PageNo:=1;
                    if ISSERVICETIER then begin
                        TotalSubTotal:=0;
                        TotalInvoiceDiscountAmount:=0;
                        TotalAmount:=0;
                        TotalAmountVAT:=0;
                        TotalAmountInclVAT:=0;
                        TotalPaymentDiscountOnVAT:=0;
                        TotalExciseAmt:=0;
                        TotalTaxAmt:=0;
                        ServiceTaxAmount:=0;
                        ServiceTaxeCessAmount:=0;
                        ServiceTaxSHECessAmount:=0;
                    end;
                    OtherTaxesAmount:=0;
                    // ChargesAmount :=0;
                    AppliedServiceTaxSHECessAmt:=0;
                    AppliedServiceTaxECessAmt:=0;
                    AppliedServiceTaxAmt:=0;
                    ServiceTaxSHECessAmt:=0;
                    ServiceTaxECessAmt:=0;
                    ServiceTaxAmt:=0;
                    TotalTCSAmount:=0;
                    TCS_Amount:=0;
                    TCSEntry.Reset();
                    TCSEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                    TCSEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
                    // TCSEntry.SetRange("Customer No.", "Sell-to Customer No.");
                    if TCSEntry.FindSet()then repeat TCS_Amount+=TCSEntry."TCS Amount";
                        until TCSEntry.Next() = 0;
                    //>>Deepak
                    OrgDupliText:='';
                    if Number = 1 then OrgDupliText:='ORIGINAL FOR RECIPIENT';
                    IF Number = 2 then OrgDupliText:='DUPLICATE FOR TRANSPORTER';
                    IF Number = 3 then OrgDupliText:='TRIPLICATE FOR SUPPLIER';
                    IF Number = 4 then OrgDupliText:='GATE/EXTRA COPY';
                    IF Number = 5 then OrgDupliText:='QUINTUPLICATE COPY';
                    IF Number = 6 then OrgDupliText:='SEXTUPLICATE COPY';
                //<<Deepak
                end;
                trigger OnPostDataItem()
                begin
                    //IF NOT CurrReport.PREVIEW THEN
                    SalesInvCountPrinted.Run("Sales Invoice Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies) + 4;
                    //NoOfLoops := ABS(NoOfCopies);
                    if NoOfLoops <= 0 then NoOfLoops:=1;
                    CopyText:='';
                    SetRange(Number, 1, NoOfLoops);
                    if ISSERVICETIER then OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                CustLocal: Record Customer;
                ItemLocal: Record Item;
                Location: Record Location;
                PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                SHL: Record "Sales Header";
                SalesInvLine: Record "Sales Invoice Line";
                StateRec: Record state;
                TaxAreaLine: Record "Tax Area Line";
                TaxDetail: Record "Tax Detail";
                TaxJurisdiction: Record "Tax Jurisdiction";
                ExcTarrifCounter: Integer;
            begin
                "Sales Invoice Header".CalcFields("QR Code");
                //// Alle-[E-INV] <<
                // //EInvoicingPublishers.CheckEInvoiceStatusForReportPrinting(1,"No."); //Alle-[E-INV]
                // IF "Sales Invoice Header"."Nature of Supply" <> "Sales Invoice Header"."Nature of Supply"::B2C THEN BEGIN
                // EInvoicingRequest.RESET;
                // EInvoicingRequest.SETCURRENTKEY("Document Type","Document No.","E-Invoice Generated");
                // EInvoicingRequest.SETRANGE("Document Type",1);
                // EInvoicingRequest.SETRANGE("Document No.","Sales Invoice Header"."No.");
                // EInvoicingRequest.SETRANGE("E-Invoice Generated",TRUE);
                // IF EInvoicingRequest.FINDFIRST THEN;
                //  GenerateQRCode(EInvoicingRequest);
                //  EInvoicingRequest.CALCFIELDS("QR Image");
                // END;
                // APIConsumerEInvoicing.PrintQRCode("Sales Invoice Header"."No.",1);
                EInvoicingRequest.Reset();
                EInvoicingRequest.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
                EInvoicingRequest.SetRange("Document Type", EInvoicingRequest."Document Type"::"Sale Invoice");
                EInvoicingRequest.SetRange("Document No.", "Sales Invoice Header"."No.");
                EInvoicingRequest.SetRange("E-Invoice Generated", true);
                if EInvoicingRequest.FindFirst()then EInvoicingRequest.CalcFields("QR Image");
                //CORP::PK 250819 >>>
                Clear(QRCodeMgt);
                Clear(QRCodeStr);
                QRCodeMgt.BarcodeForCrMemo("Sales Invoice Header"."No.", "Sales Invoice Header"."Posting Date", CopyStr("External Document No.", 1, 20), "Sales Invoice Header"."Sell-to Customer Name");
                if QRCodeStr.FindFirst()then;
                QRCodeStr.CalcFields(QRCode);
                //CORP::PK <<<
                if Languages.Get("Language Code")then CurrReport.Language:=Languages."Windows Language ID";
                //<<< ALLE[551]
                //InvNoNew:=DELSTR("Sales Invoice Header"."No.",1,STRLEN("Sales Invoice Header"."No.")-5);
                if Location.Get("Location Code")then begin
                    clear(AllowPrintOnSI);
                    AllowPrintOnSI:=Location."Allow Print On SI";
                    if not Location."SSD Automated Plant" then begin
                        if StrLen("Sales Invoice Header"."Order/Scd. No.") > 5 then OrderNoNew:=DelStr("Sales Invoice Header"."Order/Scd. No.", 1, StrLen("Sales Invoice Header"."Order/Scd. No.") - 5)
                        else
                            OrderNoNew:="Sales Invoice Header"."Order/Scd. No.";
                    end
                    else
                    begin
                        if StrLen("Sales Invoice Header"."Order No.") > 5 then OrderNoNew:=DelStr("Sales Invoice Header"."Order No.", 1, StrLen("Sales Invoice Header"."Order No.") - 5)
                        else
                            OrderNoNew:="Sales Invoice Header"."Order No.";
                    end;
                end;
                //>>> ALLE[551]
                if BillTo.Get("Sales Invoice Header"."Bill-to Customer No.")then;
                // if RespCenter.Get("Responsibility Center") then begin
                //     FormatAddr.RespCenter(CompanyAddr, RespCenter);
                //     CompanyInfo."Phone No." := RespCenter."Phone No.";
                //     CompanyInfo."Fax No." := RespCenter."Fax No.";
                // end else begin
                //     FormatAddr.Company(CompanyAddr, CompanyInfo);
                // end;
                //>>Deepak
                if RespCenter.Get("Responsibility Center")then CompanyAddr[1]:='Plant: ' + RespCenter.Address + RespCenter."Address 2" + ' - ' + RespCenter."Post Code";
                CompanyAddr[2]:='Ph.: ' + RespCenter."Phone No."; //IG_DS + ' Fax: ' + RespCenter."Fax No.";
                CompanyAddr[3]:='Regd Office: ' + CompanyInfo.Address + ',' + CompanyInfo."Address 2";
                CompanyAddr[4]:=CompanyInfo.City + '-' + CompanyInfo."Post Code" + ', Phone: ' + CompanyInfo."Phone No."; //IG_DS + ', Fax: ' + CompanyInfo."Fax No.";
                CompanyAddr[5]:='E-Mail: ' + CompanyInfo."E-Mail" + '|' + CompanyInfo."Home Page";
                CINNoTxt:='U74899DL1995PTC069625';
                GSTINTxt:=CompanyInfo."GST Registration No.";
                PANTxt:=CompanyInfo."P.A.N. No.";
                //<<Deepak
                if reccust.Get("Sales Invoice Header"."Sell-to Customer No.")then;
                if RecState.Get(reccust."State Code")then;
                if reccust1.Get("Sales Invoice Header"."Bill-to Customer No.")then;
                RecSIL.Reset();
                RecSIL.SetRange("Document No.", "No.");
                RecSIL.SetRange(Type, RecSIL.Type::Item);
                if RecSIL.FindLast()then begin
                    if RecSIL."GST Jurisdiction Type" = RecSIL."gst jurisdiction type"::Intrastate then bool:=false
                    else
                        bool:=true;
                end;
                //PostedDocDim1.SETRANGE("Table ID",DATABASE::"Sales Invoice Header"); // BIS 1145
                //PostedDocDim1.SETRANGE("Document No.","Sales Invoice Header"."No."); // BIS 1145
                if "Order No." = '' then OrderNoText:=''
                else
                    OrderNoText:=FieldCaption("Order No.");
                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init();
                    SalesPersonText:='';
                end
                else
                begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText:=Text000Lbl;
                end;
                if "Your Reference" = '' then ReferenceText:=''
                else
                    ReferenceText:=FieldCaption("Your Reference");
                if "VAT Registration No." = '' then VATNoText:=''
                else
                    VATNoText:=FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText:=StrSubstNo(Text001Lbl, GLSetup."LCY Code");
                    TotalInclVATText:=StrSubstNo(Text13700Lbl, GLSetup."LCY Code");
                    TotalExclVATText:=StrSubstNo(Text13701Lbl, GLSetup."LCY Code");
                end
                else
                begin
                    TotalText:=StrSubstNo(Text001Lbl, "Currency Code");
                    TotalInclVATText:=StrSubstNo(Text13700Lbl, "Currency Code");
                    TotalExclVATText:=StrSubstNo(Text13701Lbl, "Currency Code");
                end;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                //>> Alle VPB
                Clear(CustAddr);
                if not StateRec.Get("Sales Invoice Header".State)then StateRec.Init();
                CustAddr[1]:="Sales Invoice Header"."Bill-to Name" + '  (' + "Sales Invoice Header"."Bill-to Customer No." + ')';
                CustAddr[2]:="Sales Invoice Header"."Bill-to Address";
                CustAddr[3]:="Sales Invoice Header"."Bill-to Address 2";
                CustAddr[4]:="Sales Invoice Header"."Bill-to City" + ', ' + StateRec.Description + ', ' + "Sales Invoice Header"."Bill-to Post Code";
                //<<Alle VPB
                if not Cust.Get("Bill-to Customer No.")then Clear(Cust);
                QRMng.SaleInv(true, "Sales Invoice Header", false, PurchCrMemoHdr);
                QRMng.Run(ILE);
                Cust3.Get("Sales Invoice Header"."Sell-to Customer No.");
                Cust3.CalcFields("QR Code");
                if "Payment Terms Code" = '' then PaymentTerms.Init()
                else
                begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then ShipmentMethod.Init()
                else
                begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;
                // FormatAddr.SalesInvShipTo(ShipToAddr,"Sales Invoice Header");
                ShowShippingAddr:="Sell-to Customer No." <> "Bill-to Customer No.";
                for i:=1 to ArrayLen(ShipToAddr)do if ShipToAddr[i] <> CustAddr[i]then ShowShippingAddr:=true;
                //>> Alle VPB
                Clear(ShipToAddr);
                CustLocal.Get("Sell-to Customer No.");
                if CustLocal."Print Ship to Addr. on Inv." then begin
                    if not StateRec.Get("Sales Invoice Header"."GST Bill-to State Code")then StateRec.Init();
                    ShipToAddr[1]:="Sales Invoice Header"."Ship-to Name";
                    ShipToAddr[2]:="Sales Invoice Header"."Ship-to Address";
                    ShipToAddr[3]:="Sales Invoice Header"."Ship-to Address 2";
                    ShipToAddr[4]:="Sales Invoice Header"."Ship-to City" + ', ' + StateRec.Description + ', ' + "Sales Invoice Header"."Ship-to Post Code";
                    //ShipToAddr[5] :=  'CST No.: ' + CustLocal."C.S.T. No."; Alle 01082017 comented
                    //ShipToAddr[6] :=  'ECC No.: ' + CustLocal."E.C.C. No."; Alle 01082017 comented
                    ShipToAddr[5]:='GSTIN : ' + CustLocal."GST Registration No.";
                end
                else
                    ShipToAddr[1]:='SAME AS CONSIGNEE';
                //<<Alle VPB
                for iL:=1 to ArrayLen(LocationToAddr)do begin
                    //>> Alle VPB
                    Clear(LocationToAddr);
                    LocationToAddr[1]:=Location.Name + ', ' + Location.Address + ', ' + Location."Address 2";
                    LocationToAddr[2]:=Location."Post Code" + ', ' + Location.city + ', ' + Location."Country/Region Code" + ', ' + Location."Temp State Code";
                end;
                //Alle 310717<<
                Clear(PlaceOfSupply);
                Clear(PlaceOfDelivery);
                Clear(ShipToGST);
                //IF ShipToAddr[1] =  'SAME AS CONSIGNEE' THEN BEGIN
                if "Ship-to Code" = '' then begin
                    PlaceOfDelivery:="Sales Invoice Header"."Ship-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')';
                    PlaceOfSupply:="Sales Invoice Header"."Bill-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')';
                end
                else
                begin
                    if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code")then begin
                        if ShipToAdd."GST Registration No." = '' then ShipToGST:=reccust1."GST Registration No."
                        else
                            ShipToGST:=ShipToAdd."GST Registration No.";
                        if RecState1.Get(ShipToAdd.State)then PlaceOfDelivery:="Sales Invoice Header"."Ship-to City" + ' (' + ShipToAdd.State + '-' + RecState1."State Code (GST Reg. No.)" + ')';
                        PlaceOfSupply:="Sales Invoice Header"."Bill-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')';
                    end;
                end;
                //Alle 310717>>
                if LogInteraction then if not CurrReport.Preview then begin
                        if "Bill-to Contact No." <> '' then SegManagement.LogDocument(4, "No.", 0, 0, Database::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(4, "No.", 0, 0, Database::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    end;
                // SupplementaryText := '';
                // SalesInvLine.SetRange("Document No.","No.");
                // SalesInvLine.SetRange(Supplementary, true);
                // if SalesInvLine.Find('-') then
                //   SupplementaryText := Text16500;
                // if PaymentTerms.Get("Payment Terms Code") then;
                // PSOLDet.Reset;
                // PSOLDet.SetCurrentkey(Type,"Calculation Order","Document Type","Invoice No.",
                //                       "Item No.","Line No.","Tax/Charge Type","Tax/Charge Group","Tax/Charge Code");
                // PSOLDet.SetRange(Type,PSOLDet.Type::Sale);
                // PSOLDet.SetRange("Document Type",PSOLDet."document type"::Invoice);
                // PSOLDet.SetRange("Invoice No.","No.");
                // PSOLDet.SetRange("Tax/Charge Type",PSOLDet."tax/charge type"::Charges);
                // PSOLDet.SetFilter("Tax/Charge Group",'%1','FREIGHT');
                // if PSOLDet.FindFirst then
                // FreightAmt:=0;
                // repeat
                //   FreightAmt += PSOLDet.Amount;
                // until PSOLDet.Next=0;
                // PSOLDet1.Reset;
                // PSOLDet1.SetCurrentkey(Type,"Calculation Order","Document Type","Invoice No.",
                //                       "Item No.","Line No.","Tax/Charge Type","Tax/Charge Group","Tax/Charge Code");
                // PSOLDet1.SetRange(Type,PSOLDet1.Type::Sale);
                // PSOLDet1.SetRange("Document Type",PSOLDet1."document type"::Invoice);
                // PSOLDet1.SetRange("Invoice No.","No.");
                // PSOLDet1.SetRange("Tax/Charge Type",PSOLDet1."tax/charge type"::Charges);
                // PSOLDet1.SetFilter("Tax/Charge Group",'%1','FORWARDING');
                // if PSOLDet1.FindFirst then
                // ForAmt:=0;
                // repeat
                //   ForAmt += PSOLDet1.Amount;
                // until PSOLDet1.Next=0;
                BedAmt:=0;
                ECessAmount:=0;
                SheCessAmount:=0;
                TaxableAmount:=0;
                //>>Alle VPB
                // Clear(ExciseTarrifNos);
                // ExcTarrifCounter := 1;
                // SalesInvLine.Reset;
                // SalesInvLine.SetRange("Document No.","No.");
                // SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                // if SalesInvLine.Find('-') then repeat
                //   ExciseTarrifNos[ExcTarrifCounter] := SalesInvLine."Excise Prod. Posting Group";
                //   if ItemLocal.Get(SalesInvLine."No.") then
                //     ExciseTarrifNos[ExcTarrifCounter] := ItemLocal."Excise Prod. Posting Group";
                //   ExcTarrifCounter += 1;
                // BedAmt+=SalesInvLine."BED Amount";
                // ECessAmount+=SalesInvLine."eCess Amount";
                // SheCessAmount+=SalesInvLine."SHE Cess Amount";
                // TaxableAmount+=SalesInvLine.Amount+SalesInvLine."Excise Amount"
                // //SalesInvLine."Tax Amount"
                // until SalesInvLine.Next = 0;
                /*
                MESSAGE('%1 CENAVT',BedAmt);
                MESSAGE('%1 ECess',ECessAmount);
                MESSAGE('%1 SheCess',SheCessAmount);
                MESSAGE('%1 Taxable Amount',TaxableAmount);
                */
                OrderDate:="Order Date";
                if SHL.Get(SHL."document type"::Order, "Order/Scd. No.")then OrderDate:=SHL."Order Date";
                //<<Alle VPB
                if "Tax Area Code" <> '' then TaxText:="Tax Area Code";
                if "Tax Area Code" = '' then begin
                    SaleInvLine.Reset();
                    SaleInvLine.SetRange("Document No.", "No.");
                    SaleInvLine.SetRange(Type, SaleInvLine.Type::Item);
                    if SaleInvLine.FindFirst()then TaxText:=SaleInvLine."Tax Area Code";
                end;
                // if "Form Code" <> '' then
                //     TaxText := TaxText + ' (Form ' + "Form Code" + ')';
                // SaleInvLine.Reset;
                // SaleInvLine.SetRange("Document No.", "No.");
                // SaleInvLine.SetRange(Type, SaleInvLine.Type::Item);
                // if SaleInvLine.FindFirst then begin
                //   if SaleInvLine."Tax %" <> 0 then begin
                //     TaxAreaLine.SetCurrentkey("Tax Area","Calculation Order");
                //     TaxAreaLine.SetRange("Tax Area",SaleInvLine."Tax Area Code");
                //     if TaxAreaLine.Find('-') then begin
                //       TaxJurisdiction.Get(TaxAreaLine."Tax Jurisdiction Code");
                //       TaxDetail.Reset;
                //       TaxDetail.SetRange("Tax Jurisdiction Code",TaxAreaLine."Tax Jurisdiction Code");
                //       TaxDetail.SetFilter("Tax Group Code",'%1',SaleInvLine."Tax Group Code");
                //       TaxDetail.SetRange("Form Code",SaleInvLine."Form Code");
                //       TaxDetail.SetFilter("Effective Date",'<=%1',"Posting Date");
                //       if TaxDetail.Find('+') then
                //         TaxText := TaxText + ' ' + Format(TaxDetail."Tax Below Maximum") + '%';
                //     end;
                //    end else begin
                //      TaxText := TaxText + ' ' + '0' + '%';
                //   end;
                // end;
                /*
                IF ("Tax Amount" <> 0) AND (taxPercent = 0) THEN BEGIN
                  TaxAreaLine.SETCURRENTKEY("Tax Area","Calculation Order");
                  TaxAreaLine.SETRANGE("Tax Area","Tax Area Code");
                  IF TaxAreaLine.FIND('-') THEN BEGIN
                    TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code");
                    TaxDetail.RESET;
                    TaxDetail.SETRANGE("Tax Jurisdiction Code",TaxAreaLine."Tax Jurisdiction Code");
                    TaxDetail.SETFILTER("Tax Group Code",'%1',"Tax Group Code");
                    TaxDetail.SETRANGE("Form Code","Form Code");
                    TaxDetail.SETFILTER("Effective Date",'<=%1',"Sales Header"."Posting Date");
                    IF TaxDetail.FIND('+') THEN
                      taxPercent := TaxDetail."Tax Below Maximum";
                  END;
                END;
                
                */
                SaleInvLine.Reset();
                SaleInvLine.SetRange("Document No.", "No.");
                SaleInvLine.SetRange("System-Created Entry", true);
                if not SaleInvLine.FindFirst()then SaleInvLine.Init();
                if "CT2 Form" <> '' then Comments[1]+='CT2 Form: ' + "CT2 Form";
                if "CT3 Form" <> '' then Comments[1]+='CT3 Form: ' + "CT3 Form";
                AREDetails.Reset();
                AREDetails.SetRange("Sales Inv No.", "No.");
                AREDetails.SetRange("Sales Inv Date", "Posting Date");
                if AREDetails.FindFirst()then begin
                    Comments[1]+='  ' + Format(AREDetails."ARE1 Type") + ' No.: ' + AREDetails."ARE1 No.";
                end;
                SaleCommentLine.Reset();
                SaleCommentLine.SetRange("Document Type", SaleCommentLine."document type"::"Posted Invoice");
                SaleCommentLine.SetRange("No.", "No.");
                SaleCommentLine.SetRange("Document Line No.", 0);
                if SaleCommentLine.Find('-')then Comments[1]+=SaleCommentLine.Comment;
                if SaleCommentLine.Next() <> 0 then Comments[2]:=SaleCommentLine.Comment;
                Remarks_ALL:='';
                SaleCommentLine.Reset();
                SaleCommentLine.SetRange("Document Type", SaleCommentLine."document type"::"Posted Invoice");
                SaleCommentLine.SetRange("No.", "No.");
                SaleCommentLine.SetRange("Document Line No.", 0);
                if SaleCommentLine.FindSet()then repeat Remarks_ALL+=SaleCommentLine.Comment;
                    until SaleCommentLine.Next() = 0;
                if not ShippingAgent.Get("Shipping Agent Code")then ShippingAgent.Init();
                if not ShipmentMethod.Get("Shipment Method Code")then ShipmentMethod.Init();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(TaxPayableonOnReverseCharges; TaxPayableonOnReverseCharge)
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Payable On Reverse Charge';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    var
        SalesInvPackTemp: Record "SSD Sales Inv Pack Temp";
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.CalcFields("New Logo1");
        case SalesSetup."Logo Position on Documents" of SalesSetup."logo position on documents"::"No Logo": ;
        SalesSetup."logo position on documents"::Left: begin
            CompanyInfo.CalcFields(Picture);
        end;
        SalesSetup."logo position on documents"::Center: begin
            CompanyInfo1.Get();
            CompanyInfo1.CalcFields(Picture);
        end;
        SalesSetup."logo position on documents"::Right: begin
            CompanyInfo2.Get();
            CompanyInfo2.CalcFields(Picture);
        end;
        end;
        if SalesInvPackTemp.FindSet()then SalesInvPackTemp.DeleteAll();
    end;
    var AllowPrintOnSI: Boolean;
    CompanyInfo: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    CurrExchRate: Record "Currency Exchange Rate";
    BillTo: Record Customer;
    Cust: Record Customer;
    Cust3: Record Customer;
    reccust: Record Customer;
    reccust1: Record Customer;
    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
    GLSetup: Record "General Ledger Setup";
    GSTGroup: Record "GST Group";
    GSTSetup: Record "GST Setup";
    //SSDVG
    Item1: Record Item;
    Item2: Record Item;
    recItem: Record Item;
    ILE: Record "Item Ledger Entry";
    ItemLedgerEntry: Record "Item Ledger Entry";
    RecCrossReference: Record "Item Reference";
    Languages: Record Language;
    PaymentTerms: Record "Payment Terms";
    RespCenter: Record "Responsibility Center";
    SalesSetup: Record "Sales & Receivables Setup";
    SaleCommentLine: Record "Sales Comment Line";
    RecSIL: Record "Sales Invoice Line";
    SaleInvLine: Record "Sales Invoice Line";
    SalesInvoiceLine2: Record "Sales Invoice Line";
    SIL: Record "Sales Invoice Line";
    DespLine: Record "Sales Line";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
    ShipToAdd: Record "Ship-to Address";
    ShipmentMethod: Record "Shipment Method";
    ShippingAgent: Record "Shipping Agent";
    AREDetails: Record "SSD ARE1 Details";
    EInvoicingRequest: Record "SSD E-Invoicing Requests";
    QRCodeStr: Record "SSD QR Code Str";
    SalesScheduleBuffer: Record "SSD Sales Schedule Buffer";
    RecState: Record State;
    RecState1: Record State;
    TaxTransactionValue: Record "Tax Transaction Value";
    TCSEntry: record "TCS Entry";
    ValueEntry: Record "Value Entry";
    TempVATAmountLine: Record "VAT Amount Line" temporary;
    Check: Report Check;
    // TempBlob: Record TempBlob;
    APIConsumerEInvoicing: Codeunit "API Consumer E-Invoicing";
    FileManagement: Codeunit "File Management";
    FormatAddr: Codeunit "Format Address";
    QRMng: Codeunit "QR Code Management";
    QRCodeMgt: Codeunit "QR Code Mgt.";
    SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
    SegManagement: Codeunit SegManagement;
    bool: Boolean;
    Continue: Boolean;
    LogInteraction: Boolean;
    LogInteractionEnable: Boolean;
    MoreLines: Boolean;
    ShowInternalInfo: Boolean;
    ShowShippingAddr: Boolean;
    TaxPayableonOnReverseCharge: Boolean;
    InvNoNew: Code[10];
    OrderNoNew: Code[10];
    RecCrossReferenceNo: Code[50];
    PackageNO: code[300];
    OrderDate: Date;
    PostedShipmentDate: Date;
    AppliedServiceTaxAmt: Decimal;
    AppliedServiceTaxECessAmt: Decimal;
    AppliedServiceTaxSHECessAmt: Decimal;
    BedAmt: Decimal;
    CalculatedExchRate: Decimal;
    CGST_Amt: Decimal;
    CGSTAMT: Decimal;
    ChargesAmount: Decimal;
    ECessAmount: Decimal;
    ForAmt: Decimal;
    // PSOLDet: Record UnknownRecord13798;
    // PSOLDet1: Record UnknownRecord13798;
    FreightAmt: Decimal;
    GrandTotal_Rounded: Decimal;
    Gtotal: Decimal;
    IGST_Amt: Decimal;
    OtherTaxesAmount: Decimal;
    Per_CGST: Decimal;
    Per_IGST: Decimal;
    Per_SGST: Decimal;
    ServiceTaxAmount: Decimal;
    // ServiceTaxEntry: Record UnknownRecord16473;
    ServiceTaxAmt: Decimal;
    ServiceTaxeCessAmount: Decimal;
    ServiceTaxECessAmt: Decimal;
    ServiceTaxSHECessAmount: Decimal;
    ServiceTaxSHECessAmt: Decimal;
    SGST_Amt: Decimal;
    SheCessAmount: Decimal;
    TaxableAmount: Decimal;
    TCS_Amount: Decimal;
    TotalAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    TotalAmountVAT: Decimal;
    TotalExciseAmt: Decimal;
    TotalGST: Decimal;
    TotalGstAMount: Decimal;
    TotalInvoiceDiscountAmount: Decimal;
    TotalPaymentDiscountOnVAT: Decimal;
    TotalSubTotal: Decimal;
    TotalTaxAmt: Decimal;
    TotalTCSAmount: Decimal;
    TotalWeight: Decimal;
    TotAmt: Decimal;
    TotAmt2: Decimal;
    VALVATAmountLCY: Decimal;
    VALVATBaseLCY: Decimal;
    FirstValueEntryNo: Integer;
    FixedRows: Integer;
    i: Integer;
    iL: Integer;
    NextEntryNo: Integer;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    OutputNo: Integer;
    PackCounter: Integer;
    RowsCount: Integer;
    SrNo: Integer;
    TotalPack: Integer;
    XX: Integer;
    AmountCaptionLbl: label 'Amount';
    ChargesAmountCaptionLbl: label 'Charges Amount';
    ContinuedCaption_Control85Lbl: label 'Continued';
    ContinuedCaptionLbl: label 'Continued';
    CTC_CaptionLbl: label 'CTC:';
    Customer_Road_Permit_No_CaptionLbl: label 'Customer Road Permit No.';
    DateCaptionLbl: label 'Date';
    DestinationCaptionLbl: label 'Destination';
    ECC_No_CaptionLbl: label 'ECC No.';
    Excise_Tarrif_No_CaptionLbl: label 'Excise Tarrif No.';
    ForwardingCaptionLbl: label 'Forwarding';
    FreightCaptionLbl: label 'Freight';
    Frt_BasisCaptionLbl: label 'Price Basis(INCOTERM 2020)';
    Goods_insured_under_BAGICL_Marine_Cargo_CaptionLbl: label 'Goods insured under BAGICL Marine Cargo';
    Grand_TotalCaptionLbl: label 'Grand Total';
    Header_DimensionsCaptionLbl: label 'Header Dimensions';
    Insurance_Policy_No_CaptionLbl: label 'Insurance Policy No.';
    Inv__Discount_Amount_CaptionLbl: label 'Inv. Discount Amount';
    Inv_ValueCaptionLbl: label 'Inv Value';
    Invoice_No_CaptionLbl: label 'Invoice No.';
    Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl: label 'Payment Discount on VAT';
    Line_DimensionsCaptionLbl: label 'Line Dimensions';
    LineCount_NumLbl: label 'LineCount_Number';
    No___Description_of_PackagesCaptionLbl: label 'No & Description of Packages';
    OtherTaxesAmountCaptionLbl: label 'Other Taxes Amount';
    P_O__No_CaptionLbl: label 'P.O. No.';
    Payment_TermsCaptionLbl: label 'Payment Terms';
    PaymentTerms_DescriptionCaptionLbl: label 'Payment Terms';
    Phone_NoCaptionLbl: label 'Phone No';
    Removal_Date_TimeCaptionLbl: label 'Removal Date/Time';
    RoundingCaptionLbl: label 'Rounding';
    Sales_Invoice_Header___Posting_Date_CaptionLbl: label 'Date';
    Sales_Invoice_Line__Excise_Amount_CaptionLbl: label 'Excise Amount';
    Sales_Invoice_Line__No__CaptionLbl: label 'Sr. No.';
    Sales_Invoice_Line__Tax_Amount_CaptionLbl: label 'Tax Amount';
    Sales_Invoice_Line_Description_Control65CaptionLbl: label 'Description of Goods';
    Sales_Invoice_Line_QuantityCaptionLbl: label 'Total Qty';
    Service_Tax_AmountCaptionLbl: label 'Service Tax Amount';
    Service_Tax_eCess_AmountCaptionLbl: label 'Service Tax eCess Amount';
    Service_Tax_SHE_Cess_AmountCaptionLbl: label 'Service Tax SHE Cess Amount';
    Ship_to_AddressCaptionLbl: label 'Ship-to Address';
    ShipmentCaptionLbl: label 'Shipment';
    ShipmentMethod_DescriptionCaptionLbl: label 'Shipment Method';
    ST_NoCaptionLbl: label 'ST No';
    SubtotalCaptionLbl: label 'Subtotal';
    Svc_Tax_Amt__Applied_CaptionLbl: label 'Svc Tax Amt (Applied)';
    Svc_Tax_eCess_Amt__Applied_CaptionLbl: label 'Svc Tax eCess Amt (Applied)';
    Svc_Tax_SHECess_Amt_Applied_CaptionLbl: label 'Svc Tax SHECess Amt(Applied)';
    Taxable_AmountCaptionLbl: label 'Taxable Amount';
    TCS_AmountCaptionLbl: label 'TCS Amount';
    Text000Lbl: label 'Salesperson';
    Text001Lbl: label 'Total %1', Comment = '%1= ';
    Text002Lbl: label 'Total %1 Incl. VAT', Comment = '%1= ';
    Text003Lbl: label 'COPY';
    Text004Lbl: label 'Sales - Invoice %1', Comment = '%1= ';
    Text005Lbl: label 'Page %1', Comment = '%1= ';
    Text006Lbl: label 'Total %1 Excl. VAT', Comment = '%1= ';
    Text007Lbl: label 'VAT Amount Specification in ';
    Text008Lbl: label 'Local Currency';
    Text009Lbl: label 'Exchange rate: %1/%2', Comment = '%1, %2  ';
    Text010Lbl: label 'Sales - Prepayment Invoice %1', Comment = '%1= ';
    Text13700Lbl: label 'Total %1 Incl. Taxes', Comment = '%1= ';
    Text13701Lbl: label 'Total %1 Excl. Taxes', Comment = '%1= ';
    Text16500Lbl: label 'Supplementary Invoice';
    TIN_No_CaptionLbl: label 'TIN No.';
    Total_DutyCaptionLbl: label 'Total Duty';
    TransportCaptionLbl: label 'Transport';
    Unit_PriceCaptionLbl: label 'Unit Price';
    V__CodeCaptionLbl: label 'V. Code';
    VALVATAmountLCY_Control170CaptionLbl: label 'VAT Amount';
    VALVATBaseLCY_Control169CaptionLbl: label 'VAT Base';
    VALVATBaseLCY_Control175CaptionLbl: label 'Continued';
    VALVATBaseLCY_Control180CaptionLbl: label 'Total';
    VALVATBaseLCYCaptionLbl: label 'Continued';
    VAT_Amount_SpecificationCaptionLbl: label 'VAT Amount Specification';
    VATAmountLine__Inv__Disc__Base_Amount__Control141CaptionLbl: label 'Inv. Disc. Base Amount';
    VATAmountLine__Invoice_Discount_Amount__Control142CaptionLbl: label 'Invoice Discount Amount';
    VATAmountLine__Line_Amount__Control140CaptionLbl: label 'Line Amount';
    VATAmountLine__VAT____Control164CaptionLbl: label 'VAT %';
    VATAmountLine__VAT___CaptionLbl: label 'VAT %';
    VATAmountLine__VAT_Amount__Control109CaptionLbl: label 'VAT Amount';
    VATAmountLine__VAT_Base__Control108CaptionLbl: label 'VAT Base';
    VATAmountLine__VAT_Base__Control112CaptionLbl: label 'Continued';
    VATAmountLine__VAT_Base__Control116CaptionLbl: label 'Total';
    VATAmountLine__VAT_Base_CaptionLbl: label 'Continued';
    VATAmountLine__VAT_Identifier__Control165CaptionLbl: label 'VAT Identifier';
    VATAmountLine__VAT_Identifier_CaptionLbl: label 'VAT Identifier';
    Vehicle_NoCaptionLbl: label 'Vehicle No';
    WO_No____DateCaptionLbl: label 'WO No. / Date';
    AmountInWords: array[2]of Text;
    CINNoTxt: Text;
    CrossRefValue: Text;
    desc: Text;
    desc1: Text;
    GSTINTxt: Text;
    GSTText1: Text;
    GSTText2: Text;
    GSTText3: Text;
    OrgDupliText: Text;
    PANTxt: Text;
    Remarks_ALL: Text;
    ShipToGST: Text;
    CopyText: Text[30];
    ExciseTarrifNos: array[10]of Text[30];
    SalesPersonText: Text[30];
    SupplementaryText: Text[30];
    TotalExclVATText: Text[50];
    TotalInclVATText: Text[50];
    TotalText: Text[50];
    VALExchRate: Text[50];
    OldDimText: Text[75];
    OrderNoText: Text[80];
    ReferenceText: Text[80];
    VALSpecLCYHeader: Text[80];
    VATNoText: Text[80];
    // ExciseSetup: Record UnknownRecord13711;
    BED1: Text[100];
    Ecess: Text[100];
    PackDesc: array[100]of Text[300];
    PackDescQty: array[100]of Text[300];
    PackingSlipNo: Text[300];
    PlaceOfDelivery: Text[100];
    PlaceOfSupply: Text[100];
    SHE: Text[100];
    TaxText: Text[100];
    DimText: Text[120];
    Comments: array[2]of Text[150];
    CustAddr: array[8]of Text[150];
    ShipToAddr: array[8]of Text[150];
    LocationToAddr: array[2]of Text[150];
    CompanyAddr: array[8]of Text[250];
    ExInText: array[2]of Text[250];
    NoInText: array[2]of Text[250];
    TotalGstAMountintext: array[5]of Text[250];
    //SSDVG
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode(4) <> '';
    end;
    procedure FindPostedShipmentDate(): Date var
        TempSalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        NextEntryNo:=1;
        if "Sales Invoice Line"."Shipment No." <> '' then if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.")then exit(SalesShipmentHeader."Posting Date");
        if "Sales Invoice Header"."Order No." = '' then exit("Sales Invoice Header"."Posting Date");
        case "Sales Invoice Line".Type of "Sales Invoice Line".Type::Item: GenerateBufferFromValueEntry("Sales Invoice Line");
        "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource, "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset": GenerateBufferFromShipment("Sales Invoice Line");
        "Sales Invoice Line".Type::" ": exit(0D);
        end;
        TempSalesShipmentBuffer.Reset();
        TempSalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        TempSalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
        if TempSalesShipmentBuffer.Find('-')then begin
            TempSalesShipmentBuffer2:=TempSalesShipmentBuffer;
            if TempSalesShipmentBuffer.Next() = 0 then begin
                TempSalesShipmentBuffer.Get(TempSalesShipmentBuffer2."Document No.", TempSalesShipmentBuffer2."Line No.", TempSalesShipmentBuffer2."Entry No.");
                TempSalesShipmentBuffer.Delete();
                exit(TempSalesShipmentBuffer2."Posting Date");
            end;
            TempSalesShipmentBuffer.CalcSums(Quantity);
            if TempSalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                TempSalesShipmentBuffer.DeleteAll();
                exit("Sales Invoice Header"."Posting Date");
            end;
        end
        else
            exit("Sales Invoice Header"."Posting Date");
    end;
    procedure GenerateBufferFromValueEntry(p_SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        l_ItemLedgerEntry: Record "Item Ledger Entry";
        l_ValueEntry: Record "Value Entry";
        Quantity: Decimal;
        TotalQuantity: Decimal;
    begin
        TotalQuantity:=p_SalesInvoiceLine2."Quantity (Base)";
        l_ValueEntry.SetCurrentkey("Document No.");
        l_ValueEntry.SetRange("Document No.", p_SalesInvoiceLine2."Document No.");
        l_ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
        l_ValueEntry.SetRange("Item Charge No.", '');
        l_ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if l_ValueEntry.Find('-')then repeat if l_ItemLedgerEntry.Get(l_ValueEntry."Item Ledger Entry No.")then begin
                    if p_SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then Quantity:=l_ValueEntry."Invoiced Quantity" / p_SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity:=l_ValueEntry."Invoiced Quantity";
                    AddBufferEntry(p_SalesInvoiceLine2, -Quantity, l_ItemLedgerEntry."Posting Date");
                    TotalQuantity:=TotalQuantity + l_ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo:=l_ValueEntry."Entry No." + 1;
            until(l_ValueEntry.Next() = 0) or (TotalQuantity = 0);
    end;
    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        l_SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        Quantity: Decimal;
        TotalQuantity: Decimal;
    begin
        TotalQuantity:=0;
        SalesInvoiceHeader.SetCurrentkey("Order No.");
        SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.Find('-')then repeat l_SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                l_SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
                l_SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
                l_SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
                l_SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if l_SalesInvoiceLine2.Find('-')then repeat TotalQuantity:=TotalQuantity + l_SalesInvoiceLine2.Quantity;
                    until l_SalesInvoiceLine2.Next() = 0;
            until SalesInvoiceHeader.Next() = 0;
        SalesShipmentLine.SetCurrentkey("Order No.", "Order Line No.");
        SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
        if SalesShipmentLine.Find('-')then repeat if "Sales Invoice Header"."Get Shipment Used" then CorrectShipment(SalesShipmentLine);
                if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity)then TotalQuantity:=TotalQuantity - SalesShipmentLine.Quantity
                else
                begin
                    if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity)then SalesShipmentLine.Quantity:=TotalQuantity;
                    Quantity:=SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
                    TotalQuantity:=TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity:=SalesInvoiceLine.Quantity - Quantity;
                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.")then begin
                        AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
                    end;
                end;
            until(SalesShipmentLine.Next() = 0) or (TotalQuantity = 0);
    end;
    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetCurrentkey("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.Find('-')then repeat SalesShipmentLine.Quantity:=SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.Next() = 0;
    end;
    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        TempSalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
        TempSalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
        TempSalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if TempSalesShipmentBuffer.Find('-')then begin
            TempSalesShipmentBuffer.Quantity:=TempSalesShipmentBuffer.Quantity + QtyOnShipment;
            TempSalesShipmentBuffer.Modify();
            exit;
        end;
        TempSalesShipmentBuffer."Document No.":=SalesInvoiceLine."Document No.";
        TempSalesShipmentBuffer."Line No.":=SalesInvoiceLine."Line No.";
        TempSalesShipmentBuffer."Entry No.":=NextEntryNo;
        TempSalesShipmentBuffer.Type:=SalesInvoiceLine.Type;
        TempSalesShipmentBuffer."No.":=SalesInvoiceLine."No.";
        TempSalesShipmentBuffer.Quantity:=QtyOnShipment;
        TempSalesShipmentBuffer."Posting Date":=PostingDate;
        TempSalesShipmentBuffer.Insert();
        NextEntryNo:=NextEntryNo + 1 end;
    local procedure DocumentCaption(): Text[250]begin
        if "Sales Invoice Header"."Prepayment Invoice" then exit(Text010Lbl);
        exit(Text004Lbl);
    end;
// procedure GenerateQRCode(var EInvoicingRequests: Record "Posted Pur Requisition Header")
// var
//     QRCodeInput: Text[1024];
//     QRCodeFileName: Text[1024];
//     Text50000: label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
// begin
//      QRCodeInput := EInvoicingRequests."Signed QR Code"+EInvoicingRequests."Signed QR Code2"+EInvoicingRequests."Signed QR Code3"+EInvoicingRequests."Signed QR Code4";
//      QRCodeFileName := GetQRCode(QRCodeInput);
//      QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
//      // Load the image from file into the BLOB field
//      Clear(TempBlob);
//      FileManagement.BLOBImport(TempBlob,QRCodeFileName);
//      //TempBlob.CALCFIELDS(Blob);
//      if TempBlob.Blob.Hasvalue then begin
//       EInvoicingRequests."QR Image" := TempBlob.Blob;
//       EInvoicingRequests.Modify;
//      end;
//      // Erase the temporary file
//      if not ISSERVICETIER then
//       if Exists(QRCodeFileName) then
//         Erase(QRCodeFileName);
// end;
// local procedure GetQRCode(QRCodeInput: Text[1024]) QRCodeFileName: Text[1024]
// var
//     [RunOnClient]
//     IBarCodeProvider: dotnet IBarcodeProvider;
// begin
//     GetBarCodeProvider(IBarCodeProvider);
//     QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
// end;
// procedure MoveToMagicPath(SourceFileName: Text[1024]) DestinationFileName: Text[1024]
// var
//     FileSystemObject: Automation FileSystemObject;
// begin
//     // User Temp Path
//      DestinationFileName := FileManagement.ClientTempFileName('');
//      if ISCLEAR(FileSystemObject) then
//       Create(FileSystemObject,true,true);
//      FileSystemObject.MoveFile(SourceFileName,DestinationFileName);
// end;
// procedure GetBarCodeProvider(var IBarCodeProvider: dotnet IBarcodeProvider)
// var
//     [RunOnClient]
//     QRCodeProvider: dotnet QRCodeProvider;
// begin
//      QRCodeProvider := QRCodeProvider.QRCodeProvider;
//      IBarCodeProvider := QRCodeProvider;
// end;
}
