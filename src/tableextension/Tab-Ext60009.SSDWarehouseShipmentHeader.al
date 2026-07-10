tableextension 60009 "SSD Warehouse Shipment Header" extends "Warehouse Shipment Header"
{
    DrillDownPageId = "Warehouse Shipment";

    fields
    {
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                Validate("Posting Date", "Shipment Date");
            end;
        }
        // field(60000; "SSD Dock No."; Code[20])
        // {
        //     Caption = 'Dock No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Dock".Code where("Location Code"=field("Location Code"));

        //     trigger OnValidate()
        //     begin
        //         CheckCombinedShipment(Rec);
        //         UpdateShipmentLine();
        //     end;
        // }
        // field(60001; "SSD Slot No."; Code[20])
        // {
        //     Caption = 'Slot No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code"=field("Location Code"), "Dock No."=field("SSD Dock No."));

        //     trigger OnValidate()
        //     var
        //         SSDDockTimeSlots: Record "SSD Dock Time Slots";
        //     begin
        //         CheckCombinedShipment(Rec);
        //         if SSDDockTimeSlots.Get("Location Code", "SSD Dock No.", "SSD Slot No.")then begin
        //             "SSD Slot Starting Time":=SSDDockTimeSlots."Starting Time";
        //             "SSD Slot Ending Time":=SSDDockTimeSlots."Ending Time";
        //         end
        //         else
        //         begin
        //             "SSD Slot Starting Time":=0T;
        //             "SSD Slot Ending Time":=0T;
        //         end;
        //         UpdateShipmentLine();
        //     end;
        // }
        // field(60002; "SSD Slot Starting Time"; Time)
        // {
        //     Caption = 'Slot Starting Time';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        // field(60003; "SSD Slot Ending Time"; Time)
        // {
        //     Caption = 'Slot Ending Time';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        // field(60004; "SSD Material Type"; Enum "SSD Item Sub Type")
        // {
        //     Caption = 'Material Type';
        //     DataClassification = CustomerContent;

        //     trigger OnValidate()
        //     begin
        //         UpdateShipmentLine();
        //     end;
        // }
        // field(60005; "SSD Combined With"; Code[20])
        // {
        //     Caption = 'Combined With';
        //     DataClassification = CustomerContent;
        //     TableRelation = "Warehouse Shipment Header" where(Status=const(Released), "SSD Combined With"=const(''));

        //     trigger OnValidate()
        //     var
        //         WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        //         LinkedShipmentErr: Label 'Shipment have linked child shipment. It cannot be linked with other shipments';
        //         SameShipmentErr: Label 'You cannot choose same shipment for combining';
        //     begin
        //         if "No." = "SSD Combined With" then Error(SameShipmentErr);
        //         WarehouseShipmentHeader.SetRange("SSD Combined With", "No.");
        //         if not WarehouseShipmentHeader.IsEmpty then Error(LinkedShipmentErr);
        //         if WarehouseShipmentHeader.Get("SSD Combined With") and ("SSD Combined With" <> '')then begin
        //             SkipCheck:=true;
        //             Validate("SSD Dock No.", WarehouseShipmentHeader."SSD Dock No.");
        //             Validate("SSD Slot No.", WarehouseShipmentHeader."SSD Slot No.");
        //             SkipCheck:=false;
        //         end;
        //     end;
        // }
        field(60006; "SSD Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(60007; "SSD Mode of Transport"; Text[20])
        {
            Caption = 'Mode of Transport';
            DataClassification = CustomerContent;
        }
        field(60008; "SSD Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(60009; "Merged"; Boolean)
        {
            Caption = 'Merged';
            DataClassification = CustomerContent;
        }
        field(60010; "Outward gate Entry"; Boolean)
        {
            Editable = false;
            Caption = 'Outward gate Entry';
            FieldClass = FlowField;
            CalcFormula = exist("Gate Entry Line" where("Planning No." = field("No.")));
        }
        field(60011; "Posted Outward gate Entry"; Boolean)
        {
            Editable = false;
            Caption = 'Outward gate Entry';
            FieldClass = FlowField;
            CalcFormula = exist("Posted Gate Entry Line" where("Planning No." = field("No.")));
        }
    }
    local procedure CheckCombinedShipment(ShipmentHeader: Record "Warehouse Shipment Header")
    var
        CombinedShipmentHeader: Record "Warehouse Shipment Header";
    begin
        //   if ShipmentHeader."SSD Combined With" = '' then exit;
        if SkipCheck then exit;
        //  CombinedShipmentHeader.Get(ShipmentHeader."SSD Combined With");
        // ShipmentHeader.TestField("SSD Dock No.", CombinedShipmentHeader."SSD Dock No.");
        // ShipmentHeader.TestField("SSD Slot No.", CombinedShipmentHeader."SSD Slot No.");
    end;

    // local procedure UpdateShipmentLine()
    // var
    //     WarehouseShipmentLine: Record "Warehouse Shipment Line";
    // begin
    //     TestField(Status, Status::Open);
    //     WarehouseShipmentLine.SetRange("No.", "No.");
    //     if WarehouseShipmentLine.FindSet() then
    //         repeat
    //             if WarehouseShipmentLine."SSD Dock No." <> "SSD Dock No." then
    //                 WarehouseShipmentLine."SSD Dock No." := "SSD Dock No.";
    //             if WarehouseShipmentLine."SSD Slot No." <> "SSD Slot No." then begin
    //                 WarehouseShipmentLine."SSD Slot No." := "SSD Slot No.";
    //                 WarehouseShipmentLine."SSD Slot Starting Time" := "SSD Slot Starting Time";
    //                 WarehouseShipmentLine."SSD Slot Ending Time" := "SSD Slot Ending Time";
    //             end;
    //             if WarehouseShipmentLine."SSD Material Type" <> "SSD Material Type" then
    //                 WarehouseShipmentLine."SSD Material Type" := "SSD Material Type";
    //             WarehouseShipmentLine.Modify();
    //         until WarehouseShipmentLine.Next() = 0;
    // end;

    trigger OnAfterInsert()
    begin
        "Shipment Method Code" := 'DAP';
        "SSD Transport Method" := 'SURFACE';
        "SSD Mode of Transport" := 'ROAD';
    end;

    var
        SkipCheck: Boolean;
}
