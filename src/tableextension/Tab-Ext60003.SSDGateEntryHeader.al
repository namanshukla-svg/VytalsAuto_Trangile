tableextension 60003 "SSD Gate Entry Header" extends "Gate Entry Header"
{
    fields
    {
        field(60000; "SSD Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            DataClassification = CustomerContent;
            TableRelation = "SSD Driver" where(Active=const(true));

            trigger OnValidate()
            var
                SSDDriver: Record "SSD Driver";
            begin
                if SSDDriver.Get("SSD Driver Code")then "SSD Driver Name":=SSDDriver.Name
                else
                    "SSD Driver Name":='';
            end;
        }
        field(60001; "SSD Driver Name"; Text[100])
        {
            Caption = 'Driver Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60010; "SSD Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
            TableRelation = "SSD Vehicle" where(Active=const(true));

            trigger OnValidate()
            var
                SSDVehicle: Record "SSD Vehicle";
                InsuranceExpiryErr: Label 'Pollution Certificate for Vehicle %1 expired on %2', Comment = '%1 Vehicle No. %2 Expiry Date';
                PollutionExpiryErr: Label 'Pollution Certificate for Vehicle %1 expired on %2', Comment = '%1 Vehicle No. %2 Expiry Date';
            begin
                if "SSD Vehicle No." <> '' then begin
                    SSDVehicle.Get("SSD Vehicle No.");
                    SSDVehicle.TestField("Polution End Date");
                    SSDVehicle.TestField("Insurance End Date");
                    if SSDVehicle."Polution End Date" < Today then Error(PollutionExpiryErr, "SSD Vehicle No.", SSDVehicle."Polution End Date");
                    if SSDVehicle."Insurance End Date" < Today then Error(InsuranceExpiryErr, "SSD Vehicle No.", SSDVehicle."Polution End Date");
                end;
            end;
        }
        field(60030; "SSD Vehicle Status";Enum "SSD Vehicle Status")
        {
            Caption = 'Vehicle Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60031; "SSD Planning No."; Code[20])
        {
            Caption = 'Planning No.';
            DataClassification = CustomerContent;
            TableRelation = if("Entry Type"=const(Inward))"Warehouse Receipt Header" where("SSD Status"=const(Planned));

            //IG_DS else if ("Entry Type" = const(Outward)) "Warehouse Shipment Header" where(Status = const(Released), "SSD Combined With" = const(''));
            trigger OnValidate()
            var
                WarehouseReceiptHeader: Record "Warehouse Receipt Header";
                WarehouseShipmentHeader: Record "Warehouse Shipment Header";
                WarehouseShipmentHeader2: Record "Warehouse Shipment Header";
            begin
                if "SSD Planning No." = '' then begin
                    "SSD Dock No.":='';
                    "SSD Time Slot No.":='';
                    "SSD Time Slot Starting Time":=0T;
                    "SSD Time Slot Ending Time":=0T;
                    "SSD Material Type":="SSD Material Type"::" ";
                    ResetGateEntryLines();
                end
                else
                    case "Entry Type" of "Entry Type"::Inward: begin
                        WarehouseReceiptHeader.Get("SSD Planning No.");
                        // "SSD Dock No.":=WarehouseReceiptHeader."SSD Dock No.";
                        // "SSD Time Slot No.":=WarehouseReceiptHeader."SSD Slot No.";
                        // "SSD Time Slot Starting Time":=WarehouseReceiptHeader."SSD Slot Starting Time";
                        // "SSD Time Slot Ending Time":=WarehouseReceiptHeader."SSD Slot Ending Time";
                        // "SSD Material Type":=WarehouseReceiptHeader."SSD Material Type";
                        InsertGateEntryLines(WarehouseReceiptHeader);
                    end;
                    //IG_DS   // "Entry Type"::Outward:
                    //     begin
                    //         WarehouseShipmentHeader.Get("SSD Planning No.");
                    //         "SSD Dock No." := WarehouseShipmentHeader."SSD Dock No.";
                    //         "SSD Time Slot No." := WarehouseShipmentHeader."SSD Slot No.";
                    //         "SSD Time Slot Starting Time" := WarehouseShipmentHeader."SSD Slot Starting Time";
                    //         "SSD Time Slot Ending Time" := WarehouseShipmentHeader."SSD Slot Ending Time";
                    //         InsertGateEntryLines(WarehouseShipmentHeader);
                    //         WarehouseShipmentHeader2.Reset();
                    //         WarehouseShipmentHeader2.SetRange("SSD Combined With", "SSD Planning No.");
                    //         if WarehouseShipmentHeader2.FindSet() then
                    //             repeat
                    //                 SkipLineCheck := true;
                    //                 InsertGateEntryLines((WarehouseShipmentHeader2));
                    //             until WarehouseShipmentHeader2.Next() = 0;
                    //         SkipLineCheck := false;
                    //     end;
                    end;
            end;
        }
        field(60050; "SSD Dock No."; Code[20])
        {
            Caption = 'Dock No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60051; "SSD Time Slot No."; Code[20])
        {
            Caption = 'Time Slot No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60052; "SSD Time Slot Starting Time"; Time)
        {
            Caption = 'Slot Starting Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60053; "SSD Time Slot Ending Time"; Time)
        {
            Caption = 'Slot Ending Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60054; "SSD Material Type";Enum "SSD Item Sub Type")
        {
            Caption = 'Material Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60092; "SSD Vehicle In"; MediaSet)
        {
            Caption = 'Vehicle In';
        }
        field(60102; "SSD Vehicle Out"; MediaSet)
        {
            Caption = 'Vehicle Out';
        }
        field(60112; "SSD Source Document"; MediaSet)
        {
            Caption = 'Source Document';
        }
    }
    trigger OnBeforeInsert()
    begin
        WMSManagement.CheckUserIsWhseEmployee();
    end;
    trigger OnAfterInsert()
    begin
        Validate("Location Code", SSDCommonFunctionAutomation.GetDefaultLocation());
        Modify(false);
    end;
    procedure ResetGateEntryLines()
    var
        GateEntryLine: Record "Gate Entry Line";
    begin
        GateEntryLine.SetRange("Entry Type", "Entry Type");
        GateEntryLine.SetRange("Gate Entry No.", "No.");
        if GateEntryLine.FindSet()then GateEntryLine.DeleteAll();
    end;
    local procedure InsertGateEntryLines(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        GateEntryLine: Record "Gate Entry Line";
        TempSSDWarehouseDocumentBuffer: Record "SSD Warehouse Document Buffer" temporary;
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        ConfirmTxt: Label 'Update Stopped';
        GateEntryLineExistsTxt: Label 'Gate Entry Lines already exists. If you proceed, existining lines will be deleted and recreated. Do you want to continue';
        PlanningLineErrTxt: Label 'Planning Line Type %1 is not allowed', Comment = '%1 = Warehouse Receipt Line Source Document Type';
    begin
        GateEntryLine.SetRange("Entry Type", "Entry Type");
        GateEntryLine.SetRange("Gate Entry No.", "No.");
        if not GateEntryLine.IsEmpty then if not Confirm(GateEntryLineExistsTxt, false)then Error(ConfirmTxt);
        ResetGateEntryLines();
        TempSSDWarehouseDocumentBuffer.Reset();
        if TempSSDWarehouseDocumentBuffer.FindSet()then TempSSDWarehouseDocumentBuffer.DeleteAll();
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.FindSet()then repeat case WarehouseReceiptLine."Source Document" of WarehouseReceiptLine."Source Document"::"Purchase Order", WarehouseReceiptLine."Source Document"::"Sales Return Order", WarehouseReceiptLine."Source Document"::"Inbound Transfer": if not TempSSDWarehouseDocumentBuffer.Get(WarehouseReceiptLine."Source Document", WarehouseReceiptLine."Source No.")then begin
                        GateEntryLine.Init();
                        GateEntryLine."Entry Type":="Entry Type";
                        GateEntryLine."Gate Entry No.":="No.";
                        GateEntryLine."Line No.":=WarehouseReceiptLine."Line No.";
                        GateEntryLine.Insert();
                        if WarehouseReceiptLine."Source Document" = WarehouseReceiptLine."Source Document"::"Purchase Order" then GateEntryLine.Validate("Source Type", GateEntryLine."Source Type"::"Purchase Order");
                        if WarehouseReceiptLine."Source Document" = WarehouseReceiptLine."Source Document"::"Sales Return Order" then GateEntryLine.Validate("Source Type", GateEntryLine."Source Type"::"Sales Return Order");
                        if WarehouseReceiptLine."Source Document" = WarehouseReceiptLine."Source Document"::"Inbound Transfer" then GateEntryLine.Validate("Source Type", GateEntryLine."Source Type"::"Transfer Receipt");
                        GateEntryLine.Validate("Source No.", WarehouseReceiptLine."Source No.");
                        GateEntryLine.Modify();
                        TempSSDWarehouseDocumentBuffer.Init();
                        TempSSDWarehouseDocumentBuffer."Source Document":=WarehouseReceiptLine."Source Document";
                        TempSSDWarehouseDocumentBuffer."Document No.":=WarehouseReceiptLine."Source No.";
                        if TempSSDWarehouseDocumentBuffer.Insert()then;
                    end;
                else
                    Error(PlanningLineErrTxt, WarehouseReceiptLine."Source Document");
                end;
            until WarehouseReceiptLine.Next() = 0;
    end;
    procedure InsertGateEntryLines(WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        GateEntryLine: Record "Gate Entry Line";
        TempSSDWarehouseDocumentBuffer: Record "SSD Warehouse Document Buffer" temporary;
        WarehouseShipmentLineLine: Record "Warehouse Shipment Line";
        LastLineNo: Integer;
        ConfirmTxt: Label 'Update Stopped';
        GateEntryLineExistsTxt: Label 'Gate Entry Lines already exists. If you proceed, existining lines will be deleted and recreated. Do you want to continue';
        PlanningLineErrTxt: Label 'Planning Line Type %1 is not allowed', Comment = '%1 = Warehouse Receipt Line Source Document Type';
    begin
        //IG_DS // if not SkipLineCheck then begin
        //     GateEntryLine.SetRange("Entry Type", "Entry Type");
        //     GateEntryLine.SetRange("Gate Entry No.", "No.");
        //     if not GateEntryLine.IsEmpty then if not Confirm(GateEntryLineExistsTxt, false) then Error(ConfirmTxt);
        //     ResetGateEntryLines();
        // end;
        TempSSDWarehouseDocumentBuffer.Reset();
        if TempSSDWarehouseDocumentBuffer.FindSet()then TempSSDWarehouseDocumentBuffer.DeleteAll();
        GateEntryLine.Reset();
        GateEntryLine.SetRange("Entry Type", "Entry Type");
        GateEntryLine.SetRange("Gate Entry No.", "No.");
        if GateEntryLine.FindLast()then LastLineNo:=GateEntryLine."Line No." + 10000
        else
            LastLineNo:=10000;
        WarehouseShipmentLineLine.SetRange("No.", WarehouseShipmentHeader."No.");
        if WarehouseShipmentLineLine.FindSet()then repeat case WarehouseShipmentLineLine."Source Document" of WarehouseShipmentLineLine."Source Document"::"Sales Order", WarehouseShipmentLineLine."Source Document"::"Purchase Return Order", WarehouseShipmentLineLine."Source Document"::"Outbound Transfer": if not TempSSDWarehouseDocumentBuffer.Get(WarehouseShipmentLineLine."Source Document", WarehouseShipmentLineLine."Source No.")then begin
                        GateEntryLine.Init();
                        GateEntryLine."Entry Type":="Entry Type";
                        GateEntryLine."Gate Entry No.":="No.";
                        GateEntryLine."Planning No.":=WarehouseShipmentLineLine."No.";
                        GateEntryLine."Line No.":=LastLineNo;
                        LastLineNo+=10000;
                        GateEntryLine.Insert();
                        if WarehouseShipmentLineLine."Source Document" = WarehouseShipmentLineLine."Source Document"::"Sales Order" then GateEntryLine.Validate("Source Type", GateEntryLine."Source Type"::"Sales Order");
                        if WarehouseShipmentLineLine."Source Document" = WarehouseShipmentLineLine."Source Document"::"Purchase Return Order" then GateEntryLine.Validate("Source Type", GateEntryLine."Source Type"::"Purchase Return Order");
                        if WarehouseShipmentLineLine."Source Document" = WarehouseShipmentLineLine."Source Document"::"Outbound Transfer" then GateEntryLine.Validate("Source Type", GateEntryLine."Source Type"::"Outbound Transfer");
                        GateEntryLine.Validate("Source No.", WarehouseShipmentLineLine."Source No.");
                        GateEntryLine.Modify();
                        TempSSDWarehouseDocumentBuffer.Init();
                        TempSSDWarehouseDocumentBuffer."Source Document":=WarehouseShipmentLineLine."Source Document";
                        TempSSDWarehouseDocumentBuffer."Document No.":=WarehouseShipmentLineLine."Source No.";
                        if TempSSDWarehouseDocumentBuffer.Insert()then;
                    end;
                else
                    Error(PlanningLineErrTxt, WarehouseShipmentLineLine."Source Document");
                end;
            until WarehouseShipmentLineLine.Next() = 0;
    end;
    var SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    WMSManagement: Codeunit "WMS Management";
    SkipLineCheck: Boolean;
}
