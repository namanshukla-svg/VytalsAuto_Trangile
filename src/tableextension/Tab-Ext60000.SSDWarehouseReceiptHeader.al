tableextension 60000 "SSD WarehouseReceipt Header" extends "Warehouse Receipt Header"
{
    DrillDownPageId = "Warehouse Receipts";

    fields
    {
        modify("Location Code")
        {
        trigger OnBeforeValidate()
        begin
            TestStatusOpen(Rec);
        end;
        }
        modify("Posting Date")
        {
        trigger OnBeforeValidate()
        begin
            TestStatusOpen(Rec);
        end;
        }
        field(62000; "SSD Dock No."; Code[20])
        {
            Caption = 'Dock No.';
            DataClassification = CustomerContent;
            TableRelation = "SSD Dock".Code where("Location Code"=field("Location Code"));

            trigger OnValidate()
            begin
                UpdateReceiptLine();
            end;
        }
        field(62001; "SSD Slot No."; Code[20])
        {
            Caption = 'Slot No.';
            DataClassification = CustomerContent;
            TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code"=field("Location Code"), "Dock No."=field("SSD Dock No."));

            trigger OnValidate()
            var
                SSDDockTimeSlots: Record "SSD Dock Time Slots";
            begin
                if SSDDockTimeSlots.Get("Location Code", "SSD Dock No.", "SSD Slot No.")then begin
                    "SSD Slot Starting Time":=SSDDockTimeSlots."Starting Time";
                    "SSD Slot Ending Time":=SSDDockTimeSlots."Ending Time";
                end
                else
                begin
                    "SSD Slot Starting Time":=0T;
                    "SSD Slot Ending Time":=0T;
                end;
                UpdateReceiptLine();
            end;
        }
        field(62002; "SSD Slot Starting Time"; Time)
        {
            Caption = 'Slot Starting Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62003; "SSD Slot Ending Time"; Time)
        {
            Caption = 'Slot Ending Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62004; "SSD Material Type";Enum "SSD Item Sub Type")
        {
            Caption = 'Material Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateReceiptLine();
            end;
        }
        field(62005; "SSD Status";Enum "SSD Receipt Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(62006; "SSD Source Name"; Text[100])
        {
            Caption = 'Source Name';
            Editable = false;
        }
        field(62007; "SSD Shipment Date"; Date)
        {
            Caption = 'Vendor Invoice Date';
        }
    }
    fieldgroups
    {
    addlast(DropDown;
    "No.", "SSD Source Name")
    {
    }
    }
    trigger OnBeforeDelete()
    var
        SSDDockManagement: Codeunit "SSD Dock Management";
    begin
        SSDDockManagement.CheckInwardDockLines(Rec);
    end;
    local procedure UpdateReceiptLine()
    var
        Item: Record Item;
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        ItemSubTypeErr: Label 'Item No. %1 %2 is %3 inventory. Material Type %4 cannot be set on this warehouse receipt', Comment = '%1 = Item No. %2 = Item Name %3 Item SubType, %4 Receipt Subtype ';
    begin
        TestStatusOpen(Rec);
        WarehouseReceiptLine.SetRange("No.", "No.");
        if WarehouseReceiptLine.FindSet()then repeat if WarehouseReceiptLine."SSD Dock No." <> "SSD Dock No." then WarehouseReceiptLine."SSD Dock No.":="SSD Dock No.";
                if WarehouseReceiptLine."SSD Slot No." <> "SSD Slot No." then begin
                    WarehouseReceiptLine."SSD Slot No.":="SSD Slot No.";
                    WarehouseReceiptLine."SSD Slot Starting Time":="SSD Slot Starting Time";
                    WarehouseReceiptLine."SSD Slot Ending Time":="SSD Slot Ending Time";
                end;
                Item.Get(WarehouseReceiptLine."Item No.");
                if Item."SSD Item SubType" <> "SSD Material Type" then Error(ItemSubTypeErr, Item."No.", Item.Description, Item."SSD Item SubType", Rec."SSD Material Type");
                if WarehouseReceiptLine."SSD Material Type" <> "SSD Material Type" then WarehouseReceiptLine."SSD Material Type":="SSD Material Type";
                WarehouseReceiptLine.Modify();
            until WarehouseReceiptLine.Next() = 0;
    end;
    procedure TestStatusOpen(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        WarehouseReceiptHeader.TestField("SSD Status", "SSD Status"::Open);
    end;
    procedure PlanWarehouseReceipt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        SSDDockManagement: Codeunit "SSD Dock Management";
        NothingtoScheduleErr: Label 'There is nothing to schedule';
    begin
        if WarehouseReceiptHeader."SSD Status" <> WarehouseReceiptHeader."SSD Status"::Open then exit;
        WarehouseReceiptLine.Reset();
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.IsEmpty then error(NothingtoScheduleErr);
        WarehouseReceiptHeader.TestField("Location Code");
        WarehouseReceiptHeader.TestField("Posting Date");
        WarehouseReceiptHeader.TestField("SSD Dock No.");
        WarehouseReceiptHeader.TestField("SSD Slot No.");
        WarehouseReceiptHeader.TestField("SSD Material Type");
        WarehouseReceiptHeader."SSD Status":=WarehouseReceiptHeader."SSD Status"::Planned;
        WarehouseReceiptHeader.Modify(true);
        SSDDockManagement.InsertDockLinesFromWhseRcptPlanning(WarehouseReceiptHeader);
    end;
    procedure ReleaseWarehouseReceipt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        if WarehouseReceiptHeader."SSD Status" <> WarehouseReceiptHeader."SSD Status"::Planned then exit;
        WarehouseReceiptHeader.TestField("Location Code");
        WarehouseReceiptHeader.TestField("Posting Date");
        WarehouseReceiptHeader.TestField("SSD Dock No.");
        WarehouseReceiptHeader.TestField("SSD Slot No.");
        WarehouseReceiptHeader.TestField("SSD Material Type");
        WarehouseReceiptHeader."SSD Status":=WarehouseReceiptHeader."SSD Status"::Released;
        WarehouseReceiptHeader.Modify(true);
    end;
    procedure ReOpenWarehouseReceipt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        GateEntryHeader: Record "Gate Entry Header";
        SSDDockManagement: Codeunit "SSD Dock Management";
        GateEntryExistErr: Label 'Open Gate Entry Inward %1 is linked with Warehouse Receipt. Remove Planning No. from Gate Entry', Comment = '%1 Gate Entry No.';
    begin
        if WarehouseReceiptHeader."SSD Status" = WarehouseReceiptHeader."SSD Status"::Open then exit;
        GateEntryHeader.SetRange("Entry Type", GateEntryHeader."Entry Type"::Inward);
        GateEntryHeader.SetRange("SSD Planning No.", WarehouseReceiptHeader."No.");
        if GateEntryHeader.FindFirst()then Error(GateEntryExistErr, GateEntryHeader."No.");
        SSDDockManagement.RemoveDockLinesonReceiptReopen(Rec);
        WarehouseReceiptHeader."SSD Status":=WarehouseReceiptHeader."SSD Status"::Open;
        WarehouseReceiptHeader.Modify(true);
    end;
}
