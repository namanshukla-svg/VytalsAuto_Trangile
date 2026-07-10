Report 60141 "SSD Posted MRN Automation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Posted MRN Automationn.rdl';
    Caption = 'MRN 1 Automation';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Whse. Receipt Header"; "Posted Whse. Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_4701; 4701)
            {
            }
            column(GateEntryDate; Format(GateEntryDate))
            {
            }
            column(GateEntryNo; GateEntryNo)
            {
            }
            column(Vendor_Shipment_No_; "Vendor Shipment No.")
            {
            }
            column(QCReportRecieved; QCReportRecieved)
            {
            }
            column(TrnsptCopyReport; TrnsptCopyReport)
            {
            }
            column(Posted_Whse__Receipt_Header_No_; "No.")
            {
            }
            column(Item_Code___NameCaption; Item_Code___NameCaptionLbl)
            {
            }
            //Atul 070102026
            column(FooterAddress; StrSubstNo('%1 | %2 | %3 %4 | Phone %5', companyInfoRec."Registered Address", companyInfoRec."Registered Address 2", companyInfoRec."Registered City", companyInfoRec."Registered Post Code", companyInfoRec."Registered Phone No."))
            {
            }
            column(FooterFaxEmailHomepage; StrSubstNo('E-mail %1 | %2', companyInfoRec."Registered E-Mail", companyInfoRec."Registered Home Page"))
            {
            }
            //Atul 070102026
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(ReportForNavId_5444; 5444)
                {
                }
                // column(CurrReport_PAGENO; CurrReport.PageNo())
                // {
                // }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(RespCent_Name; RespCent.Name)
                {
                }
                column(DataItem1000000001; LocationName)
                {
                }
                column(companyInfoRec_Picture; companyInfoRec.Picture)
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(Vendor_Address; Vendor.Address)
                {
                }
                column(Vendor__Address_2_; Vendor."Address 2")
                {
                }
                column(Vendor_City___________Vendor__Post_Code_; Vendor.City + ' - ' + Vendor."Post Code")
                {
                }
                column(PurchaseHeader__No__; PurchaseHeader."No.")
                {
                }
                column(PostedGateHdr__Bill_No__; PostedGateHdr."Bill No.")
                {
                }
                column(Posted_Whse__Receipt_Header___Gate_Entry_no__; "Posted Whse. Receipt Header"."Gate Entry no.")
                {
                }
                column(Posted_Whse__Receipt_Header___No__; "Posted Whse. Receipt Header"."No.")
                {
                }
                column(STATENAME; STATENAME)
                {
                }
                column(Vendor__No__; Vendor."No.")
                {
                }
                column(FormNo; FormNo)
                {
                }
                column(Posted_Whse__Receipt_Header___Gate_Entry_Date_; "Posted Whse. Receipt Header"."Gate Entry Date")
                {
                }
                column(Posted_Whse__Receipt_Header___Posting_Date_; "Posted Whse. Receipt Header"."Posting Date")
                {
                }
                column(PostedGateHdr__Bill_Date_; PostedGateHdr."Bill Date")
                {
                }
                column(VendInvDate; Format("Posted Whse. Receipt Header"."SSD Shipment Date"))
                {
                }
                column(PurchaseHeader__Order_Date_; PurchaseHeader."Order Date")
                {
                }
                column(PostedGateHeader__Transporter_Name_; PostedGateHeader."Transporter Name")
                {
                }
                column(PostedGateHeader__Transporter_Bill_No__; PostedGateHeader."Transporter Bill No.")
                {
                }
                column(PostedGateHeader__Transporter_Bill_Date_; PostedGateHeader."Transporter Bill Date")
                {
                }
                column(PostedGateHeader__Delivery_Challan_Date_; PostedGateHeader."Delivery Challan Date")
                {
                }
                column(PostedGateHeader__Delivery_Challan_No__; PostedGateHeader."Delivery Challan No.")
                {
                }
                column(PostedWhseRcptLine__Posted_Source_No__; PostedWhseRcptLine."Posted Source No.")
                {
                }
                column(Posted_Whse__Receipt_Header___Posting_Date__Control1000000072; "Posted Whse. Receipt Header"."Posting Date")
                {
                }
                column(Customer_City___________Customer__Post_Code_; VendorRec.City + ' - ' + VendorRec."Post Code" + Customer.City + ' - ' + Customer."Post Code" + TransRcptHdr."Transfer-to City" + ' - ' + TransRcptHdr."Transfer-to Post Code")
                {
                }
                column(Customer__Address_2_; VendorRec."Address 2" + Customer."Address 2" + TransRcptHdr."Transfer-to Address 2")
                {
                }
                column(Customer_Address; VendorRec.Address + Customer.Address + TransRcptHdr."Transfer-to Address")
                {
                }
                column(Customer_Name; VendorRec.Name + Customer.Name + TransRcptHdr."Transfer-to Name")
                {
                }
                column(Customer__No__; VendorRec."No." + Customer."No." + TransRcptHdr."Transfer-to Code")
                {
                }
                column(PartyNameTxt; PartyNameTxt)
                {
                }
                column(RemarksTxt; RemarksTxt)
                {
                }
                column(Posted_Whse__Receipt_Header___QC_Report_Received_; "Posted Whse. Receipt Header"."QC Report Received")
                {
                }
                column(Posted_Whse__Receipt_Header___Transporter_Copy_Received_; "Posted Whse. Receipt Header"."Transporter Copy Received")
                {
                }
                column(SD_____FORMAT_UserSetup_Name_; 'SD/- ' + Format(UserSetup.Name))
                {
                }
                column(PostedQualityOrderHeader_Remarks; Remark1)
                {
                }
                column(Remarks; PostedQualityOrderHeader.Remarks)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Date_Caption; Date_CaptionLbl)
                {
                }
                column(POSTED_MATERIAL__RECEIPT__NOTECaption; POSTED_MATERIAL__RECEIPT__NOTECaptionLbl)
                {
                }
                column(Gate_Entry_No____DateCaption; Gate_Entry_No____DateCaptionLbl)
                {
                }
                column(P_O_No____DateCaption; P_O_No____DateCaptionLbl)
                {
                }
                column(Party_Invoice_No____DateCaption; Party_Invoice_No____DateCaptionLbl)
                {
                }
                column(Whse__Rcpt__No____DateCaption; Whse__Rcpt__No____DateCaptionLbl)
                {
                }
                column(Road_Permit_No_Caption; Road_Permit_No_CaptionLbl)
                {
                }
                column(PostedGateHeader__Transporter_Name_Caption; PostedGateHeader__Transporter_Name_CaptionLbl)
                {
                }
                column(Transporter_Bill_No____DateCaption; Transporter_Bill_No____DateCaptionLbl)
                {
                }
                column(Delivery_Challan_No____DateCaption; Delivery_Challan_No____DateCaptionLbl)
                {
                }
                column(MRN_No____DateCaption; MRN_No____DateCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Sr__No_Caption; Sr__No_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Qty__On_Invoice_Caption; Posted_Whse__Receipt_Line__Qty__On_Invoice_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_Caption; Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_CaptionLbl)
                {
                }
                column(Accepted__Qty_Caption; Accepted__Qty_CaptionLbl)
                {
                }
                column(Rejected__Qty_Caption; Rejected__Qty_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Shortage_Qty__Caption; "Posted Whse. Receipt Line".FieldCaption("Shortage Qty."))
                {
                }
                column(RemarksTxtCaption; RemarksTxtCaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Header___Transporter_Copy_Received_Caption; Posted_Whse__Receipt_Header___Transporter_Copy_Received_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Header___QC_Report_Received_Caption; Posted_Whse__Receipt_Header___QC_Report_Received_CaptionLbl)
                {
                }
                column(Store__Caption; Store__CaptionLbl)
                {
                }
                column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                {
                }
                column(INSPECTED_BYCaption; INSPECTED_BYCaptionLbl)
                {
                }
                column(CHECKED_BYCaption; CHECKED_BYCaptionLbl)
                {
                }
                column(APPROVED_BYCaption; APPROVED_BYCaptionLbl)
                {
                }
                column(Store__Caption_Control1000000041; Store__Caption_Control1000000041Lbl)
                {
                }
                column(AUTHORISED__Caption; AUTHORISED__CaptionLbl)
                {
                }
                column(QC__Caption; QC__CaptionLbl)
                {
                }
                column(For_A_C_DepartmentCaption; For_A_C_DepartmentCaptionLbl)
                {
                }
                column(A_C_DepartmentCaption; A_C_DepartmentCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(PI_No_Caption; PI_No_CaptionLbl)
                {
                }
                column(FM_ST_01__Rev_NO__01__Effective_date_13_01_2012_Caption; FM_ST_01__Rev_NO__01__Effective_date_13_01_2012_CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemLinkReference = "Posted Whse. Receipt Header";
                    DataItemTableView = sorting("No.", "Line No.");

                    column(ReportForNavId_7072; 7072)
                    {
                    }
                    column(Source_No_; "Source No.")
                    {
                    }
                    column(Posting_Date; Format("Posting Date"))
                    {
                    }
                    column(Vendor_Item_Description; "Vendor Item Description")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Item_No____________Description; VendItemDesc)
                    {
                    }
                    column(Item_No_; "Item No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Qty__On_Invoice_; "Qty. On Invoice")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_; "Actual Qty. to Receive")
                    {
                    }
                    column(SrNo; SrNo)
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Accepted_Qty__; "Accepted Qty.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Rejected_Qty__; "Rejected Qty.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Shortage_Qty__; "Shortage Qty.")
                    {
                    }
                    column(description2; description2)
                    {
                    }
                    column(Posted_Whse__Receipt_Line_No_; "No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line_Posted_Source_No_; "Posted Source No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line_Item_No_; "Item No.")
                    {
                    }
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLink = "Document No." = field("Posted Source No."), "Item No." = field("Item No."), "Document Line No." = field("Line No.");

                        column(ReportForNavId_1000000003; 1000000003)
                        {
                        }
                        column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
                        {
                        }
                        column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                        {
                        }
                    }
                    trigger OnAfterGetRecord()
                    var
                        // PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
                        // PurchaseHdr: Record "Purchase Header";
                        PurchaseHdrN: Record "Purchase Header";
                    // CustomerRec: Record Customer;
                    begin
                        GetLocation("Location Code");
                        SrNo := SrNo + 1;
                        if ItemRec.Get("Item No.") then begin
                            // PartNo := ItemRec."No. 2";
                            description2 := ItemRec."Description 2";
                            Grade1 := ItemRec.Grade;
                        end;
                        PostedQualityOrderHeader.Reset();
                        if PostedQualityOrderHeader.Get("Posted Whse. Receipt Line"."Posted Quality Order No.") then;
                        if UserSetup.Get(PostedQualityOrderHeader."Posted By") then;
                        if Remark1 = '' then Remark1 := PostedQualityOrderHeader.Remarks;
                        if "Vendor Item Description" <> '' then begin
                            GeneralLedgerSetup.Reset();
                            GeneralLedgerSetup.Get();
                            if GeneralLedgerSetup."SSD Activate Item Vendor" then VendItemDesc := "Item No." + '  ' + Description + '(' + "Vendor Item Description" + ')'
                        end
                        else
                            VendItemDesc := "Item No." + '  ' + Description;
                        //SSD
                        if "Posted Whse. Receipt Line"."Source Document" = "Posted Whse. Receipt Line"."Source Document"::"Purchase Order" then begin
                            if PurchaseHdrN.Get(PurchaseHdrN."document type"::Order, "Posted Whse. Receipt Line"."Source No.") then if VendorRec.Get(PurchaseHdrN."Buy-from Vendor No.") then;
                        end
                        else if ("Posted Whse. Receipt Line"."Source Document" = "Posted Whse. Receipt Line"."Source Document"::"Inbound Transfer") then begin
                            if TransRcptHdr.Get("Posted Whse. Receipt Line"."Posted Source No.") then;
                        end
                        else if ("Posted Whse. Receipt Line"."Source Document" = "Posted Whse. Receipt Line"."Source Document"::"Sales Return Order") then if ReturnReceiptHeader.Get("Posted Whse. Receipt Line"."Posted Source No.") then if Customer.get(ReturnReceiptHeader."Sell-to Customer No.") then;
                        //SSD
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo := 0;
                    if STATES1.Get(Vendor."State Code") then STATENAME := STATES1.Description;
                    if STATES.Get(Customer."State Code") then STATENAME := STATES.Description;
                    if PostedGateHeader.Get("Posted Whse. Receipt Header"."Gate Entry no.") then FormNo := CopyStr(PostedGateHeader."ST38 No.", 1, 20);
                    if not PostedGateHeader.Get("Posted Whse. Receipt Header"."Gate Entry no.") then PostedGateHeader.Init();
                    //PostedQualityOrderHeader.RESET;
                    //IF PostedQualityOrderHeader.GET("Posted Whse. Receipt Line"."Posted Quality Order No.") THEN;
                    //   IF UserSetup.GET(PostedQualityOrderHeader."Posted By")THEN;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                stateName1 := '';
                if Location.Get("Location Code") then
                    if STATES1.Get(Location."State Code") then
                        stateName1 := STATES1.Description
                    else
                        stateName1 := '';
                LocationName := Location.Address + ',' + Location."Address 2" + ',' + Location.City + '-' + Location."Post Code" + ',' + stateName1 + 'TEL No. ' + Location."Phone No." + '(Ref: FM-ST-01, Rev NO. 01, Effective date 13-01-2012)';
                GetLocation("Location Code");
                if PostedGateHdr.Get("Posted Whse. Receipt Header"."Gate Entry no.") then if PostedGateHdr."Ref. Document Type" in [PostedGateHdr."ref. document type"::"Purchase Order", PostedGateHdr."ref. document type"::"Purchase Schedule"] then if PurchaseHeader.Get(PurchaseHeader."document type"::Order, PostedGateHdr."Ref. Document No.") then;
                // if not Vendor.Get(PostedGateHdr."Party No.") then begin
                //     Clear(Vendor);
                //    PartyNameTxt := 'Customer Name and Address';
                // end;
                // if not Customer.Get(PostedGateHdr."Party No.") then begin
                //     Clear(Customer);
                PartyNameTxt := 'Vendor Name and Address';
                //end;
                QCReportRecieved := 'NO';
                TrnsptCopyReport := 'NO';
                if "Posted Whse. Receipt Header"."QC Report Received" then QCReportRecieved := 'YES';
                if "Posted Whse. Receipt Header"."Transporter Copy Received" then TrnsptCopyReport := 'YES';
                WhseCommentLine.Reset();
                WhseCommentLine.SetRange("Table Name", WhseCommentLine."table name"::"Posted Whse. Receipt");
                WhseCommentLine.SetRange(Type, WhseCommentLine.Type::" ");
                WhseCommentLine.SetRange("No.", "No.");
                if WhseCommentLine.Find('-') then RemarksTxt := WhseCommentLine.Comment;
                if WhseCommentLine.Next() <> 0 then RemarksTxt := CopyStr(RemarksTxt + '\' + WhseCommentLine.Comment, 1, 1024);
                if WhseCommentLine.Next() <> 0 then RemarksTxt := CopyStr(RemarksTxt + '\' + WhseCommentLine.Comment, 1, 1024);
                if WhseCommentLine.Next() <> 0 then RemarksTxt := CopyStr(RemarksTxt + '\' + WhseCommentLine.Comment, 1, 1024);
                PostedWhseRcptLine.Reset();
                PostedWhseRcptLine.SetRange("No.", "Posted Whse. Receipt Header"."No.");
                if not PostedWhseRcptLine.FindFirst() then PostedWhseRcptLine.Init();
                GeneralLedgerSetup.Reset();
                GeneralLedgerSetup.Get();
                if GeneralLedgerSetup."SSD Activate Item Vendor" then begin
                    PostedWhseReceiptLine.Reset();
                    PostedWhseReceiptLine.SetRange("No.", "No.");
                    PostedWhseReceiptLine.SetFilter("Vendor Item Description", '<>%1', '');
                    if PostedWhseReceiptLine.FindFirst() then ITEMDESCRIPTIONCapt := 'Item Code & Name (Vendor Item Description)';
                end
                else
                    ITEMDESCRIPTIONCapt := 'Item Code & Name';
                //SSD
                Clear(GateEntryNo);
                Clear(GateEntryDate);
                PostedGateEntryHdr.Reset();
                PostedGateEntryHdr.SetRange("SSD Planning No.", "Whse. Receipt No.");
                if PostedGateEntryHdr.FindLast() then begin
                    GateEntryNo := PostedGateEntryHdr."No.";
                    GateEntryDate := PostedGateEntryHdr."Posting Date";
                end;
                //SSD
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        companyInfoRec.Get();
        companyInfoRec.CalcFields(Picture);
        // RespCent.Get(UserMgt.GetRespCenterFilter);
    end;

    var
        companyInfoRec: Record "Company Information";
        Customer: Record Customer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        ItemRec: Record Item;
        Location: Record Location;
        PostedGateEntryHdr: Record "Posted Gate Entry Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        PurchaseHeader: Record "Purchase Header";
        RespCent: Record "Responsibility Center";
        ReturnReceiptHeader: Record "Return Receipt Header";
        PostedGateHdr: Record "SSD Posted Gate Header";
        PostedGateHeader: Record "SSD Posted Gate Header";
        PostedQualityOrderHeader: Record "SSD Posted Quality Order Hdr";
        STATES: Record State;
        STATES1: Record State;
        TransRcptHdr: Record "Transfer Receipt Header";
        UserSetup: Record "User Setup";
        Vendor: Record Vendor;
        VendorRec: Record Vendor;
        WhseCommentLine: Record "Warehouse Comment Line";
        // UserMgt: Codeunit "SSD User Setup Management";
        FormNo: Code[20];
        GateEntryNo: Code[20];
        // PartNo: Code[20];
        // PONo: Code[20];
        GateEntryDate: Date;
        // PODate: Date;
        // IVD: Integer;
        SrNo: Integer;
        A_C_DepartmentCaptionLbl: label 'A/C Department';
        Accepted__Qty_CaptionLbl: label 'Accepted. Qty.';
        APPROVED_BYCaptionLbl: label 'APPROVED BY';
        AUTHORISED__CaptionLbl: label '( AUTHORISED )';
        CHECKED_BYCaptionLbl: label 'CHECKED BY';
        // CountLoop: label 'CountLoopLbl';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Date_CaptionLbl: label 'Date:';
        DateCaptionLbl: label 'Date';
        Delivery_Challan_No____DateCaptionLbl: label 'Delivery Challan No. & Date';
        FM_ST_01__Rev_NO__01__Effective_date_13_01_2012_CaptionLbl: label '<FM-ST-01, Rev NO. 01, Effective date 13-01-2012>';
        For_A_C_DepartmentCaptionLbl: label 'For A/C Department';
        Gate_Entry_No____DateCaptionLbl: label 'Gate Entry No. & Date';
        INSPECTED_BYCaptionLbl: label 'INSPECTED BY';
        MRN_No____DateCaptionLbl: label 'MRN No. & Date';
        P_O_No____DateCaptionLbl: label 'P.O No. & Date';
        Party_Invoice_No____DateCaptionLbl: label 'Party Invoice No. & Date';
        PI_No_CaptionLbl: label 'PI No.';
        POSTED_MATERIAL__RECEIPT__NOTECaptionLbl: label 'POSTED MATERIAL  RECEIPT  NOTE';
        Posted_Whse__Receipt_Header___QC_Report_Received_CaptionLbl: label 'QC Report Received';
        Posted_Whse__Receipt_Header___Transporter_Copy_Received_CaptionLbl: label 'Transporter Copy Received';
        Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_CaptionLbl: label 'Actual Qty.';
        Posted_Whse__Receipt_Line__Qty__On_Invoice_CaptionLbl: label 'Invoice Qty.';
        PostedGateHeader__Transporter_Name_CaptionLbl: label 'Transporter Name';
        Prepared_ByCaptionLbl: label 'Prepared By';
        QC__CaptionLbl: label '( QC )';
        Rejected__Qty_CaptionLbl: label 'Rejected. Qty.';
        RemarksTxtCaptionLbl: label 'Remarks';
        Road_Permit_No_CaptionLbl: label 'Road Permit No.';
        Sr__No_CaptionLbl: label 'Sr. No.';
        Store__Caption_Control1000000041Lbl: label '( Store )';
        Store__CaptionLbl: label '( Store )';
        Transporter_Bill_No____DateCaptionLbl: label 'Transporter Bill No. & Date';
        UOMCaptionLbl: label 'UOM';
        Whse__Rcpt__No____DateCaptionLbl: label 'Whse. Rcpt. No. & Date';
        Item_Code___NameCaptionLbl: Text;
        ITEMDESCRIPTIONCapt: Text;
        LocationName: Text;
        QCReportRecieved: Text;
        Remark1: Text;
        stateName1: Text;
        TrnsptCopyReport: Text;
        VendItemDesc: Text;
        PartyNameTxt: Text[30];
        description2: Text[50];
        Grade1: Text[50];
        STATENAME: Text[50];
        RemarksTxt: Text[1024];

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init()
        else if Location.Code <> LocationCode then Location.Get(LocationCode);
    end;
}
